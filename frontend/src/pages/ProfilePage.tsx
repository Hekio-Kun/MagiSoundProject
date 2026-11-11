import { useCallback, useEffect, useRef, useState, type ChangeEvent, type FormEvent, type ReactNode } from "react";
import { AuthApiError, getAuthErrorMessage } from "../api/auth";
import { profileApi, type ChangePasswordInput, type ProfileDetails, type UpdateProfileInput } from "../api/profile";
import { AlertIcon, CheckIcon, ClockIcon, CloseIcon, LockIcon, MailIcon, UploadIcon, UserIcon } from "../icons";

type Props = { onProfileUpdated: (profile: ProfileDetails) => void };
type FormState = { username: string; displayName: string; bio: string; dateOfBirth: string; countryCode: string };
type FieldName = keyof FormState | "avatar";
type FieldErrors = Partial<Record<FieldName, string>>;

const emptyForm: FormState = { username: "", displayName: "", bio: "", dateOfBirth: "", countryCode: "" };
const MAX_AVATAR_SIZE = 5 * 1024 * 1024;
const ACCEPTED_AVATAR_TYPES = ["image/jpeg", "image/png"];

function toForm(profile: ProfileDetails): FormState {
  return { username: profile.username, displayName: profile.displayName, bio: profile.bio ?? "", dateOfBirth: profile.dateOfBirth ?? "", countryCode: profile.countryCode ?? "" };
}

function validate(form: FormState): FieldErrors {
  const errors: FieldErrors = {};
  const username = form.username.trim();
  const displayName = form.displayName.trim();
  const countryCode = form.countryCode.trim();
  if (!username) errors.username = "Please enter a username.";
  else if (username.length < 3 || username.length > 50) errors.username = "Username must contain between 3 and 50 characters.";
  else if (!/^[A-Za-z0-9._]+$/.test(username)) errors.username = "Use only letters, numbers, dots, and underscores.";
  if (!displayName) errors.displayName = "Display name cannot be empty.";
  else if (displayName.length > 120) errors.displayName = "Display name must not exceed 120 characters.";
  if (form.bio.length > 1000) errors.bio = "Biography must not exceed 1000 characters.";
  if (countryCode && !/^[A-Za-z]{2}$/.test(countryCode)) errors.countryCode = "Use a two-letter country code, for example VN.";
  if (form.dateOfBirth && new Date(`${form.dateOfBirth}T00:00:00`) >= new Date()) errors.dateOfBirth = "Date of birth must be in the past.";
  return errors;
}

const formatDate = (value: string | null) => value
  ? new Intl.DateTimeFormat("en-US", { day: "2-digit", month: "long", year: "numeric" }).format(new Date(`${value}T00:00:00`))
  : "Not provided";

