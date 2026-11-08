export type LandingTrack = {
  id: number;
  title: string;
  coverUrl: string | null;
  audioUrl: string;
  durationMs: number;
  playCount: number;
  slug?: string;
  publicationStatus?: "APPROVED" | "PUBLISHED" | string;
  genreSlug?: string;
  genreName?: string;
  description?: string;
  createdAt?: string;
  lyrics?: string;
  creator: {
    userId: number;
    displayName: string;
    avatarUrl: string | null;
  };
  album?: {
    id: number;
    title: string;
  };
};

export type FeaturedCreator = {
  userId: number;
  displayName: string;
  avatarUrl: string;
  bio: string;
  publishedTracks: number;
  followersCount?: number;
};

export type Genre = {
  id: number;
  name: string;
  slug: string;
  color: string;
  accent: string;
  description?: string;
};

export type Playlist = {
  id: number;
  title: string;
  description?: string;
  coverUrl: string;
  trackCount: number;
  isPrivate: boolean;
  ownerId: number;
  ownerName: string;
  creatorName?: string;
  createdAt?: string;
  trackIds: number[];
  tracks?: LandingTrack[];
};

export type StudioTrack = {
  id: number;
  title: string;
  slug?: string;
  description?: string;
  coverUrl: string | null;
  audioUrl: string;
  durationMs: number;
  genreId?: number;
  genreSlug: string;
  genreName: string;
  albumId?: number;
  albumTitle?: string;
  trackNumber?: number;
  status: "DRAFT" | "PENDING" | "APPROVED" | "PUBLISHED" | "REJECTED" | "TAKEN_DOWN" | string;
  audioFormat?: string;
  playCount?: number;
  latestRejectionReason?: string;
  reviewerNote?: string;
  submitterNote?: string;
  submittedAt?: string;
  reviewedAt?: string;
  createdAt: string;
  updatedAt?: string;
  lyrics?: string;
};

export type CurrentUser = {
  id: number;
  userId?: number;
  email: string;
  username?: string;
  displayName: string;
  avatarUrl: string | null;
  role: "LISTENER" | "STAFF" | "ADMIN";
  bio?: string;
  dateOfBirth?: string;
  countryCode?: string;
};

export type ListeningHistoryItem = {
  id: number;
  trackId: number;
  title: string;
  slug: string;
  artistName: string;
  durationMs: number;
  coverUrl: string | null;
  audioUrl: string | null;
  playedAt: string;
  listenedDurationMs: number;
  completed: boolean;
};


export type NotificationItem = {
  id: number;
  userId: number;
  type: string;
  title: string;
  message: string;
  targetType?: string;
  targetId?: string;
  navigationUrl?: string;
  isRead: boolean;
  createdAt: string;
};


// =========================================================================
// Lyrics Subsystem Types
// =========================================================================
export type LyricDetail = {
  id: number | null;
  trackId: number;
  lyricContent: string;
  status: string; // "PUBLISHED", "DRAFT", "PERSONAL"
  isOfficial: boolean;
  lyricType: string; // "OFFICIAL", "CUSTOM", "TRANSLATION"
  updatedAt?: string;
};

export type TrackLyricsBundle = {
  officialLyric: LyricDetail | null;
  userPersonalLyric: LyricDetail | null;
};

export type StaffTrackLyricSummary = {
  trackId: number;
  trackTitle?: string;
  title?: string;
  trackSlug?: string;
  artistName?: string;
  uploaderName?: string;
  coverUrl?: string | null;
  audioUrl?: string | null;
  durationFormatted?: string;
  genreName?: string;
  albumTitle?: string | null;
  durationSeconds?: number | null;
  hasOfficialLyric: boolean;
  lyricStatus?: string | null; // "PUBLISHED", "DRAFT", null
  lastUpdated?: string | null;
  lyricUpdatedAt?: string | null;
  updatedByStaffName?: string | null;
};

// =========================================================================
// Public Unified Search Types (UC-07)
// =========================================================================
export type CreatorSearchResult = {
  userId: number;
  username: string;
  displayName: string;
  avatarUrl: string | null;
  bio: string | null;
  trackCount: number;
};

export type LyricSearchResult = {
  officialLyricId: number;
  track: LandingTrack;
  lyricSnippet: string;
};

export type TopSearchResult = {
  type: "SONG" | "CREATOR";
  track?: LandingTrack | null;
  creator?: CreatorSearchResult | null;
};

export type SearchPageResponse<T> = {
  content: T[];
  totalElements: number;
  totalPages: number;
  size: number;
  number: number;
  first: boolean;
  last: boolean;
};

export type UnifiedSearchResponse = {
  query: string;
  type: string;
  topResult: TopSearchResult | null;
  tracks: SearchPageResponse<LandingTrack>;
  creators: SearchPageResponse<CreatorSearchResult>;
  lyrics: SearchPageResponse<LyricSearchResult>;
};

