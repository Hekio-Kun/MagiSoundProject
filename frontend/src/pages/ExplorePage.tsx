import { useCallback, useEffect, useMemo, useState } from "react";
import { featuredCreators, genres as initialGenres, projectTracks } from "../data";
import { catalogApi } from "../api/catalog";
import { ArrowIcon, PauseIcon, PlayIcon } from "../icons";
import type { Genre, LandingTrack } from "../types";

type Props = {
  currentTrack: LandingTrack | null;
  playing: boolean;
  onPlayTrack: (track: LandingTrack, contextQueue?: LandingTrack[], contextTitle?: string) => void;
  onNavigate: (route: string) => void;
};

const formatDuration = (ms: number) => {
  const minutes = Math.floor(ms / 60000);
  const seconds = Math.floor((ms % 60000) / 1000);
  return `${minutes}:${seconds.toString().padStart(2, "0")}`;
};

const compactNumber = (value: number) =>
  new Intl.NumberFormat("en-US", { notation: "compact", maximumFractionDigits: 1 }).format(value);

const getGreeting = () => {
  const hour = new Date().getHours();
  if (hour < 12) return "Good morning";
  if (hour < 18) return "Good afternoon";
  return "Good evening";
};

export function ExplorePage({ currentTrack, playing, onPlayTrack, onNavigate }: Props) {
  const [genresList, setGenresList] = useState<Genre[]>(initialGenres);
  const [catalogTracks, setCatalogTracks] = useState<LandingTrack[]>([]);
  const [trendingTracks, setTrendingTracks] = useState<LandingTrack[]>([]);
  const [tracksLoading, setTracksLoading] = useState<boolean>(true);

  const greeting = useMemo(() => getGreeting(), []);

  const loadExploreTracks = useCallback(async () => {
    try {
      setTracksLoading(true);
      const [trendingResponse, newestResponse] = await Promise.all([
        catalogApi.getTracks({ sort: "trending", page: 0, size: 8 }),
        catalogApi.getTracks({ sort: "newest", page: 0, size: 10 }),
      ]);

      const trending = trendingResponse?.content && trendingResponse.content.length > 0
        ? trendingResponse.content
        : projectTracks;

      const newest = newestResponse?.content && newestResponse.content.length > 0
        ? newestResponse.content
        : projectTracks;

      setTrendingTracks(trending);
      setCatalogTracks(newest);
    } catch {
      // Backend catalog API offline: gracefully fallback to project master tracks
      setTrendingTracks(projectTracks);
      setCatalogTracks(projectTracks);
    } finally {
      setTracksLoading(false);
    }
  }, []);

  useEffect(() => {
    catalogApi.getGenres()
      .then((data) => {
        if (data && data.length > 0) {
          setGenresList(data);
        }
      })
      .catch(() => {
        setGenresList(initialGenres);
      });
  }, []);

  useEffect(() => {
    void loadExploreTracks();
  }, [loadExploreTracks]);

  // 6 Quick Access items for Spotify-style top shelf
  const quickAccessTracks = useMemo(() => {
    const list = trendingTracks.length >= 6 ? trendingTracks : projectTracks;
    return list.slice(0, 6);
  }, [trendingTracks]);

  // Trending Shelf tracks (top 5)
  const trendingShelfTracks = useMemo(() => {
    const list = trendingTracks.length > 0 ? trendingTracks : projectTracks;
    return list.slice(0, 5);
  }, [trendingTracks]);

  // New Releases Shelf tracks (top 5)
  const newReleasesShelfTracks = useMemo(() => {
    const list = catalogTracks.length > 0 ? catalogTracks : projectTracks;
    return list.slice(0, 5);
  }, [catalogTracks]);

  // Popular Artists shelf: dynamically derived from creators present in catalog, fallback to featuredCreators
  const popularArtists = useMemo(() => {
    const map = new Map<number, { userId: number; displayName: string; avatarUrl: string; bio: string; publishedTracks: number; followersCount: number }>();
    for (const track of [...trendingTracks, ...catalogTracks]) {
      if (track.creator && track.creator.userId && !map.has(track.creator.userId)) {
        const existingFeatured = featuredCreators.find((f) => f.userId === track.creator.userId);
        map.set(track.creator.userId, {
          userId: track.creator.userId,
          displayName: track.creator.displayName || "Artist",
          avatarUrl: track.creator.avatarUrl || track.coverUrl || "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80",
          bio: existingFeatured?.bio || "Verified creator on MagiSound.",
          publishedTracks: existingFeatured?.publishedTracks || 1,
          followersCount: existingFeatured?.followersCount || 45000,
        });
      }
    }
    const fromTracks = Array.from(map.values());
    if (fromTracks.length >= 5) {
      return fromTracks.slice(0, 5);
    }
    return featuredCreators.slice(0, 5);
  }, [trendingTracks, catalogTracks]);

  return (
    <div className="sp-explore-page" aria-label="MagiSound Explore">
      {/* 1. Spotify Greeting Header */}
      <header className="sp-greeting-header">
        <h1 className="sp-greeting-title">{greeting}</h1>
        <p className="sp-greeting-sub">Welcome to MagiSound · High-fidelity music streaming</p>
      </header>

      {/* 2. Spotify Quick Access Grid (6 Items in 2x3 Grid) */}
      <section className="sp-quick-grid" aria-label="Quick Access">
        {quickAccessTracks.map((track) => {
          const isActive = currentTrack?.id === track.id;
          const isThisPlaying = isActive && playing;

          return (
            <div
              key={track.id}
              className={`sp-quick-card ${isActive ? "sp-quick-card--active" : ""}`}
              onClick={() => onPlayTrack(track, quickAccessTracks, "Quick Access")}
              role="button"
              tabIndex={0}
              onKeyDown={(e) => {
                if (e.key === "Enter" || e.key === " ") {
                  e.preventDefault();
                  onPlayTrack(track, quickAccessTracks, "Quick Access");
                }
              }}
              aria-label={`Play ${track.title}`}
            >
              <img
                src={track.coverUrl ?? undefined}
                alt=""
                className="sp-quick-cover"
                loading="eager"
              />
              <div className="sp-quick-info">
                <span className="sp-quick-title">{track.title}</span>
                <span className="sp-quick-artist">{track.creator?.displayName || "Artist"}</span>
              </div>
              <button
                className={`sp-quick-play ${isThisPlaying ? "is-playing" : ""}`}
                onClick={(e) => {
                  e.stopPropagation();
                  onPlayTrack(track, quickAccessTracks, "Quick Access");
                }}
                aria-label={isThisPlaying ? `Pause ${track.title}` : `Play ${track.title}`}
              >
                {isThisPlaying ? (
                  <PauseIcon width={16} height={16} />
                ) : (
                  <PlayIcon width={16} height={16} />
                )}
              </button>
            </div>
          );
        })}
      </section>

      {/* 3. Section: Trending Now (Today's Biggest Hits) */}
      <section className="sp-section" aria-labelledby="trending-heading">
        <div className="sp-section-header">
          <div>
            <h2 id="trending-heading" className="sp-section-title">Trending Now</h2>
            <p className="sp-section-desc">The most played tracks on MagiSound today</p>
          </div>
          <button
            className="sp-see-all"
            onClick={() => onNavigate("/browse?sort=trending")}
          >
            Show all
          </button>
        </div>

        <div className="sp-shelf-grid">
          {trendingShelfTracks.map((track) => {
            const isActive = currentTrack?.id === track.id;
            const isThisPlaying = isActive && playing;

            return (
              <article
                key={track.id}
                className={`sp-track-card ${isActive ? "sp-track-card--active" : ""}`}
                onClick={() => onPlayTrack(track, trendingShelfTracks, "Trending Now")}
              >
                <div className="sp-cover-wrap">
                  <img
                    src={track.coverUrl ?? undefined}
                    alt=""
                    className="sp-cover-img"
                    loading="lazy"
                  />
                  <button
                    className={`sp-floating-play ${isThisPlaying ? "is-playing" : ""}`}
                    onClick={(e) => {
                      e.stopPropagation();
                      onPlayTrack(track, trendingShelfTracks, "Trending Now");
                    }}
                    aria-label={isThisPlaying ? `Pause ${track.title}` : `Play ${track.title}`}
                  >
                    {isThisPlaying ? (
                      <PauseIcon width={20} height={20} />
                    ) : (
                      <PlayIcon width={20} height={20} />
                    )}
                  </button>
                </div>

                <div className="sp-card-body">
                  <a
                    href={`#/track/${track.id}`}
                    className="sp-card-title"
                    onClick={(e) => {
                      e.preventDefault();
                      e.stopPropagation();
                      onNavigate(`/track/${track.id}`);
                    }}
                  >
                    {track.title}
                  </a>
                  <a
                    href={`#/creator/${track.creator?.userId}`}
                    className="sp-card-subtitle"
                    onClick={(e) => {
                      e.preventDefault();
                      e.stopPropagation();
                      if (track.creator?.userId) onNavigate(`/creator/${track.creator.userId}`);
                    }}
                  >
                    {track.creator?.displayName || "Artist"}
                  </a>
                  <div className="sp-card-meta">
                    <span>{compactNumber(track.playCount)} plays</span>
                    <span>{formatDuration(track.durationMs)}</span>
                  </div>
                </div>
              </article>
            );
          })}
        </div>
      </section>

      {/* 4. Section: New Releases */}
      <section className="sp-section" aria-labelledby="new-releases-heading">
        <div className="sp-section-header">
          <div>
            <h2 id="new-releases-heading" className="sp-section-title">New Releases</h2>
            <p className="sp-section-desc">Freshly published master tracks from verified creators</p>
          </div>
          <button
            className="sp-see-all"
            onClick={() => onNavigate("/browse?sort=newest")}
          >
            Show all
          </button>
        </div>

        <div className="sp-shelf-grid">
          {newReleasesShelfTracks.map((track) => {
            const isActive = currentTrack?.id === track.id;
            const isThisPlaying = isActive && playing;

            return (
              <article
                key={track.id}
                className={`sp-track-card ${isActive ? "sp-track-card--active" : ""}`}
                onClick={() => onPlayTrack(track, newReleasesShelfTracks, "New Releases")}
              >
                <div className="sp-cover-wrap">
                  <img
                    src={track.coverUrl ?? undefined}
                    alt=""
                    className="sp-cover-img"
                    loading="lazy"
                  />
                  <button
                    className={`sp-floating-play ${isThisPlaying ? "is-playing" : ""}`}
                    onClick={(e) => {
                      e.stopPropagation();
                      onPlayTrack(track, newReleasesShelfTracks, "New Releases");
                    }}
                    aria-label={isThisPlaying ? `Pause ${track.title}` : `Play ${track.title}`}
                  >
                    {isThisPlaying ? (
                      <PauseIcon width={20} height={20} />
                    ) : (
                      <PlayIcon width={20} height={20} />
                    )}
                  </button>
                </div>

                <div className="sp-card-body">
                  <a
                    href={`#/track/${track.id}`}
                    className="sp-card-title"
                    onClick={(e) => {
                      e.preventDefault();
                      e.stopPropagation();
                      onNavigate(`/track/${track.id}`);
                    }}
                  >
                    {track.title}
                  </a>
                  <a
                    href={`#/creator/${track.creator?.userId}`}
                    className="sp-card-subtitle"
                    onClick={(e) => {
                      e.preventDefault();
                      e.stopPropagation();
                      if (track.creator?.userId) onNavigate(`/creator/${track.creator.userId}`);
                    }}
                  >
                    {track.creator?.displayName || "Artist"}
                  </a>
                  <div className="sp-card-meta">
                    <span>{track.genreName || "Hi-Res Audio"}</span>
                    <span>{formatDuration(track.durationMs)}</span>
                  </div>
                </div>
              </article>
            );
          })}
        </div>
      </section>

      {/* 5. Section: Popular Artists (Circular Spotify Avatars) */}
      <section className="sp-section" aria-labelledby="artists-heading">
        <div className="sp-section-header">
          <div>
            <h2 id="artists-heading" className="sp-section-title">Popular Artists</h2>
            <p className="sp-section-desc">Creators shaping today's favorite sounds</p>
          </div>
          <button
            className="sp-see-all"
            onClick={() => onNavigate("/browse")}
          >
            Show all
          </button>
        </div>

        <div className="sp-shelf-grid">
          {popularArtists.map((creator) => (
            <article
              key={creator.userId}
              className="sp-artist-card"
              onClick={() => onNavigate(`/creator/${creator.userId}`)}
              role="button"
              tabIndex={0}
              onKeyDown={(e) => {
                if (e.key === "Enter" || e.key === " ") {
                  e.preventDefault();
                  onNavigate(`/creator/${creator.userId}`);
                }
              }}
              aria-label={`View ${creator.displayName}'s profile`}
            >
              <div className="sp-artist-avatar-wrap">
                <img
                  src={creator.avatarUrl}
                  alt=""
                  className="sp-artist-avatar"
                  loading="lazy"
                />
                <button
                  className="sp-floating-play"
                  onClick={(e) => {
                    e.stopPropagation();
                    onNavigate(`/creator/${creator.userId}`);
                  }}
                  aria-label={`View profile for ${creator.displayName}`}
                >
                  <ArrowIcon width={18} height={18} />
                </button>
              </div>

              <div className="sp-card-body" style={{ alignItems: "center", textAlign: "center" }}>
                <span className="sp-card-title">{creator.displayName}</span>
                <span className="sp-card-subtitle">
                  Artist · {compactNumber(creator.followersCount ?? 0)} followers
                </span>
              </div>
            </article>
          ))}
        </div>
      </section>

      {/* 6. Section: Browse Categories */}
      <section className="sp-section" aria-labelledby="genres-heading">
        <div className="sp-section-header">
          <div>
            <h2 id="genres-heading" className="sp-section-title">Browse Categories</h2>
            <p className="sp-section-desc">Explore music tailored to your vibe and mood</p>
          </div>
          <button
            className="sp-see-all"
            onClick={() => onNavigate("/genres")}
          >
            Show all
          </button>
        </div>

        <div className="sp-genre-grid">
          {genresList.slice(0, 6).map((genre) => (
            <button
              key={genre.id || genre.slug}
              className="sp-genre-card"
              onClick={() => onNavigate(`/browse?genre=${genre.slug}`)}
            >
              <span className="sp-genre-title">{genre.name}</span>
              <span className="sp-genre-desc">{genre.description || `Explore ${genre.name}`}</span>
            </button>
          ))}
        </div>
      </section>
    </div>
  );
}
