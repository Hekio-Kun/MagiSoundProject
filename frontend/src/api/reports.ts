import { apiFetch } from "./client";

export type ReportCategoryType =
  | "COPYRIGHT"
  | "INAPPROPRIATE_CONTENT"
  | "INCORRECT_METADATA"
  | "OTHER";

export interface CreateTrackReportPayload {
  trackId: number;
  category: ReportCategoryType | string;
  description?: string;
}

export interface UpdateTrackReportPayload {
  category: ReportCategoryType | string;
  description?: string;
}

export interface TrackReportResponse {
  id: number;
  trackId: number;
  trackTitle: string;
  trackCoverUrl?: string;
  submittedByUserId: number;
  category: string;
  categoryLabel: string;
  description?: string;
  status: string;
  createdAt: string;
}

export interface MyReportHistoryItem {
  id: number;
  trackId: number;
  trackTitle: string;
  trackCoverUrl?: string;
  category: string;
  categoryLabel: string;
  status: string;
  resolutionNote?: string;
  createdAt: string;
  handledAt?: string;
}

export interface CheckPendingReportResponse {
  trackId: number;
  hasPendingReport: boolean;
}

export const reportsApi = {
  /**
   * Báo cáo vi phạm nội dung bài hát đã phát hành (UC-16.1).
   */
  reportTrack: async (payload: CreateTrackReportPayload): Promise<TrackReportResponse> => {
    return apiFetch<TrackReportResponse>("/reports", {
      method: "POST",
      body: JSON.stringify(payload),
    });
  },

  /**
   * Cập nhật lý do báo cáo đang ở trạng thái PENDING.
   */
  updateTrackReport: async (
    id: number,
    payload: UpdateTrackReportPayload
  ): Promise<TrackReportResponse> => {
    return apiFetch<TrackReportResponse>(`/reports/${id}`, {
      method: "PUT",
      body: JSON.stringify(payload),
    });
  },

  /**
   * Rút lại (hủy) báo cáo vi phạm nội dung đang ở trạng thái PENDING.
   */
  withdrawTrackReport: async (id: number): Promise<{ reportId: number; message: string }> => {
    return apiFetch<{ reportId: number; message: string }>(`/reports/${id}`, {
      method: "DELETE",
    });
  },

  /**
   * Lấy lịch sử các báo cáo vi phạm nội dung do người nghe gửi (UC-16.2).
   */
  getMyReports: async (): Promise<MyReportHistoryItem[]> => {
    return apiFetch<MyReportHistoryItem[]>("/reports/my-reports");
  },

  /**
   * Kiểm tra xem người dùng hiện tại đã có báo cáo PENDING cho bài hát hay chưa.
   */
  checkPendingReport: async (trackId: number): Promise<boolean> => {
    try {
      const res = await apiFetch<CheckPendingReportResponse>(`/reports/check?trackId=${trackId}`);
      return res.hasPendingReport;
    } catch {
      return false;
    }
  },
};
