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

export function AdminDashboardPage({ onNavigate }: DashboardProps) {
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
  const maxGrowth = Math.max(...userGrowth.map((g) => g.count), 1);

  return (
    <div className="ops-dashboard ops-dashboard--admin">
      <DashboardHeading
        eyebrow="ADMINISTRATION"
        title="System Administration"
        description="Real-time system telemetry and platform data from PostgreSQL database."
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

      {/* Quick Access Shortcuts */}
      <div style={{ display: "flex", gap: "10px", marginBottom: "20px", flexWrap: "wrap" }}>
        <button
          type="button"
          className="button button-secondary"
          onClick={() => onNavigate("/admin/staffs")}
          style={{ display: "inline-flex", alignItems: "center", gap: "6px", fontSize: "13px" }}
        >
          <UserIcon width={14} height={14} />
          <span>Staff Accounts ({stats?.roleDistribution?.staffs ?? 0})</span>
        </button>
        <button
          type="button"
          className="button button-secondary"
          onClick={() => onNavigate("/admin/genres")}
          style={{ display: "inline-flex", alignItems: "center", gap: "6px", fontSize: "13px" }}
        >
          <DiscIcon width={14} height={14} />
          <span>Genre Management ({overview?.activeGenres ?? 0})</span>
        </button>
        <button
          type="button"
          className="button button-secondary"
          onClick={() => onNavigate("/staff/dashboard")}
          style={{ display: "inline-flex", alignItems: "center", gap: "6px", fontSize: "13px" }}
        >
          <FlagIcon width={14} height={14} />
          <span>Pending Submissions ({overview?.pendingReviews ?? 0})</span>
        </button>
      </div>

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
          change={overview ? `${overview.activeGenres} active genres` : "..."}
          note={overview ? `${overview.newTracksInPeriod} added in this period` : "Catalog active"}
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
          note="Live count across catalog"
          tone="green"
        />
        <DashboardMetric
          icon={<FlagIcon />}
          label="Pending reviews"
          value={overview ? String(overview.pendingReviews) : "..."}
          change={overview ? `${overview.pendingReports} reports` : "..."}
          note="Submissions awaiting audit"
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
              {loading ? (
                Array.from({ length: 7 }).map((_, idx) => (
                  <div className="ops-bar-column" key={`skel-${idx}`}>
                    <div className="ops-bar-track">
                      <i style={{ height: "15%", opacity: 0.3 }} />
                    </div>
                    <span>--</span>
                  </div>
                ))
              ) : userGrowth.length > 0 ? (
                userGrowth.map((item, index) => {
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
              ) : (
                <div style={{ textAlign: "center", width: "100%", padding: "20px", color: "var(--ops-text-muted)" }}>
                  No registration activity in this period.
                </div>
              )}
            </div>
          </div>
          <div className="ops-chart-summary">
            <span>
              <i className="is-primary" />
              Listeners <b>{stats?.roleDistribution ? `${stats.roleDistribution.listeners} (${stats.roleDistribution.listenerPercentage}%)` : "..."}</b>
            </span>
            <span>
              <i className="is-accent" />
              Creators <b>{stats?.roleDistribution ? `${stats.roleDistribution.creators} (${stats.roleDistribution.creatorPercentage}%)` : "..."}</b>
            </span>
            <span>
              <i style={{ background: "#f59e0b" }} />
              Staff & Admins <b>{stats?.roleDistribution ? `${(stats.roleDistribution.staffs || 0) + (stats.roleDistribution.admins || 0)}` : "..."}</b>
            </span>
            <span className="ops-chart-insight">
              <TrendingUpIcon width={14} height={14} /> Total registered creators: {overview?.totalCreators ?? 0}
            </span>
          </div>
        </article>

        <aside className="ops-panel ops-health-panel">
          <PanelHeading title="System health" description="Live cluster telemetry" />
          <div className="ops-health-score">
            <div className="ops-score-ring">
              <span><b>{stats?.systemHealth?.uptime || "100%"}</b><small>uptime</small></span>
            </div>
            <p>Database & backend services operational.</p>
          </div>
          <div className="ops-health-list">
            <div>
              <span><i className="is-ok" />REST API</span>
              <b>{stats?.systemHealth ? `${stats.systemHealth.restApiLatencyMs} ms` : "..."}</b>
            </div>
            <div>
              <span><i className="is-ok" />PostgreSQL Database</span>
              <b>{stats?.systemHealth ? `${stats.systemHealth.databaseLatencyMs} ms` : "..."}</b>
            </div>
            <div>
              <span><i className="is-ok" />Internal Media Storage</span>
              <b>{stats?.systemHealth ? `${stats.systemHealth.cloudStorageLatencyMs} ms` : "..."}</b>
            </div>
            <div>
              <span><i className="is-ok" />Email Service</span>
              <b>{stats?.systemHealth?.emailServiceStatus || "Active"}</b>
            </div>
          </div>
        </aside>
      </section>

      <section className="ops-dashboard-grid ops-dashboard-grid--lower">
        <article className="ops-panel ops-recent-users">
          <PanelHeading
            title="Recent accounts"
            description="Accounts registered in PostgreSQL app_users table"
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
            description="Most streamed tracks on MagiSound from PostgreSQL"
          />
          <div className="ops-timeline">
            {stats?.topTracks && stats.topTracks.length > 0 ? (
              stats.topTracks.slice(0, 5).map((track, idx) => {
                const toneClass = idx === 0 ? "is-cyan" : idx === 1 ? "is-violet" : idx === 2 ? "is-amber" : "is-green";
                return (
                  <div key={track.id} style={{ display: "flex", alignItems: "center", gap: "10px" }}>
                    {track.coverUrl ? (
                      <img
                        src={track.coverUrl}
                        alt=""
                        style={{ width: "36px", height: "36px", borderRadius: "6px", objectFit: "cover", flexShrink: 0 }}
                      />
                    ) : (
                      <span className={toneClass}>
                        <DiscIcon width={14} height={14} />
                      </span>
                    )}
                    <p style={{ margin: 0, flex: 1, minWidth: 0 }}>
                      <b style={{ display: "block", overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>
                        #{idx + 1} {track.title}
                      </b>
                      <small style={{ color: "var(--ops-text-muted)" }}>
                        {track.uploaderName} · {track.playCount.toLocaleString()} plays · {track.genreName || "Music"}
                      </small>
                    </p>
                  </div>
                );
              })
            ) : (
              <div style={{ textAlign: "center", padding: "20px", color: "var(--ops-text-muted)" }}>
                No track playback activity recorded yet.
              </div>
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