// =========================================================================
// Admin Staff Management Types (UC-20)
// =========================================================================
export type StaffSummaryItem = {
  id: number;
  email: string;
  fullName: string;
  roleCode: "STAFF" | "ADMIN" | string;
  roleName: string;
  status: "ACTIVE" | "INACTIVE" | string;
  avatarUrl: string | null;
  lastLoginAt: string | null;
  createdAt: string;
  totalTracksModerated: number;
  totalReportsResolved: number;
};

export type StaffDirectoryResponse = {
  content: StaffSummaryItem[];
  totalElements: number;
  totalPages: number;
  size: number;
  number: number;
  first: boolean;
  last: boolean;
};

export type CreateStaffInput = {
  fullName: string;
  email: string;
  password?: string;
  autoGeneratePassword?: boolean;
};

export type CreateStaffResult = {
  id: number;
  email: string;
  fullName: string;
  roleCode: string;
  roleName: string;
  status: string;
  temporaryPassword: string;
  emailDispatched: boolean;
  createdAt: string;
};

export type DeactivateStaffInput = {
  reason: string;
};

export type DeactivateStaffResult = {
  id: number;
  email: string;
  fullName: string;
  roleCode: string;
  status: string;
  reason: string;
  deactivatedAt: string;
};

export type TrackModerationActivityItem = {
  submissionId: number;
  trackId: number;
  trackTitle: string;
  artistName: string;
  action: string;
  rejectionReason: string | null;
  reviewerNote: string | null;
  reviewedAt: string | null;
};

export type ReportResolutionActivityItem = {
  reportId: number;
  category: string;
  targetType: string;
  targetId: number;
  targetTitle: string;
  decision: string;
  resolutionNote: string | null;
  resolvedAt: string | null;
};

export type StaffModerationActivityResponse = {
  staffId: number;
  fullName: string;
  email: string;
  roleCode: string;
  roleName: string;
  status: string;
  totalTracksModerated: number;
  totalReportsResolved: number;
  trackReviews: TrackModerationActivityItem[];
  reportResolutions: ReportResolutionActivityItem[];
};

// =========================================================================
// Admin System Statistics Types (UC-22)
// =========================================================================
export type MetricOverview = {
  totalUsers: number;
  activeUsers: number;
  newUsersInPeriod: number;
  userGrowthPercentage: number;
  publishedTracks: number;
  newTracksInPeriod: number;
  totalPlays: number;
  pendingReviews: number;
  pendingReports: number;
  activeGenres: number;
  totalCreators: number;
};

export type TopTrackStatistic = {
  id: number;
  title: string;
  uploaderName: string;
  genreName: string;
  playCount: number;
  coverUrl: string | null;
  durationMs: number | null;
};

export type DailyGrowthStatistic = {
  label: string;
  date: string;
  count: number;
};

export type RoleDistribution = {
  listeners: number;
  creators: number;
  staffs: number;
  admins: number;
  listenerPercentage: number;
  creatorPercentage: number;
};

export type RecentAccountStatistic = {
  id: number;
  email: string;
  displayName: string;
  role: string;
  status: string;
  joinedAt: string;
  initials: string;
  avatarUrl: string | null;
};

export type SystemHealth = {
  restApiStatus: string;
  databaseStatus: string;
  cloudStorageStatus: string;
  emailServiceStatus: string;
  restApiLatencyMs: number;
  databaseLatencyMs: number;
  cloudStorageLatencyMs: number;
  uptime: string;
};

export type SystemStatisticsResponse = {
  overview: MetricOverview;
  topTracks: TopTrackStatistic[];
  userGrowth: DailyGrowthStatistic[];
  roleDistribution: RoleDistribution;
  recentAccounts: RecentAccountStatistic[];
  systemHealth: SystemHealth;
  period: string;
  generatedAt: string;
};

// =========================================================================
// Content Reports & Moderation Types (UC-16, UC-18, UC-19)
// =========================================================================
export type StaffContentReportResponse = {
  id: number;
  reportIds?: number[];
  reporterCount?: number;
  reporterId: number;
  reporterName: string;
  reporterEmail: string | null;
  reporters?: Array<{
    reporterId: number;
    reporterName: string;
    reporterEmail: string | null;
    submittedAt: string;
  }>;
  targetType: string;
  targetId: number;
  trackId: number | null;
  trackTitle: string;
  artistName: string;
  coverUrl: string | null;
  audioUrl: string | null;
  trackPublicationStatus: string | null;
  lyrics?: string | null;
  reason: string;
  status: "PENDING" | "RESOLVED" | "DISMISSED" | string;
  reviewerId: number | null;
  reviewerName: string | null;
  staffNote: string | null;
  createdAt: string;
  resolvedAt: string | null;
};

export type ResolveContentReportRequest = {
  decision: string;
  staffNote: string;
};

export type TakeDownTrackRequest = {
  takedownReason: string;
  reviewerNote?: string;
};
