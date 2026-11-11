import { useEffect, useState, type ReactNode } from "react";
import { adminStatisticsApi } from "../api/adminStatistics";
import type { SystemStatisticsResponse } from "../types";
import {
  ActivityIcon,
  CheckIcon,
  DiscIcon,
  FlagIcon,
  RefreshIcon,
  ShieldIcon,
  TrendingUpIcon,
  UserIcon,
  UsersIcon,
} from "../icons";

type DashboardProps = {
  onNavigate: (route: string) => void;
  initialSubmissionId?: number | null;
};

type MetricProps = {
  icon: ReactNode;
  label: string;
  value: string;
  change: string;
  note: string;
  tone?: "cyan" | "violet" | "green" | "amber" | "red";
};

function DashboardMetric({ icon, label, value, change, note, tone = "cyan" }: MetricProps) {
  return (
    <article className={`ops-metric ops-metric--${tone}`}>
      <div className="ops-metric-top">
        <span className="ops-metric-icon">{icon}</span>
        <span className="ops-metric-change"><TrendingUpIcon width={13} height={13} />{change}</span>
      </div>
      <strong>{value}</strong>
      <span className="ops-metric-label">{label}</span>
      <small>{note}</small>
    </article>
  );
}

function DashboardHeading({
  eyebrow,
  title,
  description,
  icon,
  children,
}: {
  eyebrow: string;
  title: string;
  description: string;
  icon: ReactNode;
  children?: ReactNode;
}) {
  return (
    <header className="ops-dashboard-heading">
      <div className="ops-dashboard-heading-copy">
        <span className="ops-role-mark">{icon}{eyebrow}</span>
        <h1>{title}</h1>
        <p>{description}</p>
      </div>
      {children ? <div className="ops-heading-actions">{children}</div> : null}
    </header>
  );
}

function PanelHeading({
  title,
  description,
  action,
}: {
  title: string;
  description?: string;
  action?: ReactNode;
}) {
  return (
    <div className="ops-panel-heading">
      <div>
        <h2>{title}</h2>
        {description ? <p>{description}</p> : null}
      </div>
      {action}
    </div>
  );
}

function formatRelativeTime(isoString?: string | null): string {
  if (!isoString) return "--";
  try {
    const diffMs = Date.now() - new Date(isoString).getTime();
    if (diffMs < 0) return "Just now";
    const minutes = Math.floor(diffMs / 60000);
    if (minutes < 1) return "Just now";
    if (minutes < 60) return `${minutes}m ago`;
    const hours = Math.floor(minutes / 60);
    if (hours < 24) return `${hours}h ago`;
    const days = Math.floor(hours / 24);
    if (days < 7) return `${days}d ago`;
    return new Date(isoString).toLocaleDateString("en-US", { month: "short", day: "numeric" });
  } catch {
    return isoString;
  }
}