export function ProfilePage({ onProfileUpdated }: Props) {
  const [profile, setProfile] = useState<ProfileDetails | null>(null);
  const [form, setForm] = useState<FormState>(emptyForm);
  const [fieldErrors, setFieldErrors] = useState<FieldErrors>({});
  const [apiError, setApiError] = useState("");
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [editing, setEditing] = useState(false);
  const [saved, setSaved] = useState(false);
  const [avatarFile, setAvatarFile] = useState<File | null>(null);
  const [avatarPreview, setAvatarPreview] = useState("");
  const [avatarFailed, setAvatarFailed] = useState(false);
  const [passwordModalOpen, setPasswordModalOpen] = useState(false);
  const [passwordForm, setPasswordForm] = useState<ChangePasswordInput>({
    currentPassword: "",
    newPassword: "",
    confirmPassword: "",
  });
  const [passwordError, setPasswordError] = useState("");
  const [passwordSuccess, setPasswordSuccess] = useState("");
  const [passwordSubmitting, setPasswordSubmitting] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const loadProfile = useCallback(async () => {
    setLoading(true);
    setApiError("");
    try {
      const result = await profileApi.getCurrent();
      setProfile(result);
      setForm(toForm(result));
      setAvatarFailed(false);
      onProfileUpdated(result);
    } catch (error) {
      setApiError(getAuthErrorMessage(error, "Unable to load your profile. Please try again."));
    } finally {
      setLoading(false);
    }
  }, [onProfileUpdated]);

  useEffect(() => { void loadProfile(); }, [loadProfile]);
  useEffect(() => () => { if (avatarPreview) URL.revokeObjectURL(avatarPreview); }, [avatarPreview]);

  const beginEdit = () => {
    if (!profile) return;
    setForm(toForm(profile));
    setFieldErrors({});
    setApiError("");
    setSaved(false);
    setAvatarFile(null);
    setAvatarPreview("");
    setEditing(true);
  };

  const cancelEdit = () => {
    if (profile) setForm(toForm(profile));
    setFieldErrors({});
    setApiError("");
    setAvatarFile(null);
    setAvatarPreview("");
    setEditing(false);
  };

  const updateField = (field: keyof FormState, value: string) => {
    setForm((current) => ({ ...current, [field]: value }));
    setFieldErrors((current) => ({ ...current, [field]: undefined }));
    setApiError("");
  };

  const selectAvatar = (event: ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (!file) return;
    if (!ACCEPTED_AVATAR_TYPES.includes(file.type) || file.size > MAX_AVATAR_SIZE) {
      setAvatarFile(null);
      setAvatarPreview("");
      setFieldErrors((current) => ({ ...current, avatar: "Avatar must be in JPG/PNG format and under 5MB." }));
      event.target.value = "";
      return;
    }
    setAvatarFile(file);
    setAvatarPreview(URL.createObjectURL(file));
    setAvatarFailed(false);
    setFieldErrors((current) => ({ ...current, avatar: undefined }));
    setApiError("");
  };

  const submit = async (event: FormEvent) => {
    event.preventDefault();
    const errors = validate(form);
    if (fieldErrors.avatar) errors.avatar = fieldErrors.avatar;
    if (Object.keys(errors).length) {
      setFieldErrors(errors);
      setApiError("Please review the highlighted fields before saving.");
      const firstField = Object.keys(errors)[0];
      window.requestAnimationFrame(() => document.getElementById(`profile-${firstField}`)?.focus());
      return;
    }
    const payload: UpdateProfileInput = {
      username: form.username.trim(), displayName: form.displayName.trim(), bio: form.bio.trim() || null,
      dateOfBirth: form.dateOfBirth || null, countryCode: form.countryCode.trim().toUpperCase() || null,
    };
    setSaving(true);
    setApiError("");
    try {
      const result = await profileApi.updateCurrent(payload, avatarFile ?? undefined);
      setProfile(result);
      setForm(toForm(result));
      setAvatarFile(null);
      setAvatarPreview("");
      setEditing(false);
      setSaved(true);
      onProfileUpdated(result);
    } catch (error) {
      if (error instanceof AuthApiError && Object.keys(error.fieldErrors).length) setFieldErrors(error.fieldErrors as FieldErrors);
      const msg = getAuthErrorMessage(error, "Unable to update your profile. Please try again.");
      setApiError(msg);
      if (
        (error instanceof AuthApiError && (error.status === 409 || error.code === "USERNAME_ALREADY_EXISTS")) ||
        msg.toLowerCase().includes("username already exists") ||
        msg.toLowerCase().includes("trùng")
      ) {
        setFieldErrors((prev) => ({
          ...prev,
          username: "Tên người dùng (username) này đã tồn tại trong hệ thống. Vui lòng chọn username khác."
        }));
      }
    } finally {
      setSaving(false);
    }
  };

  const handleChangePassword = async (e: FormEvent) => {
    e.preventDefault();
    setPasswordError("");
    setPasswordSuccess("");

    if (!passwordForm.currentPassword) {
      setPasswordError("Vui lòng nhập mật khẩu hiện tại.");
      return;
    }
    if (!passwordForm.newPassword || passwordForm.newPassword.length < 8) {
      setPasswordError("Mật khẩu mới phải có tối thiểu 8 ký tự.");
      return;
    }
    if (!/^(?=.*[A-Z])(?=.*\d).+$/.test(passwordForm.newPassword)) {
      setPasswordError("Mật khẩu mới phải chứa ít nhất 1 chữ in hoa và 1 chữ số.");
      return;
    }
    if (passwordForm.newPassword !== passwordForm.confirmPassword) {
      setPasswordError("Mật khẩu xác nhận không khớp với mật khẩu mới.");
      return;
    }

    setPasswordSubmitting(true);
    try {
      const res = await profileApi.changePassword(passwordForm);
      setPasswordSuccess(res.message || "Đổi mật khẩu thành công!");
      setPasswordForm({ currentPassword: "", newPassword: "", confirmPassword: "" });
      setTimeout(() => {
        setPasswordModalOpen(false);
        setPasswordSuccess("");
      }, 2000);
    } catch (err) {
      setPasswordError(getAuthErrorMessage(err, "Đổi mật khẩu thất bại. Vui lòng kiểm tra lại mật khẩu hiện tại."));
    } finally {
      setPasswordSubmitting(false);
    }
  };

  if (loading) return <div className="profile-settings-page" aria-busy="true"><div className="profile-settings-skeleton skeleton" /><div className="profile-settings-skeleton profile-settings-skeleton--form skeleton" /></div>;
  if (!profile) return <div className="state-page"><span className="state-icon">!</span><h1>Unable to load your profile</h1><p>{apiError}</p><button className="button button-primary" onClick={() => void loadProfile()}>Try again</button></div>;

  const displayedAvatar = avatarPreview || profile.avatarUrl || "";
  return <div className="profile-settings-page">
    <section className="profile-settings-hero">
      <ProfileAvatar url={displayedAvatar} failed={avatarFailed} onError={() => setAvatarFailed(true)} />
      <div className="profile-hero-copy"><span className="eyebrow">PERSONAL PROFILE</span><h1>{profile.displayName}</h1><p>@{profile.username} · Member since {new Date(profile.createdAt).getFullYear()}</p></div>
      <div className="profile-hero-actions">
        <span className="profile-settings-role">{profile.role}</span>
        {!editing ? (
          <div style={{ display: "flex", gap: "8px" }}>
            <button className="button button-primary" onClick={beginEdit}>Edit profile</button>
            <button className="button button-secondary" onClick={() => setPasswordModalOpen(true)}>Change password</button>
          </div>
        ) : null}
      </div>
    </section>

    {saved ? <div className="profile-form-success" role="status"><CheckIcon width={17} height={17} /><span>Profile updated successfully.</span></div> : null}
    {!editing ? <ProfileDashboard profile={profile} onEdit={beginEdit} /> : <form className="profile-settings-form" onSubmit={submit} noValidate>
      <div className="profile-settings-heading"><div><span className="profile-section-kicker">EDIT MODE</span><h2>Update profile</h2><p>Changes will be reflected across your MagiSound account.</p></div><button type="button" className="button button-ghost" onClick={cancelEdit} disabled={saving}>Cancel</button></div>
      {apiError ? <div className="profile-form-alert" role="alert"><AlertIcon width={17} height={17} /><span>{apiError}</span></div> : null}
      <div className={`profile-avatar-editor ${fieldErrors.avatar ? "has-error" : ""}`}>
        <ProfileAvatar url={displayedAvatar} failed={avatarFailed} onError={() => setAvatarFailed(true)} compact />
        <div><strong>Profile picture</strong><p>JPG or PNG, up to 5MB. The image is securely stored in Cloudinary.</p>{avatarFile ? <small>{avatarFile.name}</small> : null}</div>
        <input ref={fileInputRef} id="profile-avatar" type="file" accept="image/jpeg,image/png" onChange={selectAvatar} />
        <button type="button" className="button button-secondary" onClick={() => fileInputRef.current?.click()}><UploadIcon width={16} height={16} />Choose image</button>
        {fieldErrors.avatar ? <span id="profile-avatar-error" className="profile-field-error"><AlertIcon width={12} height={12} />{fieldErrors.avatar}</span> : null}
      </div>
      <div className="profile-form-grid">
        <ProfileField label="Username" id="profile-username" error={fieldErrors.username}><input id="profile-username" value={form.username} onChange={(event) => updateField("username", event.target.value)} aria-invalid={Boolean(fieldErrors.username)} aria-describedby={fieldErrors.username ? "profile-username-error" : undefined} /></ProfileField>
        <ProfileField label="Display name" id="profile-displayName" error={fieldErrors.displayName}><input id="profile-displayName" value={form.displayName} onChange={(event) => updateField("displayName", event.target.value)} aria-invalid={Boolean(fieldErrors.displayName)} aria-describedby={fieldErrors.displayName ? "profile-displayName-error" : undefined} /></ProfileField>
        <ProfileField label="Date of birth" id="profile-dateOfBirth" error={fieldErrors.dateOfBirth}><input id="profile-dateOfBirth" type="date" value={form.dateOfBirth} onChange={(event) => updateField("dateOfBirth", event.target.value)} aria-invalid={Boolean(fieldErrors.dateOfBirth)} aria-describedby={fieldErrors.dateOfBirth ? "profile-dateOfBirth-error" : undefined} /></ProfileField>
        <ProfileField label="Country code" id="profile-countryCode" error={fieldErrors.countryCode} hint="ISO two-letter code, for example VN."><input id="profile-countryCode" maxLength={2} value={form.countryCode} onChange={(event) => updateField("countryCode", event.target.value.toUpperCase())} aria-invalid={Boolean(fieldErrors.countryCode)} aria-describedby={fieldErrors.countryCode ? "profile-countryCode-error" : undefined} /></ProfileField>
        <ProfileField label="Biography" id="profile-bio" error={fieldErrors.bio} wide hint={`${form.bio.length}/1000 characters`}><textarea id="profile-bio" rows={5} value={form.bio} onChange={(event) => updateField("bio", event.target.value)} aria-invalid={Boolean(fieldErrors.bio)} aria-describedby={fieldErrors.bio ? "profile-bio-error" : undefined} /></ProfileField>
      </div>
      <div className="profile-form-actions"><button type="button" className="button button-secondary" onClick={cancelEdit} disabled={saving}>Cancel</button><button type="submit" className="button button-primary" disabled={saving}>{saving ? "Saving…" : "Save changes"}</button></div>
    </form>}

    {passwordModalOpen && (
      <div className="modal-overlay" onClick={() => setPasswordModalOpen(false)} style={{ zIndex: 1100 }}>
        <div className="modal-card" onClick={(e) => e.stopPropagation()} style={{ maxWidth: "460px", width: "100%", padding: "26px" }}>
          <div className="modal-header" style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: "16px" }}>
            <div style={{ display: "flex", alignItems: "center", gap: "8px" }}>
              <LockIcon width={18} height={18} />
              <h2 style={{ margin: 0, fontSize: "18px", fontWeight: 700 }}>Đổi mật khẩu</h2>
            </div>
            <button type="button" onClick={() => setPasswordModalOpen(false)} style={{ background: "none", border: "none", cursor: "pointer", color: "#64748b" }}>
              <CloseIcon width={16} height={16} />
            </button>
          </div>
          {passwordSuccess ? (
            <div className="profile-form-success" role="status" style={{ marginBottom: "16px" }}>
              <CheckIcon width={17} height={17} />
              <span>{passwordSuccess}</span>
            </div>
          ) : (
            <form onSubmit={handleChangePassword}>
              {passwordError && (
                <div className="profile-form-alert" role="alert" style={{ marginBottom: "14px" }}>
                  <AlertIcon width={16} height={16} />
                  <span>{passwordError}</span>
                </div>
              )}
              <div style={{ display: "flex", flexDirection: "column", gap: "14px" }}>
                <div className="profile-form-field">
                  <label htmlFor="current-pwd">Mật khẩu hiện tại</label>
                  <input
                    id="current-pwd"
                    type="password"
                    value={passwordForm.currentPassword}
                    onChange={(e) => setPasswordForm((prev) => ({ ...prev, currentPassword: e.target.value }))}
                    placeholder="Nhập mật khẩu hiện tại"
                    required
                  />
                </div>
                <div className="profile-form-field">
                  <label htmlFor="new-pwd">Mật khẩu mới</label>
                  <input
                    id="new-pwd"
                    type="password"
                    value={passwordForm.newPassword}
                    onChange={(e) => setPasswordForm((prev) => ({ ...prev, newPassword: e.target.value }))}
                    placeholder="Tối thiểu 8 ký tự, 1 hoa, 1 số"
                    required
                  />
                  <small style={{ color: "#64748b", fontSize: "11px" }}>Tối thiểu 8 ký tự, bao gồm ít nhất 1 chữ hoa và 1 chữ số.</small>
                </div>
                <div className="profile-form-field">
                  <label htmlFor="confirm-pwd">Xác nhận mật khẩu mới</label>
                  <input
                    id="confirm-pwd"
                    type="password"
                    value={passwordForm.confirmPassword}
                    onChange={(e) => setPasswordForm((prev) => ({ ...prev, confirmPassword: e.target.value }))}
                    placeholder="Nhập lại mật khẩu mới"
                    required
                  />
                </div>
              </div>
              <div className="modal-actions" style={{ marginTop: "20px", display: "flex", justifyContent: "flex-end", gap: "10px" }}>
                <button type="button" className="button button-secondary" onClick={() => setPasswordModalOpen(false)} disabled={passwordSubmitting}>
                  Hủy
                </button>
                <button type="submit" className="button button-primary" disabled={passwordSubmitting}>
                  {passwordSubmitting ? "Đang lưu..." : "Xác nhận đổi"}
                </button>
              </div>
            </form>
          )}
        </div>
      </div>
    )}
  </div>;
}

