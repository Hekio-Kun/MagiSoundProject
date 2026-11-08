import { apiFetch } from "./client";
import type { LyricDetail, TrackLyricsBundle, StaffTrackLyricSummary } from "../types";

export type PageResponse<T> = {
  content: T[];
  totalElements: number;
  totalPages: number;
  size: number;
  number: number;
  first: boolean;
  last: boolean;
  empty: boolean;
};

export const lyricsApi = {
  getTrackLyrics: (trackId: number): Promise<TrackLyricsBundle> => {
    return apiFetch<TrackLyricsBundle>(`/tracks/${trackId}/lyrics`);
  },

  savePersonalLyric: (
    trackId: number,
    data: { lyricContent: string; lyricType?: string }
  ): Promise<LyricDetail> => {
    return apiFetch<LyricDetail>(`/tracks/${trackId}/lyrics/custom`, {
      method: "POST",
      body: JSON.stringify(data),
    });
  },

  deletePersonalLyric: (trackId: number, id: number): Promise<void> => {
    return apiFetch<void>(`/tracks/${trackId}/lyrics/custom/${id}`, {
      method: "DELETE",
    });
  },

  // Staff endpoints
  getTracksForStaffLyricManagement: (
    params?: { search?: string; page?: number; size?: number }
  ): Promise<PageResponse<StaffTrackLyricSummary>> => {
    const searchParams = new URLSearchParams();
    if (params?.search) searchParams.set("search", params.search);
    if (params?.page !== undefined) searchParams.set("page", params.page.toString());
    if (params?.size !== undefined) searchParams.set("size", params.size.toString());
    const query = searchParams.toString();
    return apiFetch<PageResponse<StaffTrackLyricSummary>>(`/staff/lyrics${query ? `?${query}` : ""}`);
  },

  saveOfficialLyric: (data: {
    trackId: number;
    lyricContent: string;
    status: "DRAFT" | "PUBLISHED";
  }): Promise<LyricDetail> => {
    return apiFetch<LyricDetail>("/staff/lyrics", {
      method: "POST",
      body: JSON.stringify(data),
    });
  },

  updateOfficialLyricStatus: (
    trackId: number,
    status: "DRAFT" | "PUBLISHED"
  ): Promise<LyricDetail> => {
    return apiFetch<LyricDetail>(`/staff/lyrics/${trackId}/status`, {
      method: "PATCH",
      body: JSON.stringify({ status }),
    });
  },

  deleteOfficialLyric: (trackId: number): Promise<void> => {
    return apiFetch<void>(`/staff/lyrics/${trackId}`, {
      method: "DELETE",
    });
  },
};
