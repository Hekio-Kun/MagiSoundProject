import type { ReactNode } from "react";
import { MagiSoundFooter } from "../components/layout/MagiSoundFooter";
import { MagiSoundHeader } from "../components/layout/MagiSoundHeader";

type Props = {
  children: ReactNode;
  isAuthenticated: boolean;
  hasPlayer: boolean;
};

export function MarketingLayout({ children, isAuthenticated, hasPlayer }: Props) {
  return (
    <div className={`marketing-layout ${hasPlayer ? "app--with-player" : ""}`}>
      <MagiSoundHeader isAuthenticated={isAuthenticated} hasPlayer={hasPlayer} />
      <div className="marketing-content">
        {children}
      </div>
      <MagiSoundFooter hasPlayer={hasPlayer} isAuthenticated={isAuthenticated} />
    </div>
  );
}