function ProfileDashboard({ profile, onEdit }: { profile: ProfileDetails; onEdit: () => void }) {
  return <section className="profile-dashboard">
    <div className="profile-about-card"><span className="profile-section-kicker">ABOUT</span><h2>Biography</h2><p>{profile.bio || "You have not added a biography yet. Tell listeners a little about yourself."}</p>{!profile.bio ? <button onClick={onEdit}>Add biography</button> : null}</div>
    <div className="profile-details-card"><div className="profile-card-heading"><div><span className="profile-section-kicker">ACCOUNT DETAILS</span><h2>Personal information</h2></div></div><dl>
      <div><dt><UserIcon width={17} height={17} />Username</dt><dd>@{profile.username}</dd></div>
      <div><dt><MailIcon width={17} height={17} />Email</dt><dd>{profile.email}</dd></div>
      <div><dt><ClockIcon width={17} height={17} />Date of birth</dt><dd>{formatDate(profile.dateOfBirth)}</dd></div>
      <div><dt><span className="profile-country-icon">◎</span>Country</dt><dd>{profile.countryCode || "Not provided"}</dd></div>
    </dl></div>
  </section>;
}

function ProfileAvatar({ url, failed, onError, compact = false }: { url: string; failed: boolean; onError: () => void; compact?: boolean }) {
  return <div className={`profile-settings-avatar ${compact ? "profile-settings-avatar--compact" : ""}`}>{url && !failed ? <img src={url} alt="Profile avatar" onError={onError} /> : <UserIcon width={compact ? 28 : 38} height={compact ? 28 : 38} />}</div>;
}

function ProfileField({ label, id, error, hint, wide = false, children }: { label: string; id: string; error?: string; hint?: string; wide?: boolean; children: ReactNode }) {
  return <div className={`profile-form-field ${wide ? "profile-form-field--wide" : ""} ${error ? "has-error" : ""}`}><label htmlFor={id}>{label}</label>{children}{error ? <small id={`${id}-error`} className="profile-field-error"><AlertIcon width={12} height={12} />{error}</small> : hint ? <small>{hint}</small> : null}</div>;
}
