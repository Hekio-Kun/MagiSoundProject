import { apiFetch } from "./client";
import type {
  CreateStaffInput,
  CreateStaffResult,
  DeactivateStaffInput,
  DeactivateStaffResult,
  StaffDirectoryResponse,
  StaffModerationActivityResponse,
} from "../types";

export type GetStaffParams = {
  search?: string;
  status?: string;
  role?: string;
  page?: number;
  size?: number;
  sort?: string;
};

export const adminStaffApi = {
  /**
   * Lấy danh bạ nhân viên kiểm duyệt (UC-20.1: View Staff Directory).
   */
  getStaffDirectory: (params: GetStaffParams = {}) => {
    const query = new URLSearchParams();
    if (params.search?.trim()) query.set("search", params.search.trim());
    if (params.status && params.status !== "ALL") query.set("status", params.status);
    if (params.role && params.role !== "ALL") query.set("role", params.role);
    if (params.page !== undefined) query.set("page", String(params.page));
    if (params.size !== undefined) query.set("size", String(params.size));
    if (params.sort) query.set("sort", params.sort);

    const queryString = query.toString();
    const endpoint = queryString ? `/admin/staffs?${queryString}` : "/admin/staffs";
    return apiFetch<StaffDirectoryResponse>(endpoint);
  },

  /**
   * Tạo tài khoản nhân viên kiểm duyệt mới (UC-20.2: Create Staff Account).
   */
  createStaff: (payload: CreateStaffInput) => {
    return apiFetch<CreateStaffResult>("/admin/staffs", {
      method: "POST",
      body: JSON.stringify(payload),
    });
  },

  /**
   * Vô hiệu hóa tài khoản nhân viên (UC-20.3: Deactivate Staff Account).
   */
  deactivateStaff: (staffId: number, payload: DeactivateStaffInput) => {
    return apiFetch<DeactivateStaffResult>(`/admin/staffs/${staffId}/deactivate`, {
      method: "PATCH",
      body: JSON.stringify(payload),
    });
  },

  /**
   * Lấy lịch sử hoạt động kiểm duyệt của nhân viên (UC-20.4: View Staff Moderation Activity).
   */
  getStaffModerationActivity: (staffId: number) => {
    return apiFetch<StaffModerationActivityResponse>(`/admin/staffs/${staffId}/activity`);
  },
};
