import { useEffect, useMemo, useState } from "react";
import { CreatorCard, TrackCard } from "../components/common/MusicCards";
import { featuredCreators, tracks } from "../data";
import { catalogApi } from "../api/catalog";
import { SearchIcon, TrendingUpIcon } from "../icons";
import type { LandingTrack } from "../types";

type Props = {
  currentTrack: LandingTrack | null;
  playing: boolean;
  onPlayTrack: (track: LandingTrack, contextQueue?: LandingTrack[], contextTitle?: string) => void;
  onNavigate: (route: string) => void;
  initialQuery?: string;
};

export function SearchPage({ currentTrack, playing, onPlayTrack, onNavigate, initialQuery = "" }: Props) {
  const [searchTerm, setSearchTerm] = useState(initialQuery);
  const [activeFilter, setActiveFilter] = useState<"all" | "tracks" | "" | "creators">("all");
  const [serverTracks, setServerTracks] = useState<LandingTrack[]>([]);

  useEffect(() => {
    setSearchTerm(initialQuery);
  }, [initialQuery]);

  useEffect(() => {
    catalogApi.getTracks({ size: 100 })
      .then((res) => {
        if (res?.content) setServerTracks(res.content);
      })
      .catch(() => {});
  }, []);

  const allSearchableTracks = useMemo(() => {
    const isPublic = (t: LandingTrack) =>
      t.publicationStatus === "APPROVED" || t.publicationStatus === "PUBLISHED";
    const serverIds = new Set(serverTracks.map((t) => t.id));
    const fallbackMocks = tracks.filter((t) => !serverIds.has(t.id));
    return [...serverTracks, ...fallbackMocks].filter(isPublic);
  }, [serverTracks]);

  const query = searchTerm.trim().toLowerCase();

  useEffect(() => setActiveFilter("all"), [query]);

  const matchedTracks = useMemo(() => {
    if (!query) return [];
    return allSearchableTracks.filter(
      (t) =>
        t.title.toLowerCase().includes(query) ||
        (t.slug && t.slug.toLowerCase().includes(query)) ||
        t.creator.displayName.toLowerCase().includes(query) ||
        (t.genreSlug?.toLowerCase().includes(query) ?? false) ||
        (t.album?.title?.toLowerCase().includes(query) ?? false)
    );
  }, [allSearchableTracks, query]);



  const matchedCreators = useMemo(() => {
    if (!query) return [];
    return featuredCreators.filter(
      (c) => c.displayName.toLowerCase().includes(query) || c.bio.toLowerCase().includes(query)
    );
  }, [query]);

  const hasResults = matchedTracks.length > 0 || matchedCreators.length > 0;
  const resultCount = matchedTracks.length + matchedCreators.length;
  const quickSearches = ["Sơn Tùng M-TP", "HIEUTHUHAI", "MCK", "YOASOBI", "Pop", "Acoustic"];

  return (
    <div className="search-page">
      {query && (
        <div className="search-toolbar">
          <div className="search-result-summary"><strong>{resultCount}</strong><span>results for “{searchTerm.trim()}”</span></div>
          <div className="search-tabs" role="tablist" aria-label="Search result types">
          <button
            className={`search-tab-pill ${activeFilter === "all" ? "search-tab-pill--active" : ""}`}
            onClick={() => setActiveFilter("all")}
            role="tab"
            aria-selected={activeFilter === "all"}
          >
            All <span>{resultCount}</span>
          </button>
          <button
            className={`search-tab-pill ${activeFilter === "tracks" ? "search-tab-pill--active" : ""}`}
            onClick={() => setActiveFilter("tracks")}
            role="tab"
            aria-selected={activeFilter === "tracks"}
          >
            Tracks <span>{matchedTracks.length}</span>
          </button>
          <button
            className={`search-tab-pill ${activeFilter === "creators" ? "search-tab-pill--active" : ""}`}
            onClick={() => setActiveFilter("creators")}
            role="tab"
            aria-selected={activeFilter === "creators"}
          >
            Creators <span>{matchedCreators.length}</span>
          </button>
          </div>
        </div>
      )}

      {!query ? (
        <div className="search-prompt-state">
          <span className="search-prompt-icon"><TrendingUpIcon width={25} height={25} /></span>
          <div>
            <span className="search-prompt-label">TRENDING SEARCH</span>
            <h2>Start with what listeners love today</h2>
            <p>Use the search bar on the top header or choose a popular search topic below.</p>
            <div style={{ display: "flex", flexWrap: "wrap", gap: "8px", marginTop: "12px" }}>
              {quickSearches.map((keyword) => (
                <button
                  key={keyword}
                  type="button"
                  onClick={() => setSearchTerm(keyword)}
                  style={{
                    padding: "6px 14px",
                    borderRadius: "999px",
                    border: "1px solid #e2e8f0",
                    background: "#ffffff",
                    fontSize: "12px",
                    fontWeight: 600,
                    color: "#334155",
                    cursor: "pointer",
                  }}
                >
                  {keyword}
                </button>
              ))}
            </div>
          </div>
        </div>
      ) : !hasResults ? (
        <div className="state-empty-box">
          <span className="search-empty-icon"><SearchIcon width={26} height={26} /></span>
          <p className="empty-title">No results found for "{searchTerm}"</p>
          <p className="empty-desc">Check the spelling or try a shorter keyword.</p>
          <button className="button button-secondary" onClick={() => setSearchTerm("")}>Clear search</button>
        </div>
      ) : (
        <div className="search-results-container">
          {(activeFilter === "all" || activeFilter === "tracks") && matchedTracks.length > 0 && (
            <section className="search-result-section">
              <div className="search-section-heading"><div><span>SONGS</span><h2>Matching tracks</h2></div><small>{matchedTracks.length} found</small></div>
              <div className="sw-track-grid sw-track-grid--catalog">
                {matchedTracks.map((track) => (
                  <TrackCard
                    key={track.id}
                    track={track}
                    active={currentTrack?.id === track.id}
                    playing={currentTrack?.id === track.id && playing}
                    onPlay={(t) =>
                      onPlayTrack(
                        t,
                        matchedTracks,
                        searchTerm ? `Search • "${searchTerm}"` : "Search results"
                      )
                    }
                    onNavigate={onNavigate}
                  />
                ))}
              </div>
            </section>
          )}

          {(activeFilter === "all" || activeFilter === "creators") && matchedCreators.length > 0 && (
            <section className="search-result-section">
              <div className="search-section-heading"><div><span>PEOPLE</span><h2>Matching creators</h2></div><small>{matchedCreators.length} found</small></div>
              <div className="sw-creator-grid">
                {matchedCreators.map((creator) => <CreatorCard key={creator.userId} creator={creator} onNavigate={onNavigate} />)}
              </div>
            </section>
          )}
        </div>
      )}
    </div>
  );
}