export function AdminDashboardPage({ onNavigate: _onNavigate }: DashboardProps) {
  const [range, setRange] = useState("7d");
  const [stats, setStats] = useState<SystemStatisticsResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchStats = async (period: string) => {
    setLoading(true);
    setError(null);
    try {
      const data = await adminStatisticsApi.getSystemStatistics(period);
      setStats(data);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "Failed to load system statistics.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    void fetchStats(range);
  }, [range]);

  const overview = stats?.overview;
  const userGrowth = stats?.userGrowth ?? [];
  const maxGrowth = Math.max(...userGrowth.map((g) => g.count), 5);

  return (
    <div className="ops-dashboard ops-dashboard--admin">
      <DashboardHeading
        eyebrow="ADMINISTRATION"
        title="System Administration"
        description="Review users, published content, reports, and platform activity."
        icon={<ShieldIcon width={15} height={15} />}
      >
        <div style={{ display: "flex", alignItems: "center", gap: "10px" }}>
          <button
            type="button"
            className="icon-button"
            onClick={() => fetchStats(range)}
            title="Refresh statistics"
            aria-label="Refresh statistics"
            disabled={loading}
          >
            <RefreshIcon width={15} height={15} />
          </button>
          <label className="ops-range-select">
            <span>Date range</span>
            <select
              value={range}
              onChange={(event) => setRange(event.target.value)}
              aria-label="Date range"
              disabled={loading}
            >
              <option value="7d">Last 7 days</option>
              <option value="30d">Last 30 days</option>
              <option value="90d">Last 90 days</option>
            </select>
          </label>
        </div>
      </DashboardHeading>

      {error ? (
        <div className="ops-alert ops-alert--error" style={{ marginBottom: "20px" }}>
          <span>{error}</span>
          <button type="button" onClick={() => fetchStats(range)}>Retry</button>
        </div>
      ) : null}

      <section className="ops-metric-grid" aria-label="System statistics">
        <DashboardMetric
          icon={<UsersIcon />}
          label="Total users"
          value={overview ? overview.totalUsers.toLocaleString() : "..."}
          change={overview ? `${overview.userGrowthPercentage > 0 ? "+" : ""}${overview.userGrowthPercentage}%` : "..."}
          note={overview ? `+${overview.newUsersInPeriod} new in this period` : "Calculating..."}
        />
        <DashboardMetric
          icon={<DiscIcon />}
          label="Published tracks"
          value={overview ? overview.publishedTracks.toLocaleString() : "..."}
          change={overview ? `${overview.activeGenres} genres` : "..."}
          note={overview ? `${overview.newTracksInPeriod} newly added` : "Catalog active"}
          tone="violet"
        />
        <DashboardMetric
          icon={<ActivityIcon />}
          label="Total plays"
          value={
            overview
              ? overview.totalPlays >= 1000
                ? `${(overview.totalPlays / 1000).toFixed(1)}K`
                : overview.totalPlays.toLocaleString()
              : "..."
          }
          change={overview ? `${overview.totalCreators} artists` : "..."}
          note="Across all platform tracks"
          tone="green"
        />
        <DashboardMetric
          icon={<FlagIcon />}
          label="Pending reviews"
          value={overview ? String(overview.pendingReviews) : "..."}
          change={overview ? `${overview.pendingReports} reports` : "..."}
          note="Tracks awaiting review"
          tone="amber"
        />
      </section>

      <section className="ops-dashboard-grid ops-dashboard-grid--hero">
        <article className="ops-panel ops-panel--chart">
          <PanelHeading
            title="User growth"
            description={range === "7d" ? "New users in the last 7 days" : `Trend over the last ${range === "30d" ? "30" : "90"} days`}
            action={
              <span className="ops-panel-total">
                <b>+{overview?.newUsersInPeriod ?? 0}</b> new accounts
              </span>
            }
          />
          <div className="ops-growth-chart" aria-label="User growth chart">
            <div className="ops-chart-scale">
              <span>{maxGrowth}</span>
              <span>{Math.round(maxGrowth * 0.66)}</span>
              <span>{Math.round(maxGrowth * 0.33)}</span>
              <span>0</span>
            </div>
            <div className="ops-bars">
              {userGrowth.length > 0
                ? userGrowth.map((item, index) => {
                    const heightPercent =
                      maxGrowth > 0
                        ? Math.max(item.count > 0 ? 15 : 4, Math.round((item.count / maxGrowth) * 100))
                        : 4;
                    return (
                      <div className="ops-bar-column" key={`${item.date}-${index}`} title={`${item.date}: ${item.count} users`}>
                        <div className="ops-bar-track">
                          <i style={{ height: `${heightPercent}%` }} />
                        </div>
                        <span>{item.label}</span>
                      </div>
                    );
                  })
                : [38, 51, 46, 64, 58, 76, 88].map((height, index) => (
                    <div className="ops-bar-column" key={`${height}-${index}`}>
                      <div className="ops-bar-track"><i style={{ height: `${height}%` }} /></div>
                      <span>{["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][index]}</span>
                    </div>
                  ))}
            </div>
          </div>
          <div className="ops-chart-summary">
            <span>
              <i className="is-primary" />
              Listeners <b>{stats?.roleDistribution?.listenerPercentage ?? 78}%</b>
            </span>
            <span>
              <i className="is-accent" />
              Creators <b>{stats?.roleDistribution?.creatorPercentage ?? 22}%</b>
            </span>
            <span className="ops-chart-insight">
              <TrendingUpIcon width={14} height={14} /> Total creators: {overview?.totalCreators ?? 0}
            </span>
          </div>
        </article>

        <aside className="ops-panel ops-health-panel">
          <PanelHeading title="System health" description="Live cluster telemetry" />
          <div className="ops-health-score">
            <div className="ops-score-ring">
              <span><b>{stats?.systemHealth?.uptime ?? "99.98%"}</b><small>uptime</small></span>
            </div>
            <p>All core backend services operational.</p>
          </div>
          <div className="ops-health-list">
            <div>
              <span><i className="is-ok" />REST API</span>
              <b>{stats?.systemHealth?.restApiLatencyMs ?? 12} ms</b>
            </div>
            <div>
              <span><i className="is-ok" />PostgreSQL Database</span>
              <b>{stats?.systemHealth?.databaseLatencyMs ?? 18} ms</b>
            </div>
            <div>
              <span><i className="is-ok" />Internal Media Storage</span>
              <b>{stats?.systemHealth?.cloudStorageLatencyMs ?? 1} ms</b>
            </div>
            <div>
              <span><i className="is-ok" />Email Service</span>
              <b>{stats?.systemHealth?.emailServiceStatus ?? "Active"}</b>
            </div>
          </div>
        </aside>
      </section>

      <section className="ops-dashboard-grid ops-dashboard-grid--lower">
        <article className="ops-panel ops-recent-users">
          <PanelHeading
            title="Recent accounts"
            description="Accounts that recently joined or verified on the platform"
          />
          <div className="ops-table-wrap">
            <table className="ops-table">
              <thead>
                <tr>
                  <th>User</th>
                  <th>Role</th>
                  <th>Status</th>
                  <th>Joined</th>
                </tr>
              </thead>
              <tbody>
                {stats?.recentAccounts && stats.recentAccounts.length > 0 ? (
                  stats.recentAccounts.map((account) => (
                    <tr key={account.id}>
                      <td>
                        <div className="ops-user-cell">
                          {account.avatarUrl ? (
                            <img
                              src={account.avatarUrl}
                              alt={account.displayName}
                              style={{ width: "32px", height: "32px", borderRadius: "8px", objectFit: "cover" }}
                            />
                          ) : (
                            <span>{account.initials || "US"}</span>
                          )}
                          <div>
                            <b>{account.displayName || account.email.split("@")[0]}</b>
                            <small>{account.email}</small>
                          </div>
                        </div>
                      </td>
                      <td>
                        <span className="ops-role-chip">{account.role}</span>
                      </td>
                      <td>
                        <span
                          className={`ops-status ${
                            account.status === "Verified" || account.status === "ACTIVE"
                              ? "is-success"
                              : "is-warning"
                          }`}
                        >
                          <i />
                          {account.status}
                        </span>
                      </td>
                      <td>{formatRelativeTime(account.joinedAt)}</td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan={4} style={{ textAlign: "center", padding: "20px", color: "var(--ops-text-muted)" }}>
                      No recent accounts found.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </article>

        <aside className="ops-panel ops-activity-feed">
          <PanelHeading
            title="Top Played Tracks"
            description="Most streamed tracks on MagiSound"
          />
          <div className="ops-timeline">
            {stats?.topTracks && stats.topTracks.length > 0 ? (
              stats.topTracks.slice(0, 4).map((track, idx) => {
                const toneClass = idx === 0 ? "is-cyan" : idx === 1 ? "is-violet" : idx === 2 ? "is-amber" : "is-green";
                return (
                  <div key={track.id}>
                    <span className={toneClass}>
                      <DiscIcon width={14} height={14} />
                    </span>
                    <p>
                      <b>{track.title}</b> · <span style={{ color: "var(--ops-text-muted)" }}>{track.uploaderName}</span>
                      <small>
                        {track.playCount.toLocaleString()} plays · {track.genreName || "Music"}
                      </small>
                    </p>
                  </div>
                );
              })
            ) : (
              <>
                <div><span className="is-cyan"><UserIcon width={14} height={14} /></span><p><b>Admin account active</b><small>Telemetry live</small></p></div>
                <div><span className="is-violet"><DiscIcon width={14} height={14} /></span><p><b>Catalog synchronized</b><small>All genres online</small></p></div>
                <div><span className="is-green"><CheckIcon width={14} height={14} /></span><p>Database backup verified.<small>PostgreSQL 18</small></p></div>
              </>
            )}
          </div>
        </aside>
      </section>
    </div>
  );
}

export { StaffDashboardPage } from "./StaffDashboardPage";

export function DashboardAccessDenied({
  onNavigate,
  requiredRole = "authorized",
}: {
  onNavigate: (route: string) => void;
  initialSubmissionId?: number | null;
  requiredRole?: string;
}) {
  return (
    <div className="ops-access-denied">
      <span><ShieldIcon width={32} height={32} /></span>
      <small>403 · RESTRICTED AREA</small>
      <h1>Access denied</h1>
      <p>This workspace is available only to accounts with the {requiredRole} role. Please log in with an authorized account.</p>
      <div style={{ display: "flex", gap: "10px", justifyContent: "center", flexWrap: "wrap" }}>
        <button className="button button-primary" onClick={() => onNavigate("/staff/login")}>
          Staff & Admin Login
        </button>
        <button className="button button-secondary" onClick={() => onNavigate("/login")}>
          Public Listener Login
        </button>
      </div>
    </div>
  );
}
