import { useEffect, useRef, useState } from "react";
import type { FeaturedCreator, LandingTrack } from "../../types";
import { ArrowIcon, HeadphonesIcon, HeartFillIcon, HeartIcon, PauseIcon, PlayIcon, PlusIcon, QueueIcon } from "../../icons";
import { useFavorites } from "../../context/FavoritesContext";
import { usePlayer } from "../../context/PlayerContext";
import { usePlaylists } from "../../context/PlaylistContext";

const compactNumber = (value: number) =>
  new Intl.NumberFormat("en-US", { notation: "compact", maximumFractionDigits: 1 }).format(value);

type TrackCardProps = {
  track: LandingTrack;
  active: boolean;
  playing: boolean;
  onPlay: (track: LandingTrack) => void;
  onNavigate: (route: string) => void;
  rank?: number;
};

export function TrackCard({ track, active, playing, onPlay, onNavigate, rank }: TrackCardProps) {
  const { isFavorite, toggleFavorite } = useFavorites();
  const { addToQueue } = usePlayer();
  const { playlists, addTrackToPlaylist, showToast } = usePlaylists();
  const [playlistMenuOpen, setPlaylistMenuOpen] = useState(false);
  const menuRef = useRef<HTMLDivElement>(null);
  const favorited = isFavorite(track.id);

  useEffect(() => {
    if (!playlistMenuOpen) return;
    const handleClickOutside = (e: MouseEvent) => {
      if (!menuRef.current?.contains(e.target as Node)) {
        setPlaylistMenuOpen(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [playlistMenuOpen]);

  const handleFavorite = async (e: React.MouseEvent) => {
    e.stopPropagation();
    try {
      await toggleFavorite(track.id);
      showToast(favorited ? `Removed "${track.title}" from favorites` : `Added "${track.title}" to favorites`);
    } catch {
      showToast("Please log in with a Listener account to favorite tracks.");
    }
  };

  const handleQueue = (e: React.MouseEvent) => {
    e.stopPropagation();
    addToQueue(track);
    showToast(`Added "${track.title}" to queue`);
  };

  const handlePlaylistClick = (e: React.MouseEvent) => {
    e.stopPropagation();
    setPlaylistMenuOpen((prev) => !prev);
  };

  return (
    <article className={`sw-track-card ${active ? "sw-track-card--active" : ""}`}>
      <div className="sw-track-cover-wrap">
        <button className="sw-track-cover" onClick={() => onPlay(track)} aria-label={playing ? `Pause ${track.title}` : `Play ${track.title}`}>
          <img src={track.coverUrl ?? undefined} alt="" loading="lazy" />
          {rank ? <span className="sw-track-rank">#{rank}</span> : null}
          <span className="sw-track-play">{playing ? <PauseIcon width={19} height={19} /> : <PlayIcon width={19} height={19} />}</span>
          {playing ? <span className="sw-playing-bars" aria-hidden="true"><i /><i /><i /></span> : null}
        </button>

        {/* Quick action overlay buttons */}
        <div className="sw-card-quick-actions" onClick={(e) => e.stopPropagation()}>
          <button
            type="button"
            className={`sw-card-action-btn ${favorited ? "is-favorite" : ""}`}
            onClick={handleFavorite}
            title={favorited ? "Remove from favorites" : "Favorite track"}
            aria-label={favorited ? "Remove from favorites" : "Favorite track"}
          >
            {favorited ? <HeartFillIcon width={14} height={14} /> : <HeartIcon width={14} height={14} />}
          </button>
          <button
            type="button"
            className="sw-card-action-btn"
            onClick={handleQueue}
            title="Add to queue"
            aria-label="Add to queue"
          >
            <QueueIcon width={14} height={14} />
          </button>
          <div style={{ position: "relative" }} ref={menuRef}>
            <button
              type="button"
              className="sw-card-action-btn"
              onClick={handlePlaylistClick}
              title="Add to playlist"
              aria-label="Add to playlist"
            >
              <PlusIcon width={14} height={14} />
            </button>
            {playlistMenuOpen && (
              <div className="sw-card-playlist-dropdown">
                <div className="sw-card-playlist-title">Add to playlist</div>
                {playlists.length > 0 ? (
                  playlists.map((pl) => (
                    <button
                      key={pl.id}
                      type="button"
                      className="sw-card-playlist-item"
                      onClick={() => {
                        void addTrackToPlaylist(pl.id, track.id);
                        setPlaylistMenuOpen(false);
                      }}
                    >
                      {pl.title}
                    </button>
                  ))
                ) : (
                  <button
                    type="button"
                    className="sw-card-playlist-item"
                    onClick={() => {
                      setPlaylistMenuOpen(false);
                      onNavigate("/playlists");
                    }}
                  >
                    + Create playlist
                  </button>
                )}
              </div>
            )}
          </div>
        </div>
      </div>

      <div className="sw-card-copy">
        <a href={`#/track/${track.id}`} className="sw-card-title" onClick={(event) => { event.preventDefault(); onNavigate(`/track/${track.id}`); }}>{track.title}</a>
        <a href={`#/creator/${track.creator?.userId}`} className="sw-card-subtitle" onClick={(event) => { event.preventDefault(); if (track.creator?.userId) onNavigate(`/creator/${track.creator.userId}`); }}>{track.creator?.displayName || "Artist"}</a>
        <span className="sw-card-meta"><HeadphonesIcon width={13} height={13} /> {compactNumber(track.playCount)} plays</span>
      </div>
    </article>
  );
}


export function CreatorCard({ creator, onNavigate }: { creator: FeaturedCreator; onNavigate: (route: string) => void }) {
  return (
    <article className="sw-creator-card">
      <button className="sw-creator-avatar" onClick={() => onNavigate(`/creator/${creator.userId}`)} aria-label={`Open ${creator.displayName}'s profile`}><img src={creator.avatarUrl} alt="" loading="lazy" /></button>
      <div>
        <a href={`#/creator/${creator.userId}`} className="sw-card-title" onClick={(event) => { event.preventDefault(); onNavigate(`/creator/${creator.userId}`); }}>{creator.displayName}</a>
        <p>{creator.bio}</p>
        <span>{creator.publishedTracks} tracks · {compactNumber(creator.followersCount ?? 0)} followers</span>
      </div>
      <button className="sw-follow-button" onClick={() => onNavigate(`/creator/${creator.userId}`)}>View profile</button>
    </article>
  );
}

export function SectionHeader({ title, description, actionLabel, onAction }: { title: string; description?: string; actionLabel?: string; onAction?: () => void }) {
  return (
    <div className="sw-section-heading">
      <div><h2>{title}</h2>{description ? <p>{description}</p> : null}</div>
      {actionLabel && onAction ? <button onClick={onAction}>{actionLabel}<ArrowIcon width={16} height={16} /></button> : null}
    </div>
  );
}
