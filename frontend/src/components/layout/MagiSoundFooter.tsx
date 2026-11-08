import { MagiSoundLogo } from "./MagiSoundHeader";

type Props = {
  hasPlayer: boolean;
  isAuthenticated: boolean;
};

export function MagiSoundFooter({ hasPlayer, isAuthenticated }: Props) {
  return (
    <footer className={`site-footer ${hasPlayer ? "site-footer--player" : ""}`}>
      <div className="container footer-grid">
        <div className="footer-brand">
          <MagiSoundLogo />
          <p>Experience the magic of sound — stream high-fidelity tracks, follow rising creators, and curate your audio universe.</p>
          <span>SWD392 · Group 03 - TREEH</span>
        </div>
        <div>
          <h3>Explore</h3>
          <a href="#/">Trending Tracks</a>
          <a href="#/browse">Browse Catalog</a>
          <a href="#/genres">Genres</a>
        </div>
        <div>
          <h3>Account</h3>
          <a href="#/login">Sign in</a>
          <a href="#/register">Register</a>
          {isAuthenticated && <a href="#/studio">Creator Studio</a>}
        </div>
        <div>
          <h3>Community</h3>
          <a href="#/terms">Terms of service</a>
          <a href="#/privacy">Privacy policy</a>
          <a href="#/contact">Feedback and Support</a>
        </div>
      </div>
      <div className="container footer-bottom">
        <span>© 2026 MagiSound Platform. SWD392 course project by Group 03 - TREEH.</span>
        <span>Crafted for true audiophiles.</span>
      </div>
    </footer>
  );
}
