--
-- PostgreSQL database dump
--

\restrict 5zbmZ1MlTgyEtrLioss3RaR3qe4QDAaInNyHIjfTRGI5sIfd9HBXSEbkMCjmEj3

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.staffs DROP CONSTRAINT IF EXISTS staffs_role_id_fkey;
ALTER TABLE IF EXISTS ONLY public.refresh_tokens DROP CONSTRAINT IF EXISTS refresh_tokens_staff_id_fkey;
ALTER TABLE IF EXISTS ONLY public.password_reset_tokens DROP CONSTRAINT IF EXISTS password_reset_tokens_staff_id_fkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_staff_id_fkey;
ALTER TABLE IF EXISTS ONLY public.refresh_tokens DROP CONSTRAINT IF EXISTS fkt72gijoak5yufxws745gwflis;
ALTER TABLE IF EXISTS ONLY public.password_reset_tokens DROP CONSTRAINT IF EXISTS fkk4vaguhrxs5jl3lqtshglaxo8;
ALTER TABLE IF EXISTS ONLY public.official_lyrics DROP CONSTRAINT IF EXISTS fkaapwxgur5skqdrnov9ldxgq9o;
ALTER TABLE IF EXISTS ONLY public.account_unlock_tokens DROP CONSTRAINT IF EXISTS fka3fpk5xbjuof254bc5skirifc;
ALTER TABLE IF EXISTS ONLY public.user_profiles DROP CONSTRAINT IF EXISTS fk_user_profiles_app_users;
ALTER TABLE IF EXISTS ONLY public.tracks DROP CONSTRAINT IF EXISTS fk_tracks_uploader_app_users;
ALTER TABLE IF EXISTS ONLY public.tracks DROP CONSTRAINT IF EXISTS fk_tracks_genres;
ALTER TABLE IF EXISTS ONLY public.tracks DROP CONSTRAINT IF EXISTS fk_tracks_albums;
ALTER TABLE IF EXISTS ONLY public.track_submissions DROP CONSTRAINT IF EXISTS fk_track_submissions_tracks;
ALTER TABLE IF EXISTS ONLY public.track_submissions DROP CONSTRAINT IF EXISTS fk_track_submissions_submitter_app_users;
ALTER TABLE IF EXISTS ONLY public.track_submissions DROP CONSTRAINT IF EXISTS fk_track_submissions_reviewer_app_users;
ALTER TABLE IF EXISTS ONLY public.system_reviews DROP CONSTRAINT IF EXISTS fk_system_reviews_app_users;
ALTER TABLE IF EXISTS ONLY public.refresh_tokens DROP CONSTRAINT IF EXISTS fk_refresh_tokens_app_users;
ALTER TABLE IF EXISTS ONLY public.playlists DROP CONSTRAINT IF EXISTS fk_playlists_owner_app_users;
ALTER TABLE IF EXISTS ONLY public.playlist_tracks DROP CONSTRAINT IF EXISTS fk_playlist_tracks_tracks;
ALTER TABLE IF EXISTS ONLY public.playlist_tracks DROP CONSTRAINT IF EXISTS fk_playlist_tracks_playlists;
ALTER TABLE IF EXISTS ONLY public.playlist_tracks DROP CONSTRAINT IF EXISTS fk_playlist_tracks_added_by_app_users;
ALTER TABLE IF EXISTS ONLY public.personal_lyrics DROP CONSTRAINT IF EXISTS fk_personal_lyrics_tracks;
ALTER TABLE IF EXISTS ONLY public.personal_lyrics DROP CONSTRAINT IF EXISTS fk_personal_lyrics_app_users;
ALTER TABLE IF EXISTS ONLY public.password_reset_tokens DROP CONSTRAINT IF EXISTS fk_password_reset_tokens_app_users;
ALTER TABLE IF EXISTS ONLY public.official_lyrics DROP CONSTRAINT IF EXISTS fk_official_lyrics_tracks;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS fk_notifications_app_users;
ALTER TABLE IF EXISTS ONLY public.listening_history DROP CONSTRAINT IF EXISTS fk_listening_history_tracks;
ALTER TABLE IF EXISTS ONLY public.listening_history DROP CONSTRAINT IF EXISTS fk_listening_history_app_users;
ALTER TABLE IF EXISTS ONLY public.genres DROP CONSTRAINT IF EXISTS fk_genres_created_by_app_users;
ALTER TABLE IF EXISTS ONLY public.favorites DROP CONSTRAINT IF EXISTS fk_favorites_tracks;
ALTER TABLE IF EXISTS ONLY public.favorites DROP CONSTRAINT IF EXISTS fk_favorites_app_users;
ALTER TABLE IF EXISTS ONLY public.email_verification_tokens DROP CONSTRAINT IF EXISTS fk_email_verification_tokens_app_users;
ALTER TABLE IF EXISTS ONLY public.content_reports DROP CONSTRAINT IF EXISTS fk_content_reports_tracks;
ALTER TABLE IF EXISTS ONLY public.content_reports DROP CONSTRAINT IF EXISTS fk_content_reports_submitter_app_users;
ALTER TABLE IF EXISTS ONLY public.content_reports DROP CONSTRAINT IF EXISTS fk_content_reports_handler_app_users;
ALTER TABLE IF EXISTS ONLY public.albums DROP CONSTRAINT IF EXISTS fk_albums_created_by_app_users;
ALTER TABLE IF EXISTS ONLY public.app_users DROP CONSTRAINT IF EXISTS fk7sipqsfa0da9aj10gga1iqnk1;
ALTER TABLE IF EXISTS ONLY public.email_verification_tokens DROP CONSTRAINT IF EXISTS fk3p1m42k50qhjbo815nl38nfby;
ALTER TABLE IF EXISTS ONLY public.account_unlock_tokens DROP CONSTRAINT IF EXISTS account_unlock_tokens_staff_id_fkey;
DROP INDEX IF EXISTS public.ux_track_submissions_one_pending_per_track;
DROP INDEX IF EXISTS public.ix_tracks_uploader_user_id;
DROP INDEX IF EXISTS public.ix_tracks_public_catalog;
DROP INDEX IF EXISTS public.ix_tracks_album_id;
DROP INDEX IF EXISTS public.ix_track_submissions_moderation_queue;
DROP INDEX IF EXISTS public.ix_system_reviews_user_id;
DROP INDEX IF EXISTS public.ix_system_reviews_status;
DROP INDEX IF EXISTS public.ix_refresh_tokens_active_by_user;
DROP INDEX IF EXISTS public.ix_playlists_public;
DROP INDEX IF EXISTS public.ix_playlists_owner_user_id;
DROP INDEX IF EXISTS public.ix_playlist_tracks_track_id;
DROP INDEX IF EXISTS public.ix_personal_lyrics_user_track;
DROP INDEX IF EXISTS public.ix_password_reset_tokens_user_id;
DROP INDEX IF EXISTS public.ix_notifications_user_unread;
DROP INDEX IF EXISTS public.ix_listening_history_user_played_at;
DROP INDEX IF EXISTS public.ix_favorites_track_id;
DROP INDEX IF EXISTS public.ix_email_verification_tokens_user_id;
DROP INDEX IF EXISTS public.ix_content_reports_submitter;
DROP INDEX IF EXISTS public.ix_content_reports_moderation_queue;
DROP INDEX IF EXISTS public.ix_app_users_status;
DROP INDEX IF EXISTS public.ix_albums_created_by_user_id;
DROP INDEX IF EXISTS public.idx_notifications_user_created;
DROP INDEX IF EXISTS public.idx_notifications_staff_created;
ALTER TABLE IF EXISTS ONLY public.user_profiles DROP CONSTRAINT IF EXISTS uq_user_profiles_username;
ALTER TABLE IF EXISTS ONLY public.tracks DROP CONSTRAINT IF EXISTS uq_tracks_slug;
ALTER TABLE IF EXISTS ONLY public.refresh_tokens DROP CONSTRAINT IF EXISTS uq_refresh_tokens_hash;
ALTER TABLE IF EXISTS ONLY public.playlist_tracks DROP CONSTRAINT IF EXISTS uq_playlist_tracks_position;
ALTER TABLE IF EXISTS ONLY public.personal_lyrics DROP CONSTRAINT IF EXISTS uq_personal_lyrics_user_track_type;
ALTER TABLE IF EXISTS ONLY public.password_reset_tokens DROP CONSTRAINT IF EXISTS uq_password_reset_tokens_hash;
ALTER TABLE IF EXISTS ONLY public.official_lyrics DROP CONSTRAINT IF EXISTS uq_official_lyrics_track;
ALTER TABLE IF EXISTS ONLY public.genres DROP CONSTRAINT IF EXISTS uq_genres_slug;
ALTER TABLE IF EXISTS ONLY public.genres DROP CONSTRAINT IF EXISTS uq_genres_name;
ALTER TABLE IF EXISTS ONLY public.email_verification_tokens DROP CONSTRAINT IF EXISTS uq_email_verification_tokens_hash;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS uq_app_users_email;
ALTER TABLE IF EXISTS ONLY public.albums DROP CONSTRAINT IF EXISTS uq_albums_slug;
ALTER TABLE IF EXISTS ONLY public.roles DROP CONSTRAINT IF EXISTS ukch1113horj4qr56f91omojv8;
ALTER TABLE IF EXISTS ONLY public.playlists DROP CONSTRAINT IF EXISTS ukbq229u3bbkas0bmcvn265p3b2;
ALTER TABLE IF EXISTS ONLY public.playlist_tracks DROP CONSTRAINT IF EXISTS uk_playlist_track;
ALTER TABLE IF EXISTS ONLY public.app_users DROP CONSTRAINT IF EXISTS uk4vj92ux8a2eehds1mdvmks473;
ALTER TABLE IF EXISTS ONLY public.staffs DROP CONSTRAINT IF EXISTS staffs_pkey;
ALTER TABLE IF EXISTS ONLY public.staffs DROP CONSTRAINT IF EXISTS staffs_email_key;
ALTER TABLE IF EXISTS ONLY public.staff_roles DROP CONSTRAINT IF EXISTS staff_roles_pkey;
ALTER TABLE IF EXISTS ONLY public.staff_roles DROP CONSTRAINT IF EXISTS staff_roles_code_key;
ALTER TABLE IF EXISTS ONLY public.roles DROP CONSTRAINT IF EXISTS roles_pkey;
ALTER TABLE IF EXISTS ONLY public.user_profiles DROP CONSTRAINT IF EXISTS pk_user_profiles;
ALTER TABLE IF EXISTS ONLY public.tracks DROP CONSTRAINT IF EXISTS pk_tracks;
ALTER TABLE IF EXISTS ONLY public.track_submissions DROP CONSTRAINT IF EXISTS pk_track_submissions;
ALTER TABLE IF EXISTS ONLY public.system_reviews DROP CONSTRAINT IF EXISTS pk_system_reviews;
ALTER TABLE IF EXISTS ONLY public.refresh_tokens DROP CONSTRAINT IF EXISTS pk_refresh_tokens;
ALTER TABLE IF EXISTS ONLY public.playlists DROP CONSTRAINT IF EXISTS pk_playlists;
ALTER TABLE IF EXISTS ONLY public.playlist_tracks DROP CONSTRAINT IF EXISTS pk_playlist_tracks;
ALTER TABLE IF EXISTS ONLY public.personal_lyrics DROP CONSTRAINT IF EXISTS pk_personal_lyrics;
ALTER TABLE IF EXISTS ONLY public.password_reset_tokens DROP CONSTRAINT IF EXISTS pk_password_reset_tokens;
ALTER TABLE IF EXISTS ONLY public.official_lyrics DROP CONSTRAINT IF EXISTS pk_official_lyrics;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS pk_notifications;
ALTER TABLE IF EXISTS ONLY public.listening_history DROP CONSTRAINT IF EXISTS pk_listening_history;
ALTER TABLE IF EXISTS ONLY public.genres DROP CONSTRAINT IF EXISTS pk_genres;
ALTER TABLE IF EXISTS ONLY public.favorites DROP CONSTRAINT IF EXISTS pk_favorites;
ALTER TABLE IF EXISTS ONLY public.email_verification_tokens DROP CONSTRAINT IF EXISTS pk_email_verification_tokens;
ALTER TABLE IF EXISTS ONLY public.content_reports DROP CONSTRAINT IF EXISTS pk_content_reports;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS pk_app_users;
ALTER TABLE IF EXISTS ONLY public.albums DROP CONSTRAINT IF EXISTS pk_albums;
ALTER TABLE IF EXISTS ONLY public.app_users DROP CONSTRAINT IF EXISTS app_users_pkey;
ALTER TABLE IF EXISTS ONLY public.account_unlock_tokens DROP CONSTRAINT IF EXISTS account_unlock_tokens_pkey;
DROP TABLE IF EXISTS public.user_profiles;
DROP TABLE IF EXISTS public.tracks;
DROP TABLE IF EXISTS public.track_submissions;
DROP TABLE IF EXISTS public.system_reviews;
DROP TABLE IF EXISTS public.staffs;
DROP TABLE IF EXISTS public.staff_roles;
DROP TABLE IF EXISTS public.roles;
DROP TABLE IF EXISTS public.refresh_tokens;
DROP TABLE IF EXISTS public.playlists;
DROP TABLE IF EXISTS public.playlist_tracks;
DROP TABLE IF EXISTS public.personal_lyrics;
DROP TABLE IF EXISTS public.password_reset_tokens;
DROP TABLE IF EXISTS public.official_lyrics;
DROP TABLE IF EXISTS public.notifications;
DROP TABLE IF EXISTS public.listening_history;
DROP TABLE IF EXISTS public.genres;
DROP TABLE IF EXISTS public.favorites;
DROP TABLE IF EXISTS public.email_verification_tokens;
DROP TABLE IF EXISTS public.content_reports;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.app_users;
DROP TABLE IF EXISTS public.albums;
DROP TABLE IF EXISTS public.account_unlock_tokens;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_unlock_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.account_unlock_tokens (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    expires_at timestamp(6) without time zone NOT NULL,
    token_hash character varying(255) NOT NULL,
    used_at timestamp(6) without time zone,
    user_id bigint,
    staff_id bigint
);


--
-- Name: account_unlock_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.account_unlock_tokens ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_unlock_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: albums; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.albums (
    id bigint NOT NULL,
    created_by_user_id bigint NOT NULL,
    title character varying(200) NOT NULL,
    slug character varying(220) NOT NULL,
    description character varying(2000),
    status character varying(30) DEFAULT 'DRAFT'::character varying NOT NULL,
    cover_public_id character varying(255),
    cover_url character varying(2048),
    release_date date,
    published_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    latest_rejection_reason character varying(1000),
    reviewed_at timestamp(6) without time zone,
    reviewer_note character varying(2000),
    reviewer_user_id bigint,
    CONSTRAINT ck_albums_status CHECK (((status)::text = ANY (ARRAY[('DRAFT'::character varying)::text, ('PUBLISHED'::character varying)::text])))
);


--
-- Name: albums_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.albums ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.albums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: app_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_users (
    id bigint CONSTRAINT app_users_id_not_null1 NOT NULL,
    created_at timestamp(6) without time zone CONSTRAINT app_users_created_at_not_null1 NOT NULL,
    deleted_at timestamp(6) without time zone,
    email character varying(320) CONSTRAINT app_users_email_not_null1 NOT NULL,
    email_verified_at timestamp(6) without time zone,
    last_login_at timestamp(6) without time zone,
    locked_until timestamp(6) without time zone,
    password_hash character varying(255) CONSTRAINT app_users_password_hash_not_null1 NOT NULL,
    status character varying(30) CONSTRAINT app_users_status_not_null1 NOT NULL,
    updated_at timestamp(6) without time zone CONSTRAINT app_users_updated_at_not_null1 NOT NULL,
    role_id smallint NOT NULL,
    CONSTRAINT app_users_status_check CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('ACTIVE'::character varying)::text, ('TEMPORARILY_LOCKED'::character varying)::text, ('BANNED'::character varying)::text])))
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint CONSTRAINT app_users_id_not_null NOT NULL,
    email character varying(320) CONSTRAINT app_users_email_not_null NOT NULL,
    password_hash character varying(255) CONSTRAINT app_users_password_hash_not_null NOT NULL,
    status character varying(30) DEFAULT 'PENDING'::character varying CONSTRAINT app_users_status_not_null NOT NULL,
    email_verified_at timestamp(3) without time zone,
    last_login_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) CONSTRAINT app_users_created_at_not_null NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) CONSTRAINT app_users_updated_at_not_null NOT NULL,
    locked_until timestamp(6) without time zone,
    CONSTRAINT ck_app_users_status CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('ACTIVE'::character varying)::text, ('BANNED'::character varying)::text])))
);


--
-- Name: app_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.app_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: app_users_id_seq1; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.app_users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.app_users_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: content_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content_reports (
    id bigint NOT NULL,
    track_id bigint NOT NULL,
    submitted_by_user_id bigint NOT NULL,
    handled_by_user_id bigint,
    category character varying(50) NOT NULL,
    description character varying(2000) NOT NULL,
    status character varying(50) DEFAULT 'PENDING'::character varying NOT NULL,
    resolution_note character varying(2000),
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    handled_at timestamp(3) without time zone,
    updated_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    reason character varying(100),
    reporter_id bigint,
    resolved_at timestamp(6) with time zone,
    reviewer_id bigint,
    reviewer_note text,
    target_id bigint,
    target_type character varying(50),
    CONSTRAINT ck_content_reports_category CHECK (((category)::text = ANY (ARRAY[('COPYRIGHT'::character varying)::text, ('INAPPROPRIATE_CONTENT'::character varying)::text, ('INCORRECT_METADATA'::character varying)::text, ('OTHER'::character varying)::text]))),
    CONSTRAINT ck_content_reports_handling CHECK (((((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('WITHDRAWN'::character varying)::text])) AND (handled_at IS NULL)) OR (((status)::text = ANY (ARRAY[('RESOLVED'::character varying)::text, ('REJECTED'::character varying)::text])) AND (handled_by_user_id IS NOT NULL) AND (handled_at IS NOT NULL) AND (resolution_note IS NOT NULL)))),
    CONSTRAINT ck_content_reports_status CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('RESOLVED'::character varying)::text, ('REJECTED'::character varying)::text, ('WITHDRAWN'::character varying)::text])))
);


--
-- Name: content_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.content_reports ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.content_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: email_verification_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_verification_tokens (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token_hash character varying(255) NOT NULL,
    expires_at timestamp(3) without time zone NOT NULL,
    used_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    CONSTRAINT ck_email_verification_tokens_expiry CHECK ((expires_at > created_at))
);


--
-- Name: email_verification_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.email_verification_tokens ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.email_verification_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.favorites (
    user_id bigint NOT NULL,
    track_id bigint NOT NULL,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL
);


--
-- Name: genres; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genres (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    description character varying(1000),
    is_active boolean DEFAULT true NOT NULL,
    created_by_user_id bigint,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL
);


--
-- Name: genres_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.genres ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.genres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: listening_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.listening_history (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    track_id bigint NOT NULL,
    listened_duration_ms integer NOT NULL,
    completed boolean DEFAULT false NOT NULL,
    played_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    CONSTRAINT ck_listening_history_duration CHECK ((listened_duration_ms >= 0))
);


--
-- Name: listening_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.listening_history ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.listening_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    user_id bigint,
    type character varying(50) NOT NULL,
    title character varying(150) NOT NULL,
    message character varying(500) NOT NULL,
    action_url character varying(2048),
    read_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    actor_id bigint,
    reference_id character varying(100),
    reference_type character varying(50),
    is_read boolean DEFAULT false NOT NULL,
    staff_id bigint,
    CONSTRAINT ck_notifications_type CHECK (((type)::text = ANY ((ARRAY['TRACK_APPROVED'::character varying, 'TRACK_REJECTED'::character varying, 'TRACK_TAKEN_DOWN'::character varying, 'TRACK_SUBMISSION'::character varying, 'REPORT_RESOLVED'::character varying, 'REPORT_REJECTED'::character varying, 'CONTENT_REPORT'::character varying, 'ACCOUNT_STATUS_CHANGED'::character varying, 'ROLE_CHANGED'::character varying, 'SYSTEM'::character varying, 'SYSTEM_NOTICE'::character varying])::text[])))
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.notifications ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: official_lyrics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.official_lyrics (
    id bigint NOT NULL,
    track_id bigint NOT NULL,
    lyric_content text NOT NULL,
    status character varying(30) DEFAULT 'DRAFT'::character varying NOT NULL,
    created_by_user_id bigint NOT NULL,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    CONSTRAINT ck_official_lyrics_status CHECK (((status)::text = ANY (ARRAY[('DRAFT'::character varying)::text, ('PUBLISHED'::character varying)::text])))
);


--
-- Name: official_lyrics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.official_lyrics ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.official_lyrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens (
    id bigint NOT NULL,
    user_id bigint,
    token_hash character varying(255) NOT NULL,
    expires_at timestamp(3) without time zone NOT NULL,
    used_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    staff_id bigint,
    CONSTRAINT ck_password_reset_tokens_expiry CHECK ((expires_at > created_at))
);


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.password_reset_tokens ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.password_reset_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: personal_lyrics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.personal_lyrics (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    track_id bigint NOT NULL,
    lyric_type character varying(20) DEFAULT 'CUSTOM'::character varying NOT NULL,
    lyric_content text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    CONSTRAINT ck_personal_lyrics_type CHECK (((lyric_type)::text = ANY (ARRAY[('CUSTOM'::character varying)::text, ('TRANSLATION'::character varying)::text])))
);


--
-- Name: personal_lyrics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.personal_lyrics ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.personal_lyrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: playlist_tracks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.playlist_tracks (
    playlist_id bigint NOT NULL,
    track_id bigint NOT NULL,
    added_by_user_id bigint NOT NULL,
    "position" integer NOT NULL,
    added_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    id bigint NOT NULL,
    CONSTRAINT ck_playlist_tracks_position CHECK (("position" > 0))
);


--
-- Name: playlist_tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.playlist_tracks ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.playlist_tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: playlists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.playlists (
    id bigint NOT NULL,
    owner_user_id bigint NOT NULL,
    name character varying(150) NOT NULL,
    description character varying(2000),
    visibility character varying(30) DEFAULT 'PRIVATE'::character varying NOT NULL,
    cover_public_id character varying(255),
    cover_url character varying(2048),
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    created_by_user_id bigint NOT NULL,
    is_private boolean NOT NULL,
    slug character varying(180) NOT NULL,
    title character varying(150) NOT NULL,
    CONSTRAINT ck_playlists_visibility CHECK (((visibility)::text = ANY (ARRAY[('PUBLIC'::character varying)::text, ('PRIVATE'::character varying)::text])))
);


--
-- Name: playlists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.playlists ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.playlists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.refresh_tokens (
    id bigint NOT NULL,
    user_id bigint,
    token_hash character varying(255) NOT NULL,
    expires_at timestamp(3) without time zone NOT NULL,
    revoked_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    staff_id bigint,
    CONSTRAINT ck_refresh_tokens_expiry CHECK ((expires_at > created_at))
);


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.refresh_tokens ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id smallint NOT NULL,
    code character varying(30) NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    description character varying(500),
    name character varying(80) NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.roles ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: staff_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.staff_roles (
    id smallint NOT NULL,
    code character varying(30) NOT NULL,
    name character varying(80) NOT NULL,
    description character varying(500),
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL
);


--
-- Name: staff_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.staff_roles ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.staff_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: staffs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.staffs (
    id bigint NOT NULL,
    role_id smallint NOT NULL,
    email character varying(320) NOT NULL,
    password_hash character varying(255) NOT NULL,
    full_name character varying(120) NOT NULL,
    avatar_url character varying(2048),
    status character varying(30) DEFAULT 'ACTIVE'::character varying NOT NULL,
    last_login_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.staffs ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: system_reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.system_reviews (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    rating smallint NOT NULL,
    comment character varying(2000),
    status character varying(30) DEFAULT 'PENDING'::character varying NOT NULL,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    CONSTRAINT ck_system_reviews_rating CHECK (((rating >= 1) AND (rating <= 5))),
    CONSTRAINT ck_system_reviews_status CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('ACKNOWLEDGED'::character varying)::text, ('HIDDEN'::character varying)::text])))
);


--
-- Name: system_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.system_reviews ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.system_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: track_submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.track_submissions (
    id bigint NOT NULL,
    track_id bigint NOT NULL,
    submitted_by_user_id bigint NOT NULL,
    reviewer_user_id bigint,
    status character varying(30) DEFAULT 'PENDING'::character varying NOT NULL,
    submitter_note character varying(2000),
    reviewer_note character varying(2000),
    rejection_reason character varying(1000),
    submitted_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    reviewed_at timestamp(3) without time zone,
    CONSTRAINT ck_track_submissions_rejection_reason CHECK ((((status)::text <> 'REJECTED'::text) OR (rejection_reason IS NOT NULL))),
    CONSTRAINT ck_track_submissions_review_result CHECK (((((status)::text = 'PENDING'::text) AND (reviewed_at IS NULL)) OR (((status)::text = ANY (ARRAY[('APPROVED'::character varying)::text, ('REJECTED'::character varying)::text])) AND (reviewer_user_id IS NOT NULL) AND (reviewed_at IS NOT NULL)))),
    CONSTRAINT ck_track_submissions_status CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('APPROVED'::character varying)::text, ('REJECTED'::character varying)::text])))
);


--
-- Name: track_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.track_submissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.track_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tracks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tracks (
    id bigint NOT NULL,
    uploader_user_id bigint NOT NULL,
    album_id bigint,
    genre_id bigint NOT NULL,
    title character varying(200) NOT NULL,
    slug character varying(220) NOT NULL,
    description character varying(2000),
    track_number integer,
    publication_status character varying(30) DEFAULT 'DRAFT'::character varying NOT NULL,
    approved_at timestamp(3) without time zone,
    latest_rejection_reason character varying(1000),
    audio_public_id character varying(255),
    audio_url character varying(2048),
    audio_format character varying(20) NOT NULL,
    duration_ms integer NOT NULL,
    cover_public_id character varying(255),
    cover_url character varying(2048),
    play_count_cache bigint DEFAULT 0 NOT NULL,
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    lyrics text,
    CONSTRAINT ck_tracks_duration_ms CHECK ((duration_ms >= 0)),
    CONSTRAINT ck_tracks_play_count_cache CHECK ((play_count_cache >= 0)),
    CONSTRAINT ck_tracks_publication_status CHECK (((publication_status)::text = ANY (ARRAY[('DRAFT'::character varying)::text, ('PENDING'::character varying)::text, ('PUBLISHED'::character varying)::text, ('REJECTED'::character varying)::text, ('TAKEN_DOWN'::character varying)::text]))),
    CONSTRAINT ck_tracks_track_number CHECK (((track_number IS NULL) OR (track_number > 0)))
);


--
-- Name: tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.tracks ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_profiles (
    user_id bigint NOT NULL,
    username character varying(50) NOT NULL,
    display_name character varying(120) NOT NULL,
    bio character varying(1000),
    avatar_public_id character varying(255),
    avatar_url character varying(2048),
    date_of_birth date,
    country_code character(2),
    created_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)) NOT NULL
);


--
-- Data for Name: account_unlock_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.account_unlock_tokens (id, created_at, expires_at, token_hash, used_at, user_id, staff_id) FROM stdin;
\.


--
-- Data for Name: albums; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.albums (id, created_by_user_id, title, slug, description, status, cover_public_id, cover_url, release_date, published_at, created_at, updated_at, latest_rejection_reason, reviewed_at, reviewer_note, reviewer_user_id) FROM stdin;
1	3	Rap	rap-1791638067718	abc	PUBLISHED	soundwave/albums/covers/user-3-album-cover-0bc87820-18c4-41f4-a517-6eb2462f1f93	https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791638066/soundwave/albums/covers/user-3-album-cover-0bc87820-18c4-41f4-a517-6eb2462f1f93.jpg	2026-10-10	2026-10-10 06:14:27.989	2026-10-10 06:14:27.72	2026-10-10 06:14:28.033	\N	\N	\N	\N
10	7	HVL	hvl-1792081422268	HVL Album description	PUBLISHED	soundwave/albums/covers/user-7-album-cover-95bb81e1-bac1-4525-af40-93cea2143976	https://res.cloudinary.com/dq0jm9tlt/image/upload/v1792081546/soundwave/albums/covers/user-7-album-cover-95bb81e1-bac1-4525-af40-93cea2143976.jpg	2026-10-15	2026-10-15 14:28:26.196	2026-10-15 09:23:42.271	2026-10-15 14:28:32.6	\N	\N	\N	\N
11	8	TINHHA	tinhha-1792319206587	This is an upbeat song.	PUBLISHED	soundwave/albums/covers/user-8-album-cover-cc31450f-a733-4957-932d-a6de9f544701	https://res.cloudinary.com/dq0jm9tlt/image/upload/v1792319206/soundwave/albums/covers/user-8-album-cover-cc31450f-a733-4957-932d-a6de9f544701.png	2026-10-18	2026-10-18 03:32:16.177	2026-10-18 03:26:46.591	2026-10-18 03:32:22.53	\N	\N	\N	\N
12	8	ANHTRAISAYHI	anhtraisayhi-1792321662147	songs that evoke intense emotions	PUBLISHED	soundwave/albums/covers/user-8-album-cover-02816132-3f58-4dd0-bd86-45bbb9ea1999	https://res.cloudinary.com/dq0jm9tlt/image/upload/v1792321661/soundwave/albums/covers/user-8-album-cover-02816132-3f58-4dd0-bd86-45bbb9ea1999.png	2026-10-18	2026-10-18 04:08:58.693	2026-10-18 04:07:42.148	2026-10-18 04:09:04.696	\N	\N	\N	\N
15	10	Nhạc hay	nhac-hay-1793151460992	\N	PUBLISHED	\N	\N	2026-10-28	2026-10-27 18:40:20.221	2026-10-27 18:37:40.994	2026-10-27 18:41:46.242	\N	\N	\N	\N
16	8	MRT	mrt-1793439786130	\N	DRAFT	soundwave/albums/covers/user-8-album-cover-bf5eae17-996a-4b95-a465-a765438c608b	https://res.cloudinary.com/dq0jm9tlt/image/upload/v1793439719/soundwave/albums/covers/user-8-album-cover-bf5eae17-996a-4b95-a465-a765438c608b.png	2026-10-31	\N	2026-10-31 02:43:06.135	2026-10-31 02:43:06.135	\N	\N	\N	\N
\.


--
-- Data for Name: app_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.app_users (id, created_at, deleted_at, email, email_verified_at, last_login_at, locked_until, password_hash, status, updated_at, role_id) FROM stdin;
16	2026-11-08 13:10:31.02521	\N	yorushika@soundwave.io	2026-11-08 13:10:31.02521	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.461964	7
17	2026-11-08 13:10:31.178126	\N	yokotakahashi@soundwave.io	2026-11-08 13:10:31.178126	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.462568	7
18	2026-11-08 13:10:31.288518	\N	yamazaki@soundwave.io	2026-11-08 13:10:31.288518	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.463122	7
19	2026-11-08 13:10:31.485272	\N	lowg@soundwave.io	2026-11-08 13:10:31.485272	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.463547	7
20	2026-11-08 13:10:31.639202	\N	minhan.creator@soundwave.io	2026-11-08 13:10:31.639202	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.463953	7
21	2026-11-11 19:10:10.848145	\N	staff@soundwave.com	2026-11-11 19:10:10.848145	2026-11-11 05:13:48.290748	\N	$2a$10$opEBNf4sVhsea9EdiByZgeBm.gbgepisIi8xvCa.3NCHk9YasUtei	ACTIVE	2026-11-11 05:13:48.290748	8
22	2026-11-11 19:10:10.848145	\N	admin@soundwave.com	2026-11-11 19:10:10.848145	2026-11-11 05:13:56.59727	\N	$2a$10$Yx.i0SMK5FTLveuSQXhfc.UsQqKXpyLy7T/0jILIeK7TkgjyHSEvq	ACTIVE	2026-11-11 05:13:56.59727	9
7	2026-11-08 13:10:31.868801	\N	dotranthienphuc230@gmail.com	2026-11-08 13:10:31.868801	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.465041	7
8	2026-11-08 13:10:31.983234	\N	minhtriojt@gmail.com	2026-11-08 13:10:31.983234	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.465747	7
10	2026-11-08 13:10:30.326318	\N	sontungmtp@soundwave.io	2026-11-08 13:10:30.326318	2026-11-08 07:09:39.486317	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.455913	7
11	2026-11-08 13:10:30.416356	\N	hieuthuhai@soundwave.io	2026-11-08 13:10:30.416356	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.457335	7
12	2026-11-08 13:10:30.592302	\N	mck@soundwave.io	2026-11-08 13:10:30.592302	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.45836	7
9	2026-11-08 13:10:32.084279	\N	truonganhtuan04072020@gmail.com	2026-11-08 13:10:32.084279	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.46658	7
4	2026-11-05 07:58:13.605123	\N	admin@magisound.com	2026-11-05 07:58:13.604008	2026-11-11 08:39:33.60823	\N	$2a$10$Yx.i0SMK5FTLveuSQXhfc.UsQqKXpyLy7T/0jILIeK7TkgjyHSEvq	ACTIVE	2026-11-11 08:39:33.60823	9
13	2026-11-08 13:10:30.6865	\N	uyenlinh@soundwave.io	2026-11-08 13:10:30.6865	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.45965	7
3	2026-11-08 13:10:31.733261	\N	lehaiduy1900@gmail.com	2026-11-08 13:10:31.733261	2026-11-11 08:58:34.026484	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 08:58:34.026484	7
5	2026-11-05 07:58:13.988527	\N	staff@magisound.com	2026-11-05 07:58:13.986906	2026-11-11 08:59:02.49356	\N	$2a$10$opEBNf4sVhsea9EdiByZgeBm.gbgepisIi8xvCa.3NCHk9YasUtei	ACTIVE	2026-11-11 08:59:02.49356	8
14	2026-11-08 13:10:30.805238	\N	hngle@soundwave.io	2026-11-08 13:10:30.805238	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.460441	7
15	2026-11-08 13:10:30.925326	\N	yoasobi@soundwave.io	2026-11-08 13:10:30.925326	\N	\N	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-11-11 22:39:07.461225	7
\.


--
-- Data for Name: content_reports; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.content_reports (id, track_id, submitted_by_user_id, handled_by_user_id, category, description, status, resolution_note, created_at, handled_at, updated_at, reason, reporter_id, resolved_at, reviewer_id, reviewer_note, target_id, target_type) FROM stdin;
\.


--
-- Data for Name: email_verification_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.email_verification_tokens (id, user_id, token_hash, expires_at, used_at, created_at) FROM stdin;
2	4	$2a$10$2LD9vOIvD0dyv1/uARCQDe23l09JcgNwDNTBRyxD0AM6.2ewsT6.S	2026-10-09 06:25:51.459	2026-10-09 06:16:20.48	2026-10-09 06:15:51.459
6	5	$2a$10$4ZCO4hPUKl0vRkFTK8BryepoCy4X/cP.S1uTBHtiakhKMtrH3Yj3u	2026-10-09 10:21:02.907	\N	2026-10-09 10:11:02.907
3	5	$2a$10$NaZZ3FWMF2gGj1RrL.wszum7iJ0GDizKWYslJ3ocieBX/biw8EBAG	2026-10-09 06:32:11.848	2026-10-09 10:11:02.779	2026-10-09 06:22:11.849
\.


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.favorites (user_id, track_id, created_at) FROM stdin;
21	10	2026-10-13 15:04:04.013
25	10	2026-10-13 15:04:04.013
21	8	2026-10-13 15:04:04.013
24	8	2026-10-13 15:04:04.013
22	7	2026-10-13 15:04:04.013
25	7	2026-10-13 15:04:04.013
22	6	2026-10-13 15:04:04.013
22	15	2026-10-13 15:04:04.013
23	13	2026-10-13 15:04:04.013
25	13	2026-10-13 15:04:04.013
23	11	2026-10-13 15:04:04.013
23	12	2026-10-13 15:04:04.013
23	26	2026-10-13 15:04:04.013
6	50	2026-10-19 06:08:16.888
6	49	2026-10-20 00:31:39.379
6	56	2026-10-25 10:54:56.412
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.genres (id, name, slug, description, is_active, created_by_user_id, created_at, updated_at) FROM stdin;
1	Pop	pop	Bright, catchy, and popular melodies.	t	\N	2026-10-09 13:32:34.754	2026-10-09 13:32:34.754
2	Ballad	ballad	Gentle, heartfelt songs rich in emotion.	t	\N	2026-10-09 13:32:34.82	2026-10-09 13:32:34.82
3	Rap / Hip-hop	rap-hip-hop	Energetic beats with honest, expressive lyrics.	t	\N	2026-10-09 13:32:34.862	2026-10-09 13:32:34.862
4	R&B	rnb	Smooth, warm, and soulful melodies.	t	\N	2026-10-09 13:32:34.913	2026-10-09 13:32:34.913
6	EDM	edm	High-energy modern electronic music.	t	\N	2026-10-09 13:32:35.002	2026-10-09 13:32:35.002
7	Indie	indie	Independent music with a free and distinctive spirit.	t	\N	2026-10-09 13:32:35.053	2026-10-09 13:32:35.053
8	Lofi	lofi	Relaxing sounds for studying and working.	t	\N	2026-10-09 13:32:35.1	2026-10-09 13:32:35.1
5	Acoustic	acoustic	Natural sounds from acoustic guitar and piano.	t	\N	2026-10-09 13:32:34.958	2026-10-22 10:53:33.789
\.


--
-- Data for Name: listening_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.listening_history (id, user_id, track_id, listened_duration_ms, completed, played_at) FROM stdin;
1	3	13	32003	f	2026-10-09 10:22:27.498
182	10	59	0	f	2026-10-27 18:35:26.23
184	10	7	30241	f	2026-11-08 07:09:59.174
4	3	6	30223	f	2026-10-09 10:28:22.265
5	3	7	30036	f	2026-10-09 10:29:22.253
6	3	8	30242	f	2026-10-09 10:30:22.565
7	3	13	30208	f	2026-10-09 10:31:22.639
8	3	8	30230	f	2026-10-09 10:40:32.528
9	3	7	30216	f	2026-10-09 10:41:32.649
10	3	9	33100	f	2026-10-09 10:41:46.223
11	3	10	181900	f	2026-10-09 10:42:26.819
12	3	8	30189	f	2026-10-09 20:12:53.993
13	3	10	30026	f	2026-10-09 20:16:40.613
14	3	9	30168	f	2026-10-09 20:22:48.903
15	8	8	30097	f	2026-10-09 23:00:14.139
16	3	6	30090	f	2026-10-10 06:06:47.875
17	3	13	30218	f	2026-10-10 07:08:06.96
18	3	11	30006	f	2026-10-10 07:10:26.485
19	3	6	30026	f	2026-10-10 07:11:17.173
20	3	12	30061	f	2026-10-10 07:15:04.364
26	3	10	30254	f	2026-10-10 07:24:12.262
27	3	7	30003	f	2026-10-10 22:26:36.531
28	3	10	30244	f	2026-10-10 22:30:19.271
29	3	15	30217	f	2026-10-11 05:50:33.562
30	3	16	52200	f	2026-10-11 06:00:47.278
32	3	16	138500	f	2026-10-11 06:11:34.861
33	3	16	30600	f	2026-10-11 06:28:04.637
35	3	6	30205	f	2026-10-13 03:39:18.012
37	3	13	30208	f	2026-10-13 06:51:40.471
43	9	26	30178	f	2026-10-13 07:21:02.875
44	9	16	30195	f	2026-10-13 07:26:37.232
45	9	26	30217	f	2026-10-13 07:27:17.76
48	21	10	230000	t	2026-10-13 13:04:04.013
49	25	10	230000	t	2026-10-13 10:04:04.013
50	22	7	210000	t	2026-10-13 14:04:04.013
51	25	7	210000	t	2026-10-13 09:04:04.013
52	23	13	260000	t	2026-10-13 12:04:04.013
53	23	11	180000	t	2026-10-13 08:04:04.013
56	15	12	124808	f	2026-10-13 08:11:07.132
57	15	7	30227	f	2026-10-13 08:13:36.778
58	10	7	30239	f	2026-10-14 01:42:38.176
59	10	26	32800	f	2026-10-14 01:43:30.72
60	9	34	30199	f	2026-10-15 14:56:04.703
61	9	38	30086	f	2026-10-15 15:05:14.562
62	9	36	30203	f	2026-10-15 15:09:43.248
63	9	34	30197	f	2026-10-15 15:12:38.217
64	9	38	30203	f	2026-10-15 15:17:11.624
65	9	36	30202	f	2026-10-15 15:21:40.284
66	9	34	30218	f	2026-10-15 15:24:35.295
67	9	38	30245	f	2026-10-15 15:29:08.614
85	10	12	30032	f	2026-10-18 01:19:31.054
86	10	7	30022	f	2026-10-18 01:23:34.981
87	10	11	30000	f	2026-10-18 01:26:56.861
90	10	12	30030	f	2026-10-18 01:40:47.14
91	10	7	30255	f	2026-10-18 01:44:51.327
92	10	11	30243	f	2026-10-18 01:48:13.07
95	10	12	30258	f	2026-10-18 02:02:03.284
96	10	7	30001	f	2026-10-18 02:06:07.088
97	10	11	30249	f	2026-10-18 02:09:29.104
100	10	12	30062	f	2026-10-18 02:23:19.175
101	10	7	30011	f	2026-10-18 02:27:23.037
102	10	11	30257	f	2026-10-18 02:30:45.092
105	10	12	30251	f	2026-10-18 02:44:35.25
106	10	7	30253	f	2026-10-18 02:48:39.218
107	9	38	30015	f	2026-10-18 02:49:23.992
108	10	11	30228	f	2026-10-18 02:52:00.984
109	9	36	30204	f	2026-10-18 02:53:52.858
111	9	34	30212	f	2026-10-18 02:56:48.026
112	9	34	156383	f	2026-10-18 02:58:54.36
113	9	34	171273	f	2026-10-18 02:59:09.042
115	9	26	30209	f	2026-10-18 03:01:21.448
116	10	12	30269	f	2026-10-18 03:05:51.303
117	9	38	30225	f	2026-10-18 03:06:45.74
118	10	7	30252	f	2026-10-18 03:09:55.231
119	9	36	30208	f	2026-10-18 03:11:14.369
120	10	11	30252	f	2026-10-18 03:13:17.001
121	9	34	30208	f	2026-10-18 03:14:09.358
123	9	26	30233	f	2026-10-18 03:18:42.749
125	9	38	30258	f	2026-10-18 03:24:17.17
126	10	12	30249	f	2026-10-18 03:27:07.315
127	9	36	30044	f	2026-10-18 03:28:46.692
128	10	7	30241	f	2026-10-18 03:31:11.379
129	10	11	30240	f	2026-10-18 03:34:33.087
130	9	38	30027	f	2026-10-18 03:38:39.225
133	10	12	30227	f	2026-10-18 03:48:23.589
134	10	7	30250	f	2026-10-18 03:52:27.423
135	10	11	30243	f	2026-10-18 03:55:49.001
138	9	36	30213	f	2026-10-18 04:07:32.77
139	10	12	30027	f	2026-10-18 04:09:39.258
140	10	7	30008	f	2026-10-18 04:13:42.978
141	10	11	30036	f	2026-10-18 04:17:04.855
143	9	50	30165	f	2026-10-18 04:23:36.843
145	10	12	30254	f	2026-10-18 04:30:55.339
146	10	7	30258	f	2026-10-18 04:34:59.281
147	10	11	30002	f	2026-10-18 04:38:20.833
148	9	50	55500	f	2026-10-18 04:40:12.439
185	10	10	30078	f	2026-11-08 07:11:07.718
186	10	13	30035	f	2026-11-08 07:15:46.106
151	10	12	30258	f	2026-10-18 04:52:11.409
152	10	7	30245	f	2026-10-18 04:56:15.312
153	10	11	30260	f	2026-10-18 04:59:37.114
156	10	12	30253	f	2026-10-18 05:13:27.323
157	10	7	30013	f	2026-10-18 05:17:31.016
158	10	11	30256	f	2026-10-18 05:20:53.028
161	10	12	30028	f	2026-10-18 05:34:43.116
162	10	7	30228	f	2026-10-18 05:38:47.264
166	6	47	30006	f	2026-10-18 08:21:18.537
168	10	12	30041	f	2026-10-22 10:37:02.687
170	9	56	31043	f	2026-10-23 02:30:41.825
171	9	58	30021	f	2026-10-23 04:02:56.38
180	6	13	0	f	2026-10-25 10:54:36.798
167	6	56	0	f	2026-10-25 10:54:56.998
160	10	13	0	f	2026-10-27 18:47:49.724
175	6	45	0	f	2026-10-23 04:50:12.129
174	6	38	0	f	2026-10-23 04:50:43.834
169	10	10	0	f	2026-10-31 02:11:18.799
165	6	7	0	f	2026-10-23 05:25:52.348
178	6	11	0	f	2026-10-23 05:25:52.66
164	6	6	0	f	2026-10-23 05:38:57.864
179	6	12	0	f	2026-10-23 06:31:01.878
177	6	9	0	f	2026-10-23 10:09:37.204
176	6	8	0	f	2026-10-23 10:11:09.608
181	6	15	0	f	2026-10-23 10:11:34.242
173	6	50	0	f	2026-10-25 10:42:28.454
172	6	49	0	f	2026-10-25 10:42:29.776
187	10	26	30255	f	2026-11-08 09:02:41.906
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notifications (id, user_id, type, title, message, action_url, read_at, created_at, actor_id, reference_id, reference_type, is_read, staff_id) FROM stdin;
1	8	TRACK_REJECTED	Track Needs Revision	Your track "SECRET" was not approved. Reason: Audio file corrupted or encoding does not meet platform standards.	/creator/tracks/20/rejection	\N	2026-10-11 12:24:39.366	\N	\N	\N	f	\N
2	8	TRACK_REJECTED	Track Needs Revision	Your track "TOP 1" was not approved. Reason: Unlicensed sample, beat, or suspected copyright infringement.	/creator/tracks/19/rejection	\N	2026-10-11 12:31:14.483	\N	\N	\N	f	\N
78	\N	TRACK_SUBMISSION	New submission for review	Track "Raindance" has been submitted for moderation.	\N	\N	2026-10-23 10:53:54.321	7	56	SUBMISSION	f	1
83	7	TRACK_APPROVED	Track approved	Your track "Raindance" has been approved and is now available in the public catalog.	\N	\N	2026-10-23 11:01:15.688	2	58	TRACK	f	\N
86	8	TRACK_REJECTED	Revision requested	"SAU HÌNH BÓNG ẤY" needs revision: Incomplete or placeholder metadata (title, artist or artwork).	\N	\N	2026-10-23 12:44:15.154	2	23	TRACK	f	\N
90	8	TRACK_APPROVED	Track approved	Your track "TOP1" has been approved and is now available in the public catalog.	\N	\N	2026-10-23 13:12:06.403	2	59	TRACK	f	\N
91	\N	TRACK_SUBMISSION	Track re-moderation required	Track "In Love" has been updated and queued for re-moderation.	\N	\N	2026-10-24 10:27:56.036	9	59	SUBMISSION	f	1
79	\N	TRACK_SUBMISSION	New submission for review	Track "Raindance" has been submitted for moderation.	\N	\N	2026-10-23 10:53:54.359	7	56	SUBMISSION	t	2
92	\N	TRACK_SUBMISSION	Track re-moderation required	Track "In Love" has been updated and queued for re-moderation.	\N	\N	2026-10-24 10:27:56.078	9	59	SUBMISSION	t	2
97	\N	TRACK_SUBMISSION	New submission for review	Track "TOP1" has been submitted for moderation.	\N	\N	2026-10-24 17:02:14.204	9	61	SUBMISSION	f	1
96	\N	TRACK_SUBMISSION	New submission for review	Track "TOP1" has been submitted for moderation.	\N	\N	2026-10-24 17:02:14.163	9	61	SUBMISSION	t	2
16	9	TRACK_APPROVED	Track approved	Your track "Không Buông" has been approved and is now available in the public catalog.	\N	\N	2026-10-15 21:42:46.348	2	36	TRACK	t	\N
103	9	TRACK_APPROVED	Track approved	Your track "In Love" has been approved and is now available in the public catalog.	\N	\N	2026-10-24 17:20:23.819	2	61	TRACK	t	\N
104	\N	TRACK_SUBMISSION	New submission for review	Track "TOP1" has been submitted for moderation.	\N	\N	2026-10-27 16:16:09.286	8	64	SUBMISSION	f	2
105	\N	TRACK_SUBMISSION	New submission for review	Track "TOP1" has been submitted for moderation.	\N	\N	2026-10-27 16:16:09.345	8	64	SUBMISSION	f	1
19	9	TRACK_REJECTED	Revision requested	"3017-2" needs revision: test notification	\N	\N	2026-10-15 21:53:24.698	2	38	TRACK	t	\N
106	\N	TRACK_SUBMISSION	New submission for review	Track "Nơi Này Có Anh" has been submitted for moderation.	\N	\N	2026-10-28 01:23:20.913	10	65	SUBMISSION	f	2
107	\N	TRACK_SUBMISSION	New submission for review	Track "Nơi Này Có Anh" has been submitted for moderation.	\N	\N	2026-10-28 01:23:20.966	10	65	SUBMISSION	f	1
110	10	TRACK_REJECTED	Revision requested	"Nơi Này Có Anh" needs revision: không hayy	\N	\N	2026-10-28 01:41:24.224	2	65	TRACK	f	\N
22	9	TRACK_APPROVED	Track approved	Your track "3017-2" has been approved and is now available in the public catalog.	\N	\N	2026-10-15 21:54:49.226	2	38	TRACK	t	\N
34	9	TRACK_APPROVED	Track approved	Your track "Cho tui đi theo" has been approved and is now available in the public catalog.	\N	\N	2026-10-18 08:46:40.266	2	40	TRACK	t	\N
10	7	TRACK_APPROVED	Track approved	Your track "MẮT MÔI TAY CHÂN" has been approved and is now available in the public catalog.	\N	\N	2026-10-15 21:28:32.504	2	33	TRACK	t	\N
29	9	TRACK_REJECTED	Revision requested	"Cho tui đi theo" needs revision: Audio clipping or severe distortion detected in master stream.	\N	\N	2026-10-18 08:29:44.965	2	40	TRACK	t	\N
44	9	TRACK_REJECTED	Revision requested	"Phải lòng" needs revision: Audio file corrupted or encoding does not meet platform standards.	\N	\N	2026-10-18 10:08:52.896	2	43	TRACK	t	\N
41	9	TRACK_APPROVED	Track approved	Your track "Phải lòng" has been approved and is now available in the public catalog.	\N	\N	2026-10-18 10:05:06.666	2	42	TRACK	t	\N
48	8	TRACK_APPROVED	Track approved	Your track "LAVIEM" has been approved and is now available in the public catalog.	\N	\N	2026-10-18 10:32:22.388	2	45	TRACK	f	\N
50	8	TRACK_APPROVED	Track approved	Your track "LAVIEM" has been approved and is now available in the public catalog.	\N	\N	2026-10-18 11:09:04.554	2	47	TRACK	f	\N
57	8	TRACK_REJECTED	Revision requested	"TOP 1" needs revision: Audio file corrupted or encoding does not meet platform standards.	\N	\N	2026-10-18 11:16:33.074	2	48	TRACK	f	\N
55	9	TRACK_APPROVED	Track approved	Your track "Buông" has been approved and is now available in the public catalog.	\N	\N	2026-10-18 11:13:33.091	2	50	TRACK	t	\N
56	8	TRACK_APPROVED	Track approved	Your track "TOP 1" has been approved and is now available in the public catalog.	\N	\N	2026-10-18 11:15:47.358	2	46	TRACK	f	\N
58	8	TRACK_APPROVED	Track approved	Your track "SECRET" has been approved and is now available in the public catalog.	\N	\N	2026-10-18 11:27:43.751	2	49	TRACK	f	\N
59	9	TRACK_REJECTED	Revision requested	"TOP1" needs revision: Audio file corrupted or encoding does not meet platform standards.	\N	\N	2026-10-18 11:46:25.332	2	53	TRACK	t	\N
60	9	TRACK_APPROVED	Track approved	Your track "SECRET" has been approved and is now available in the public catalog.	\N	\N	2026-10-18 11:46:53.865	2	52	TRACK	t	\N
61	9	TRACK_REJECTED	Revision requested	"THEGIOICUAANH" needs revision: Audio clipping or severe distortion detected in master stream.	\N	\N	2026-10-18 11:55:10.824	2	54	TRACK	t	\N
62	9	TRACK_REJECTED	Revision requested	"SECRET" needs revision: Audio file corrupted or encoding does not meet platform standards.	\N	\N	2026-10-18 11:55:28.346	2	55	TRACK	t	\N
80	7	TRACK_REJECTED	Revision requested	"Raindance" needs revision: Description kì cục quá	\N	\N	2026-10-23 10:55:31.341	2	58	TRACK	f	\N
66	\N	TRACK_SUBMISSION	New submission for review	Track "LAVIEM" has been submitted for moderation.	\N	\N	2026-10-19 01:45:20.093	9	54	SUBMISSION	f	1
84	8	TRACK_APPROVED	Track approved	Your track "Thế Giới Của Anh" has been approved and is now available in the public catalog.	\N	\N	2026-10-23 12:26:05.005	2	21	TRACK	f	\N
87	8	TRACK_REJECTED	Revision requested	"MRT" needs revision: Audio file corrupted or encoding does not meet platform standards.	\N	\N	2026-10-23 12:45:52.614	2	22	TRACK	f	\N
67	\N	TRACK_SUBMISSION	New submission for review	Track "LAVIEM" has been submitted for moderation.	\N	\N	2026-10-19 01:45:20.153	9	54	SUBMISSION	t	2
93	\N	TRACK_SUBMISSION	New submission for review	Track "In Love" has been submitted for moderation.	\N	\N	2026-10-24 10:45:47.981	9	60	SUBMISSION	f	1
68	9	TRACK_APPROVED	Track approved	Your track "LAVIEM" has been approved and is now available in the public catalog.	\N	\N	2026-10-19 01:46:26.854	2	56	TRACK	t	\N
94	\N	TRACK_SUBMISSION	New submission for review	Track "In Love" has been submitted for moderation.	\N	\N	2026-10-24 10:45:48.014	9	60	SUBMISSION	t	2
26	\N	TRACK_SUBMISSION	New submission for review	Track "3017-2" has been submitted for moderation.	\N	\N	2026-10-18 08:20:15.235	9	35	SUBMISSION	t	2
12	\N	TRACK_SUBMISSION	New submission for review	Track "Không Buông" has been submitted for moderation.	\N	\N	2026-10-15 21:41:31.417	9	31	SUBMISSION	f	1
14	\N	TRACK_SUBMISSION	New submission for review	Track "Không Buông" has been submitted for moderation.	\N	\N	2026-10-15 21:42:12.51	9	32	SUBMISSION	f	1
15	\N	TRACK_SUBMISSION	New submission for review	Track "Không Buông" has been submitted for moderation.	\N	\N	2026-10-15 21:42:12.536	9	32	SUBMISSION	t	2
13	\N	TRACK_SUBMISSION	New submission for review	Track "Không Buông" has been submitted for moderation.	\N	\N	2026-10-15 21:41:31.444	9	31	SUBMISSION	t	2
17	\N	TRACK_SUBMISSION	New submission for review	Track "3017-2" has been submitted for moderation.	\N	\N	2026-10-15 21:52:45.901	9	33	SUBMISSION	f	1
18	\N	TRACK_SUBMISSION	New submission for review	Track "3017-2" has been submitted for moderation.	\N	\N	2026-10-15 21:52:45.926	9	33	SUBMISSION	t	2
20	\N	TRACK_SUBMISSION	New submission for review	Track "3017-2" has been submitted for moderation.	\N	\N	2026-10-15 21:54:23.094	9	34	SUBMISSION	f	1
21	\N	TRACK_SUBMISSION	New submission for review	Track "3017-2" has been submitted for moderation.	\N	\N	2026-10-15 21:54:23.122	9	34	SUBMISSION	t	2
25	\N	TRACK_SUBMISSION	New submission for review	Track "3017-2" has been submitted for moderation.	\N	\N	2026-10-18 08:20:15.138	9	35	SUBMISSION	f	1
27	\N	TRACK_SUBMISSION	New submission for review	Track "Cho tui đi theo" has been submitted for moderation.	\N	\N	2026-10-18 08:28:25.523	9	36	SUBMISSION	f	1
30	\N	TRACK_SUBMISSION	New submission for review	Track "Cho tui đi theo" has been submitted for moderation.	\N	\N	2026-10-18 08:33:39.687	9	37	SUBMISSION	f	1
32	\N	TRACK_SUBMISSION	New submission for review	Track "Phải lòng" has been submitted for moderation.	\N	\N	2026-10-18 08:37:31.66	9	38	SUBMISSION	f	1
37	\N	TRACK_SUBMISSION	New submission for review	Track "Phải lòng" has been submitted for moderation.	\N	\N	2026-10-18 10:03:27.874	9	39	SUBMISSION	f	1
39	\N	TRACK_SUBMISSION	New submission for review	Track "Phải lòng" has been submitted for moderation.	\N	\N	2026-10-18 10:04:24.12	9	40	SUBMISSION	f	1
42	\N	TRACK_SUBMISSION	New submission for review	Track "Phải lòng" has been submitted for moderation.	\N	\N	2026-10-18 10:08:20.381	9	41	SUBMISSION	f	1
28	\N	TRACK_SUBMISSION	New submission for review	Track "Cho tui đi theo" has been submitted for moderation.	\N	\N	2026-10-18 08:28:25.577	9	36	SUBMISSION	t	2
31	\N	TRACK_SUBMISSION	New submission for review	Track "Cho tui đi theo" has been submitted for moderation.	\N	\N	2026-10-18 08:33:39.737	9	37	SUBMISSION	t	2
33	\N	TRACK_SUBMISSION	New submission for review	Track "Phải lòng" has been submitted for moderation.	\N	\N	2026-10-18 08:37:31.702	9	38	SUBMISSION	t	2
38	\N	TRACK_SUBMISSION	New submission for review	Track "Phải lòng" has been submitted for moderation.	\N	\N	2026-10-18 10:03:27.919	9	39	SUBMISSION	t	2
40	\N	TRACK_SUBMISSION	New submission for review	Track "Phải lòng" has been submitted for moderation.	\N	\N	2026-10-18 10:04:24.169	9	40	SUBMISSION	t	2
43	\N	TRACK_SUBMISSION	New submission for review	Track "Phải lòng" has been submitted for moderation.	\N	\N	2026-10-18 10:08:20.431	9	41	SUBMISSION	t	2
99	\N	TRACK_SUBMISSION	New submission for review	Track "Phải lòng" has been submitted for moderation.	\N	\N	2026-10-24 17:02:52.02	9	62	SUBMISSION	f	1
100	9	TRACK_APPROVED	Track approved	Your track "Phải lòng" has been approved and is now available in the public catalog.	\N	\N	2026-10-24 17:03:11.954	2	44	TRACK	t	\N
98	\N	TRACK_SUBMISSION	New submission for review	Track "Phải lòng" has been submitted for moderation.	\N	\N	2026-10-24 17:02:51.985	9	62	SUBMISSION	t	2
108	10	TRACK_APPROVED	Track approved	Your track "Nơi Này Có Anh" has been approved and is now available in the public catalog.	\N	\N	2026-10-28 01:31:34.518	2	64	TRACK	f	\N
53	\N	TRACK_SUBMISSION	New submission for review	Track "Buông" has been submitted for moderation.	\N	\N	2026-10-18 11:12:16.07	9	49	SUBMISSION	f	1
46	\N	TRACK_SUBMISSION	New submission for review	Track "Phải lòng" has been submitted for moderation.	\N	\N	2026-10-18 10:19:43.628	9	42	SUBMISSION	f	1
51	\N	TRACK_SUBMISSION	New submission for review	Track "Buông" has been submitted for moderation.	\N	\N	2026-10-18 11:11:02.648	9	48	SUBMISSION	f	1
81	\N	TRACK_SUBMISSION	New submission for review	Track "Raindance" has been submitted for moderation.	\N	\N	2026-10-23 11:00:39.465	7	57	SUBMISSION	f	1
85	9	TRACK_REJECTED	Revision requested	"Phải lòng" needs revision: Incomplete or placeholder metadata (title, artist or artwork). These	\N	\N	2026-10-23 12:27:53.141	2	44	TRACK	t	\N
88	\N	TRACK_SUBMISSION	New submission for review	Track "TOP1" has been submitted for moderation.	\N	\N	2026-10-23 13:11:25.378	8	58	SUBMISSION	f	1
82	\N	TRACK_SUBMISSION	New submission for review	Track "Raindance" has been submitted for moderation.	\N	\N	2026-10-23 11:00:39.504	7	57	SUBMISSION	t	2
89	\N	TRACK_SUBMISSION	New submission for review	Track "TOP1" has been submitted for moderation.	\N	\N	2026-10-23 13:11:25.427	8	58	SUBMISSION	t	2
95	9	TRACK_APPROVED	Track approved	Your track "In Love" has been approved and is now available in the public catalog.	\N	\N	2026-10-24 10:46:23.184	2	56	TRACK	t	\N
75	\N	TRACK_SUBMISSION	New submission for review	Track "Blue" has been submitted for moderation.	\N	\N	2026-10-23 10:44:32.862	9	55	SUBMISSION	f	1
47	\N	TRACK_SUBMISSION	New submission for review	Track "Phải lòng" has been submitted for moderation.	\N	\N	2026-10-18 10:19:43.682	9	42	SUBMISSION	t	2
52	\N	TRACK_SUBMISSION	New submission for review	Track "Buông" has been submitted for moderation.	\N	\N	2026-10-18 11:11:02.868	9	48	SUBMISSION	t	2
54	\N	TRACK_SUBMISSION	New submission for review	Track "Buông" has been submitted for moderation.	\N	\N	2026-10-18 11:12:16.122	9	49	SUBMISSION	t	2
76	\N	TRACK_SUBMISSION	New submission for review	Track "Blue" has been submitted for moderation.	\N	\N	2026-10-23 10:44:32.947	9	55	SUBMISSION	t	2
77	9	TRACK_APPROVED	Track approved	Your track "Blue" has been approved and is now available in the public catalog.	\N	\N	2026-10-23 10:46:08.437	2	57	TRACK	t	\N
102	\N	TRACK_SUBMISSION	New submission for review	Track "In Love" has been submitted for moderation.	\N	\N	2026-10-24 17:19:46.216	9	63	SUBMISSION	f	1
101	\N	TRACK_SUBMISSION	New submission for review	Track "In Love" has been submitted for moderation.	\N	\N	2026-10-24 17:19:46.181	9	63	SUBMISSION	t	2
109	10	TRACK_APPROVED	Track approved	Your track "Nơi Này Có Anh 2" has been approved and is now available in the public catalog.	\N	\N	2026-10-28 01:40:20.407	2	66	TRACK	f	\N
114	8	TRACK_APPROVED	Track approved	Your track "TOP1" has been approved and is now available in the public catalog.	\N	\N	2026-11-11 14:57:37.597	5	63	TRACK	f	\N
116	21	TRACK_SUBMISSION	New submission for review	Track "IDK" has been submitted for moderation.	\N	\N	2026-11-11 15:58:47.703	3	71	SUBMISSION	f	\N
117	22	TRACK_SUBMISSION	New submission for review	Track "IDK" has been submitted for moderation.	\N	\N	2026-11-11 15:58:47.705	3	71	SUBMISSION	f	\N
118	5	TRACK_SUBMISSION	New submission for review	Track "IDK" has been submitted for moderation.	\N	\N	2026-11-11 15:58:47.706	3	71	SUBMISSION	f	\N
119	4	TRACK_SUBMISSION	New submission for review	Track "IDK" has been submitted for moderation.	\N	\N	2026-11-11 15:58:47.707	3	71	SUBMISSION	f	\N
120	3	TRACK_APPROVED	Track approved	Your track "IDK" has been approved and is now available in the public catalog.	\N	\N	2026-11-11 15:59:13.824	5	17	TRACK	f	\N
\.


--
-- Data for Name: official_lyrics; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.official_lyrics (id, track_id, lyric_content, status, created_by_user_id, created_at, updated_at) FROM stdin;
1	49	[Intro]\r\n[00:00] (Nhạc dạo đầu)\r\n[Verse 1: CONGB & Cody Nam Võ]\r\n[00:15] Kể từ khi gặp em, trí nhớ hơi bị kém\r\n[00:19] Những món ăn thân quen sao nay bỗng dưng chẳng thèm?\r\n[00:22] Dù bụng đói cồn cào, lại chẳng thể nói lời nào\r\n[00:26] Vì gu em không thích người quá cao\r\n[00:30] Mà anh chẳng hề cao, tính nóng hơi bị láo\r\n[00:33] Nói những câu tào lao khi em nói câu xin chào\r\n[00:37] Vậy thì theo anh đến một nơi, không có biển khơi\r\n[00:41] Chỉ có vườn với trái cây mà thôi\r\n[Pre-Chorus: Quang Hùng MasterD]\r\n[00:44] Vườn anh có trái dưa, trái dâu, trái thơm, trái nho, có luôn banana\r\n[00:50] Nhưng thiếu đi trái tim của một người\r\n[00:53] Lòng anh như gió đông giữa trời đêm\r\n[00:55] Mong thấy em khi bình minh lên, oh-hoh\r\n[Chorus: Cody Nam Võ & Quang Hùng MasterD]\r\n[00:57] Tình đầu ngây thơ mà em, đúng không?\r\n[01:01] Còn chưa nắm tay, chưa về tới phòng\r\n[01:04] Mình còn trông ngóng biết nhiều về nhau\r\n[01:07] Đêm đến ta lại ngắm sao, làm sao mở lòng?\r\n[01:12] Chẳng phải em muốn được anh ghé tai?\r\n[01:15] Thầm thì vài câu suốt bao đêm dài\r\n[01:19] Trời cao có thấu nỗi lòng tận mây xanh?\r\n[01:22] Nói em nghe bí mật của anh!\r\n[Rap Verse: Wren Evans]\r\n[01:26] Nói hết bí mật thì có yêu không?\r\n[01:30] Muốn thấy bí mật hay em muốn nghe bằng lời nói?\r\n[01:34] Đến đây với anh, trăm nghe không bằng một lần thấy\r\n[01:37] Ai rồi cũng phải yêu rồi đấy, baby, ooh-ooh\r\n[01:41] Phải làm sao để gặp my baby?\r\n[01:44] Muốn yêu em chân thành vì anh đâu muốn yêu theo phong trào mà bae\r\n[01:48] Em quen anh chân thành, làm một bộ phim hai ta đóng vai người yêu\r\n[01:52] Rất muốn ai đó có thể nói ra hết sự thật\r\n[01:54] Rằng anh thương em rất nhiều\r\n[01:56] Giờ này nếu thắc mắc em qua bên...\r\n[Bridge: Cody Nam Võ, CONGB & Quang Hùng MasterD]\r\n[02:00] ("Baby à, anh đã nói là em trao cho anh trái tim, sao lại là trái bơ đó hả? Thôi CONGB dô!")\r\n[02:08] Vậy người có muốn mình tay nắm tay?\r\n[02:12] Tình anh đã trao không cần giãi bày\r\n[02:15] Nụ cười em sáng hơn mặt trăng đang lên\r\n[02:19] Chiếu sâu vào trái tim, anh không đỡ được\r\n[02:23] Tặng nàng bài thơ dù không có hay\r\n[02:26] Chỉ mong em hiểu lấy tâm tư này\r\n[02:30] Trời cao có thấu nỗi lòng tận mây xanh?\r\n[02:34] Nói em nghe bí mật của anh!\r\n(Tone nâng nửa cung)\r\n\r\n[Chorus: Wren Evans & Cody Nam Võ]\r\n[02:38] Tình đầu ngây thơ mà em, đúng không?\r\n[02:41] Còn chưa nắm tay, chưa về tới phòng\r\n[02:45] Mình còn trông ngóng biết nhiều về nhau\r\n[02:48] Đêm đến ta lại ngắm sao, làm sao mở lòng?\r\n[02:52] Chẳng phải em muốn được anh ghé tai?\r\n[02:56] Thầm thì vài câu suốt bao đêm dài\r\n[03:00] Trời cao có thấu nỗi lòng tận mây xanh?\r\n[03:04] Nói em nghe bí mật của anh!\r\n[Outro]\r\n[03:08] Bí mật của anh...\r\n[03:12] Nói em nghe bí mật của anh...	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
2	59	[00:10.00] Anh thường hay thức khuya\n[00:11.00] Nghĩ về thứ anh vẫn luôn mong đợi\n[00:14.00] Rằng phải làm sao?\n[00:15.00] Cũng chẳng biết đến bao giờ?\n[00:20.00] Những lời ca dở dang\n[00:21.00] Anh ngồi viết mãi vẫn còn chưa xong\n[00:24.00] Chạy theo đằng sau ánh sáng\n[00:27.00] Cuối nơi chân trời.\n[00:29.00] Rồi em đến đây dịu dàng cạnh bên anh\n[00:33.00] Cơn mưa rơi trở nên long lanh\n[00:35.00] Chẳng còn đợi trông\n[00:37.00] Vì giấc mơ có em thêm màu xanh\n[00:40.00] Thật lòng chẳng xa xôi\n[00:43.00] Ước muốn anh ở ngay đây thôi\n[00:45.00] Anh không bận tâm nữa\n[00:47.00] Vì anh có em.\n[00:50.00] Nếu như ngày mai không diễn ra\n[00:52.00] Giống cách mà anh cứ luôn mơ mộng?\n[00:55.00] Thì vẫn có một người luôn phía sau\n[00:58.00] Nhẹ nắm tay anh\n[01:00.00] Biết còn nhiều điều lo lắng đang vây quanh\n[01:03.00] Dặn lòng phải xứng đáng hơn\n[01:05.00] Để anh trở thành chàng trai\n[01:07.00] Top 1 trong mắt em.\n[01:13.00] Phải tự thân vượt lên, anh vốn không thích hai chữ đáng thương\n[01:15.00] Nhiều người nói là không được đâu nhưng anh vẫn cứ ngang ngược\n[01:17.00] Bởi vì sâu ở trong đầu anh toàn chứa những thứ hoang đường\n[01:19.00] Và từ hồi bé anh đã mơ ước được hát như chú Đan Trường\n[01:21.00] Bầu trời đêm okay cho nên không sao\n[01:23.00] Có đứa nhóc ôm đàn ngân nga những câu yêu đời\n[01:26.00] Dù cho phải gặp bao nhiêu gian khó\n[01:28.00] Vẫn luôn là em dõi theo anh\n[01:31.00] Dù anh đi đến đâu...\n[01:45.00] Nếu như ngày mai không diễn ra\n[01:47.00] Giống cách mà anh cứ luôn mơ mộng?\n[01:50.00] Thì vẫn có một người luôn phía sau\n[01:53.00] Nhẹ nắm tay anh\n[01:55.00] Biết còn nhiều điều lo lắng đang vây quanh\n[01:58.00] Dặn lòng phải xứng đáng hơn\n[02:00.00] Để anh trở thành chàng trai\n[02:02.00] Top 1 trong mắt em.\n[02:08.00] Những cơ hội vụt qua đôi tay\n[02:11.00] Vậy chắc chưa phải là ngày hôm nay\n[02:14.00] Thì cứ tiếp tục để chạy theo tiếng gọi\n[02:17.00] Từng câu nói mà anh vẫn luôn tin vào.\n[02:20.00] Có những lần đôi mắt anh lạc phương hướng\n[02:23.00] Để rồi đêm tối anh không về nhà\n[02:26.00] Thì vẫn luôn là em\n[02:28.00] Ngọn đèn rực rỡ chiếu soi nơi anh...\n[02:30.00] Nếu như ngày mai không diễn ra\n[02:32.00] Giống cách mà anh cứ luôn mơ mộng\n[02:35.00] Thì vẫn có một người luôn phía sau nhẹ nắm tay anh\n[02:40.00] Biết còn nhiều điều lo lắng đang vây quanh\n[02:43.00] Dặn lòng phải xứng đáng hơn\n[02:45.00] Để anh trở thành chàng trai\n[02:48.00] Top 1 trong mắt em...\n[02:53.00] Top 1 trong mắt em.\n[Verse 1]\n[Chorus]\n[Verse 2]\n[Chorus]\n[Bridge]\n[Chorus & Outro]	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
3	48	[Verse 1]\r\n[00:10] Anh thường hay thức khuya\r\n[00:11] Nghĩ về thứ anh vẫn luôn mong đợi\r\n[00:14] Rằng phải làm sao?\r\n[00:15] Cũng chẳng biết đến bao giờ?\r\n[00:20] Những lời ca dở dang\r\n[00:21] Anh ngồi viết mãi vẫn còn chưa xong\r\n[00:24] Chạy theo đằng sau ánh sáng\r\n[00:27] Cuối nơi chân trời.\r\n[00:29] Rồi em đến đây dịu dàng cạnh bên anh\r\n[00:33] Cơn mưa rơi trở nên long lanh\r\n[00:35] Chẳng còn đợi trông\r\n[00:37] Vì giấc mơ có em thêm màu xanh\r\n[00:40] Thật lòng chẳng xa xôi\r\n[00:43] Ước muốn anh ở ngay đây thôi\r\n[00:45] Anh không bận tâm nữa\r\n[00:47] Vì anh có em.\r\n[Chorus]\r\n[00:50] Nếu như ngày mai không diễn ra\r\n[00:52] Giống cách mà anh cứ luôn mơ mộng?\r\n[00:55] Thì vẫn có một người luôn phía sau\r\n[00:58] Nhẹ nắm tay anh\r\n[01:00] Biết còn nhiều điều lo lắng đang vây quanh\r\n[01:03] Dặn lòng phải xứng đáng hơn\r\n[01:05] Để anh trở thành chàng trai\r\n[01:07] Top 1 trong mắt em.\r\n[Verse 2]\r\n[01:13] Phải tự thân vượt lên, anh vốn không thích hai chữ đáng thương\r\n[01:15] Nhiều người nói là không được đâu nhưng anh vẫn cứ ngang ngược\r\n[01:17] Bởi vì sâu ở trong đầu anh toàn chứa những thứ hoang đường\r\n[01:19] Và từ hồi bé anh đã mơ ước được hát như chú Đan Trường\r\n[01:21] Bầu trời đêm okay cho nên không sao\r\n[01:23] Có đứa nhóc ôm đàn ngân nga những câu yêu đời\r\n[01:26] Dù cho phải gặp bao nhiêu gian khó\r\n[01:28] Vẫn luôn là em dõi theo anh\r\n[01:31] Dù anh đi đến đâu...\r\n[Chorus]\r\n[01:45] Nếu như ngày mai không diễn ra\r\n[01:47] Giống cách mà anh cứ luôn mơ mộng?\r\n[01:50] Thì vẫn có một người luôn phía sau\r\n[01:53] Nhẹ nắm tay anh\r\n[01:55] Biết còn nhiều điều lo lắng đang vây quanh\r\n[01:58] Dặn lòng phải xứng đáng hơn\r\n[02:00] Để anh trở thành chàng trai\r\n[02:02] Top 1 trong mắt em.\r\n[Bridge]\r\n[02:08] Những cơ hội vụt qua đôi tay\r\n[02:11] Vậy chắc chưa phải là ngày hôm nay\r\n[02:14] Thì cứ tiếp tục để chạy theo tiếng gọi\r\n[02:17] Từng câu nói mà anh vẫn luôn tin vào.\r\n[02:20] Có những lần đôi mắt anh lạc phương hướng\r\n[02:23] Để rồi đêm tối anh không về nhà\r\n[02:26] Thì vẫn luôn là em\r\n[02:28] Ngọn đèn rực rỡ chiếu soi nơi anh...\r\n[Chorus & Outro]\r\n[02:30] Nếu như ngày mai không diễn ra\r\n[02:32] Giống cách mà anh cứ luôn mơ mộng\r\n[02:35] Thì vẫn có một người luôn phía sau nhẹ nắm tay anh\r\n[02:40] Biết còn nhiều điều lo lắng đang vây quanh\r\n[02:43] Dặn lòng phải xứng đáng hơn\r\n[02:45] Để anh trở thành chàng trai\r\n[02:48] Top 1 trong mắt em...\r\n[02:53] Top 1 trong mắt em.	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
4	47	[00:02] Còn cần thiết nữa, nói chi đến đây cũng thừa\r\n[00:04] Giờ chỉ còn mình với vấn vương (Rượu vang pha với cơn mưa)\r\n[00:07] Hàng trăm lý do cũng chẳng thể cứu vãn\r\n[00:09] Biết sao hết cho vừa?\r\n[00:11] Lòng nhau mới thấu đây em\r\n[Chorus: CAPTAIN BOY & CoolKid]\r\n[00:13] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\r\n[00:17] Rượu vang pha với cơn mưa\r\n[00:20] Hàng trăm lý do cũng chẳng thể cứu vãn\r\n[00:22] Biết sao hết cho vừa? Lòng nhau mới thấu đây em\r\n[00:26] Dệt hàng triệu vết thương, tự vùi mình trước gương\r\n[00:30] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\r\n[00:33] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\n[00:37] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\r\n[Verse 1: Pháp Kiều & CAPTAIN BOY]\r\n[00:41] Ta chia tay, vì sao em ơi?\r\n[00:44] Điều này anh muốn hỏi lâu rồi\r\n[00:47] Những khung trời kỷ niệm vỡ đôi\r\n[00:50] Có phải vì một câu anh đã lỡ lời?\r\n[00:54] Sau đêm nay, tự ta cho ta\r\n[00:57] Em và anh một đoạn kết mới\r\n[01:00] Dù rằng mình còn yêu nhau rất nhiều đấy\r\n[01:04] Nhưng để ở lại thì anh nghĩ là không\r\n[Pre-Chorus: Quang Hùng MasterD]\r\n[01:06] Và sau những cảm xúc nhất thời\r\n[01:10] Người bên em giờ này chẳng còn là anh\r\n[01:13] Gửi lại quá khứ cung đàn đã vỡ\r\n[01:17] Vì những vấn vương ấy chưa kịp thành lời\r\n[Chorus: Quang Hùng MasterD & CAPTAIN BOY]\r\n[01:19] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\r\n[01:23] Rượu vang pha với cơn mưa\r\n[01:26] Hàng trăm lý do cũng chẳng thể cứu vãn\r\n[01:28] Biết sao hết cho vừa? Lòng nhau mới thấu đây em\r\n[01:33] Dệt hàng triệu vết thương, tự vùi mình trước gương\r\n[01:36] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\r\n[01:39] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\n[01:43] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\r\n[Post-Chorus: Quang Hùng MasterD & CoolKid]\r\n[01:46] Tất cả là tại vì em, em, em, em, em, e-em\r\n[01:50] Người xa lạ anh từng quen\r\n[01:53] Tất cả là tại vì em, em, em, em, em, e-em\r\n[01:57] Kẻ ngốc đang say tình dưới ngọn đèn\r\n[01:59] Tất cả là tại vì em, em, em, em, em, e-em\r\n[02:03] Người xa lạ anh từng quen\r\n[02:06] Tất cả là tại vì em, em, em, em, em, yeah-eh-eh\r\n[02:10] Kẻ ngốc đang say tình dưới ngọn đèn\r\n[Verse 2: Pháp Kiều]\r\n[02:13] Lau đôi mi, đây là nước mắt hay mưa\r\n[02:15] Buông đôi tay, anh đâu muốn phải dây dưa\r\n[02:17] Quên đi đôi mắt ấy khi xưa, chẳng bên nhau được nữa\r\n[02:20] Sau bao lần đau, anh lại cho đi và quên\r\n[02:22] Anh ghét nỗi đau, cơn mưa đêm kia và em\r\n[02:24] Ta vội quên rồi, những điều sao thật quen\r\n[02:27] Để nỗi buồn kia gọi tên mỗi khi bài ca bật lên\r\n[Pre-Chorus: CoolKid & Quang Hùng MasterD]\r\n[02:28] Và sau những cảm xúc nhất thời\r\n[02:30] Người bên em giờ này chẳng còn là anh\r\n[02:33] Gửi lại quá khứ cung đàn đã vỡ\r\n[02:37] Vì những vấn vương ấy chưa kịp thành lời\r\n[Chorus: Cả nhóm]\r\n[02:39] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\r\n[02:43] Rượu vang pha với cơn mưa\r\n[02:45] Hàng trăm lý do cũng chẳng thể cứu vãn\r\n[02:48] Biết sao hết cho vừa lòng nhau mới thấu đây em?\r\n[02:52] Dệt hàng triệu vết thương, tự vùi mình trước gương\r\n[02:56] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\r\n[03:03] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\n[03:07] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\r\n[Outro]\r\n[03:11] Tất cả là tại vì em...\r\n[03:15] Người xa lạ anh từng quen...\r\n[03:19] Tất cả là tại vì em...	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
6	58	[00:18.00] Let's get the party started\n[00:20.00] See you at the bar, you was hardly talkin'\n[00:22.00] That's when I knew that your heart was scarrin'\n[00:24.00] Friends to lovers, need a part to star in, like, "Wait, babe\n[00:27.00] Let me ask your pardon\n[00:29.00] This ain't Gucci, this is Prada, darlin'\n[00:31.00] If you want somethin', you can ask me, darlin'"\n[00:34.00] Then you started laughin' 'cause you think I'm jokin'\n[00:36.00] But lookin' in your eyes is the best thing\n[00:38.00] Brake lights givin' you the red skin\n[00:40.00] You was in a bad mood from we stepped in\n[00:42.00] Though you checked out 'fore we even checked in\n[00:44.00] On the phone you gon' vent to your best friend\n[00:46.00] The one who gave me the lecture, but I ain't gon' sweat you, babe\n[00:49.00] I'ma let you catch up with your boy, undress you\n[00:52.00] And let me tell you why I'ma bless you\n[00:55.00] It's the way my mind is fallin' away\n[00:59.00] In my heart, I know\n[01:02.00] You feel the same when you're with me\n[01:05.00] You know I'm all you need\n[01:07.00] You're where I wanna be\n[01:09.00] My darling, can't you see?\n[01:12.00] I love you\n[01:16.00] I love you\n[01:20.00] I love you\n[01:24.00] I love you\n[01:29.00] I love you\n[01:31.00] Fell into you\n[01:33.00] Say you want me in the mood\n[01:35.00] Tryna hide my feelings for you\n[01:37.00] Don't wanna argue, not with you\n[01:39.00] Tell me why you're so in denial\n[01:41.00] Hold me close, don't tell me goodnight\n[01:43.00] Are you down to get me?\n[01:46.00] Tell me when you're ready, I'm ready\n[01:49.00] We can get into it or we can get intimate\n[01:52.00] The shower when you sing in it\n[01:53.00] Better than Beyoncé, I like the sound of fiancée\n[01:56.00] You know it's got a little ring to it\n[01:58.00] And really when I think of it\n[01:59.00] Growin' up, I didn't ever see marriages\n[02:01.00] No weddings, no horse, no carriages\n[02:03.00] I wanna do things different and change the narrative\n[02:06.00] God knows you a wild child, beautiful child, I need your help\n[02:09.00] Lookin' like you come from the '90s by yourself\n[02:11.00] My mum sixty-one and her favourite line to tell her son is\n[02:14.00] "Sometimes she wish that she had a girl"\n[02:15.00] I wanna take you back to a time, back to a trip\n[02:18.00] You had that white wine that I never got to sip\n[02:20.00] And dinner wasn't ruined 'cause you never got to pick\n[02:22.00] I know that everybody told me that I'm sick 'cause\n[02:24.00] It's the way my mind is fallin' away\n[02:28.00] In my heart, I know\n[02:30.00] You feel the same when you're with me\n[02:33.00] You know I'm all you need\n[02:36.00] You're where I wanna be\n[02:38.00] My darling, can't you see?\n[02:41.00] I love you (Me and you, never let me go)\n[02:45.00] (Me and you, I'll tell you two times)\n[02:47.00] I love you (Me and you, never let me go)\n[02:50.00] (Me and you, tell me two times)\n[02:52.00] I love you (Me and you, never let me go)\n[02:54.00] (Me and you, tell me two times)\n[02:56.00] I love you (Me and you, never let me go)\n[02:58.00] (Me and you, tell me two times)\n[03:00.00] I said lean with it, rock with it\n[03:03.00] Your finger, I could put a rock in it\n[03:05.00] Fin-finger, I could put a rock in it\n[03:07.00] Bank card, they gon' put a block in it\n[03:09.00] Said rock with it, bounce with it\n[03:12.00] The left wrist, I could put my house in it\n[03:14.00] You wanna bet, babe? I could put my house in it\n[03:16.00] Paper, I could put my spouse in it\n[03:18.00] I said shimmy shimmy yay, shimmy\n[03:20.00] Shimmy shimmy yah\n[03:21.00] 5'9", brown eyes, and she in it, in it\n[03:23.00] Shimmy shimmy yay, shimmy\n[03:25.00] Shimmy shimmy yah\n[03:26.00] 5'9", brown eyes, innit, innit\n[03:28.00] Shimmy shimmy yay, shimmy\n[03:30.00] Shimmy shimmy yah\n[03:31.00] 5'9", brown eyes, and she in-in—\n[03:33.00] Shimmy shimmy yay, shimmy\n[03:34.00] Shimmy shimmy yah\n[03:35.00] 5'9", brown eyes...	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
7	50	[00:00.60] Từ giờ anh sẽ xóa đi hết kỉ niệm\n[00:05.15] Anh sẽ quên hết thứ anh đã tin\n[00:09.94] Chẳng để sót lại gì làm anh lưu luyến\n[00:16.85] Anh chẳng còn sức để ôm vào lòng\n[00:21.05] Hãy để mọi thứ trôi đi theo dòng\n[00:25.50] Hãy cứ xem như chuyện mình chỉ là giấc mơ\n[00:33.20] Cũng đã bao tháng trôi qua\n[00:37.20] Mà anh cứ ngỡ chỉ mới hôm qua\n[00:40.79] Có lẽ anh chỉ chực chờ hoài, rồi đếm giây trôi\n[00:44.50] Xong cứ nghĩ mãi về đôi ta, oh\n[00:48.50] Từng hứa sẽ quên em nhanh\n[00:52.00] Mà dường như cơn mưa mãi không tạnh\n[00:55.50] Nhìn em vui hạnh phúc bên ai rồi\n[00:59.20] Mà sao tim anh chẳng đành?\n[01:03.20] Từ giờ anh sẽ xóa đi hết kỷ niệm\n[01:07.04] Anh sẽ quên hết thứ anh đã tin\n[01:11.84] Chẳng để sót lại gì làm anh lưu luyến\n[01:18.25] Anh chẳng còn sức để ôm vào lòng\n[01:22.50] Hãy để mọi thứ trôi đi theo dòng\n[01:27.00] Và cứ xem như chuyện mình chỉ là giấc mơ (chỉ là giấc mơ)\n[01:34.00] Baby, anh nhận ra ta chưa từng chịu nghe nhau nói\n[01:36.40] Cứ trách và móc để dần nỗi nhớ nhân đôi\n[01:38.40] Không bận tâm rồi một ngày cơn giông tới\n[01:40.59] Để nó cuốn đi hết, giờ thì hai đứa hai nơi\n[01:42.70] Ta phí thời giờ với những lần tranh cãi\n[01:44.70] Cũng chỉ để nhận lại dòng nước mắt tuôn rơi\n[01:47.00] Rớt thành dòng, tích thành vùng biên hải\n[01:49.00] Rồi lại đặt câu hỏi, "Sao tan nát em ơi?"\n[01:51.20] Oh, ta thường sống như vậy mà\n[01:53.20] Biết là bad vẫn cố chấp như vậy mà\n[01:55.20] Nước mắt siết thành thác, tới khô khốc như vậy mà\n[01:57.20] Tình mình hóa tan nát cũng vì ngu ngốc như vậy mà\n[01:59.20] Oh, chỉ là vài lời cuối rồi anh hứa rằng mình sẽ cố quên đi em\n[02:03.00] Nếu mai này em tìm được hạnh phúc, hãy chậm lại một chút để lắng nghe nhau thêm\n[02:06.20] Anh đã cố để quên em nhanh\n[02:09.80] Mà dường như cơn mưa mãi không tạnh\n[02:13.19] Nhìn em vui hạnh phúc bên ai rồi\n[02:17.00] Mà sao tim anh chẳng đành\n[02:21.00] Từ giờ anh sẽ xóa đi hết kỷ niệm\n[02:24.80] Anh sẽ quên hết thứ anh đã tin\n[02:29.00] Chẳng để sót lại gì làm anh lưu luyến\n[02:35.80] Anh chẳng còn sức để ôm vào lòng\n[02:40.00] Hãy để mọi thứ trôi đi theo dòng\n[02:44.50] Và cứ xem như chuyện mình chỉ là giấc mơ\n[02:51.80] Anh từng ước thời gian ngưng đọng\n[02:55.80] Để được ôm em vào mãi trong lòng\n[02:59.80] Giờ mọi thứ như hóa vô vọng\n[03:03.80] Anh phải làm sao để qua cơn giông?\n[03:07.80] Từng lời em nói còn vang bên tai\n[03:11.80] Dù anh đã cố để chẳng nhớ lại\n[03:15.80] Từ giờ ta chấm dứt chia hai\n[03:19.19] Hãy quên giấc mơ yêu mãi không phai	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
8	10	[00:29.94] Em là ai từ đâu bước đến nơi đây dịu dàng chân phương (dịu dàng chân phương)\n[00:34.67] Em là ai tựa như ánh nắng ban mai ngọt ngào trong sương (ngọt ngào trong sương)\n[00:40.13] Ngắm em thật lâu, con tim anh yếu mềm\n[00:45.38] Đắm say từ phút đó, từng giây trôi yêu thêm\n[00:50.42] Bao ngày qua bình minh đánh thức xua tan bộn bề nơi anh (bộn bề nơi anh)\n[00:55.45] Bao ngày qua niềm thương nỗi nhớ bay theo bầu trời trong xanh (bầu trời trong xanh)\n[01:01.06] Liếc đôi hàng mi mong manh, anh thẫn thờ\n[01:06.20] Muốn hôn nhẹ mái tóc, bờ môi em, anh mơ\n[01:11.39] Cầm tay anh (anh), dựa vai anh (anh)\n[01:14.10] Kề bên anh, nơi này có anh\n[01:16.09] Gió mang câu tình ca, ngàn ánh sao vụt qua, nhẹ ôm lấy em\n[01:20.45] (Yêu em, thương em, con tim anh chân thành)\n[01:21.78] Cầm tay anh (anh), dựa vai anh (anh)\n[01:24.53] Kề bên anh, nơi này có anh\n[01:26.78] Khép đôi mi thật lâu\n[01:28.25] Nguyện mãi bên cạnh nhau, yêu say đắm như ngày đầu\n[01:31.71] Mùa xuân đến bình yên, cho anh những giấc mơ\n[01:36.95] Hạ lưu giữ ngày mưa, ngọt ngào nên thơ\n[01:42.56] Mùa thu lá vàng rơi, đông sang, anh nhớ em\n[01:47.84] Tình yêu bé nhỏ xin dành tặng riêng em\n[02:03.49] (Yeah)\nCòn đó tiếng nói ấy bên tai vấn vương bao ngày qua\nÁnh mắt bối rối nhớ thương bao ngày qua\nYêu em anh thẫn thờ, con tim bâng khuâng đâu có ngờ\nChẳng bao giờ phải mong chờ, đợi ai trong chiều hoàng hôn mờ\nĐắm chìm hòa vào vần thơ, ngắm nhìn khờ dại mộng mơ\nĐừng bước vội vàng rồi làm ngơ, lạnh lùng đó làm bộ dạng thờ ơ\nNhìn anh đi em nha, hướng nụ cười cho riêng anh nha\nĐơn giản là yêu, con tim anh lên tiếng thôi\nCầm tay anh (anh), dựa vai anh (anh)\nKề bên anh, nơi này có anh\nGió mang câu tình ca, ngàn ánh sao vụt qua, nhẹ ôm lấy em\n(Yêu em, thương em, con tim anh chân thành)\nCầm tay anh (anh), dựa vai anh (anh)\nKề bên anh, nơi này có anh\nKhép đôi mi thật lâu\nNguyện mãi bên cạnh nhau, yêu say đắm như ngày đầu\nMùa xuân đến bình yên, cho anh những giấc mơ\nHạ lưu giữ ngày mưa, ngọt ngào nên thơ\nMùa thu lá vàng rơi, đông sang, anh nhớ em\nTình yêu bé nhỏ xin dành tặng riêng em\nAh-ah-oh-oh-oh-oh-oh-oh-oh, nhớ thương em\nOh-oh-oh-oh-oh-oh-oh-oh-oh, nhớ thương em lắm\nAh, phía sau chân trời\nCó ai băng qua lối về, cùng em đi trên đoạn đường dài\nCầm tay anh (anh), dựa vai anh (anh)\nKề bên anh, nơi này có anh\nGió mang câu tình ca, ngàn ánh sao vụt qua, nhẹ ôm lấy em\n(Yêu em, thương em, con tim anh chân thành)\nCầm tay anh (anh), dựa vai anh (anh)\nKề bên anh, nơi này có anh\nKhép đôi mi thật lâu\nNguyện mãi bên cạnh nhau, yêu say đắm như ngày đầu (oh-oh)\nMùa xuân đến bình yên, cho anh những giấc mơ\nHạ lưu giữ ngày mưa, ngọt ngào nên thơ\nMùa thu lá vàng rơi, đông sang, anh nhớ em\nTình yêu bé nhỏ xin dành tặng riêng em	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
9	20	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
10	19	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
11	46	[00:00.00] [Verse 1]\n[00:10.00] Anh thường hay thức khuya\n[00:11.00] Nghĩ về thứ anh vẫn luôn mong đợi\n[00:14.00] Rằng phải làm sao?\n[00:15.00] Cũng chẳng biết đến bao giờ?\n[00:20.00] Những lời ca dở dang\n[00:21.00] Anh ngồi viết mãi vẫn còn chưa xong\n[00:24.00] Chạy theo đằng sau ánh sáng\n[00:27.00] Cuối nơi chân trời.\n[00:29.00] Rồi em đến đây dịu dàng cạnh bên anh\n[00:33.00] Cơn mưa rơi trở nên long lanh\n[00:35.00] Chẳng còn đợi trông\n[00:37.00] Vì giấc mơ có em thêm màu xanh\n[00:40.00] Thật lòng chẳng xa xôi\n[00:43.00] Ước muốn anh ở ngay đây thôi\n[00:45.00] Anh không bận tâm nữa\n[00:47.00] Vì anh có em.\n[00:50.00] Nếu như ngày mai không diễn ra\n[00:52.00] Giống cách mà anh cứ luôn mơ mộng?\n[00:55.00] Thì vẫn có một người luôn phía sau\n[00:58.00] Nhẹ nắm tay anh\n[01:00.00] Biết còn nhiều điều lo lắng đang vây quanh\n[01:03.00] Dặn lòng phải xứng đáng hơn\n[01:05.00] Để anh trở thành chàng trai\n[01:07.00] Top 1 trong mắt em.\n[01:13.00] Phải tự thân vượt lên, anh vốn không thích hai chữ đáng thương\n[01:15.00] Nhiều người nói là không được đâu nhưng anh vẫn cứ ngang ngược\n[01:17.00] Bởi vì sâu ở trong đầu anh toàn chứa những thứ hoang đường\n[01:19.00] Và từ hồi bé anh đã mơ ước được hát như chú Đan Trường\n[01:21.00] Bầu trời đêm okay cho nên không sao\n[01:23.00] Có đứa nhóc ôm đàn ngân nga những câu yêu đời\n[01:26.00] Dù cho phải gặp bao nhiêu gian khó\n[01:28.00] Vẫn luôn là em dõi theo anh\n[01:31.00] Dù anh đi đến đâu...\n[01:45.00] Nếu như ngày mai không diễn ra\n[01:47.00] Giống cách mà anh cứ luôn mơ mộng?\n[01:50.00] Thì vẫn có một người luôn phía sau\n[01:53.00] Nhẹ nắm tay anh\n[01:55.00] Biết còn nhiều điều lo lắng đang vây quanh\n[01:58.00] Dặn lòng phải xứng đáng hơn\n[02:00.00] Để anh trở thành chàng trai\n[02:02.00] Top 1 trong mắt em.\n[02:08.00] Những cơ hội vụt qua đôi tay\n[02:11.00] Vậy chắc chưa phải là ngày hôm nay\n[02:14.00] Thì cứ tiếp tục để chạy theo tiếng gọi\n[02:17.00] Từng câu nói mà anh vẫn luôn tin vào.\n[02:20.00] Có những lần đôi mắt anh lạc phương hướng\n[02:23.00] Để rồi đêm tối anh không về nhà\n[02:26.00] Thì vẫn luôn là em\n[02:28.00] Ngọn đèn rực rỡ chiếu soi nơi anh...\n[02:30.00] Nếu như ngày mai không diễn ra\n[02:32.00] Giống cách mà anh cứ luôn mơ mộng\n[02:35.00] Thì vẫn có một người luôn phía sau nhẹ nắm tay anh\n[02:40.00] Biết còn nhiều điều lo lắng đang vây quanh\n[02:43.00] Dặn lòng phải xứng đáng hơn\n[02:45.00] Để anh trở thành chàng trai\n[02:48.00] Top 1 trong mắt em...\n[02:53.00] Top 1 trong mắt em.\n[Chorus]\n[Verse 2]\n[Chorus]\n[Bridge]\n[Chorus & Outro]	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
12	45	[00:02.00] Còn cần thiết nữa, nói chi đến đây cũng thừa\n[00:04.00] Giờ chỉ còn mình với vấn vương (Rượu vang pha với cơn mưa)\n[00:07.00] Hàng trăm lý do cũng chẳng thể cứu vãn\n[00:09.00] Biết sao hết cho vừa?\n[00:11.00] Lòng nhau mới thấu đây em\n[00:13.00] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\n[00:17.00] Rượu vang pha với cơn mưa\n[00:20.00] Hàng trăm lý do cũng chẳng thể cứu vãn\n[00:22.00] Biết sao hết cho vừa? Lòng nhau mới thấu đây em\n[00:26.00] Dệt hàng triệu vết thương, tự vùi mình trước gương\n[00:30.00] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\n[00:33.00] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\n[00:37.00] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\n[00:41.00] Ta chia tay, vì sao em ơi?\n[00:44.00] Điều này anh muốn hỏi lâu rồi\n[00:47.00] Những khung trời kỷ niệm vỡ đôi\n[00:50.00] Có phải vì một câu anh đã lỡ lời?\n[00:54.00] Sau đêm nay, tự ta cho ta\n[00:57.00] Em và anh một đoạn kết mới\n[01:00.00] Dù rằng mình còn yêu nhau rất nhiều đấy\n[01:04.00] Nhưng để ở lại thì anh nghĩ là không\n[01:06.00] Và sau những cảm xúc nhất thời\n[01:10.00] Người bên em giờ này chẳng còn là anh\n[01:13.00] Gửi lại quá khứ cung đàn đã vỡ\n[01:17.00] Vì những vấn vương ấy chưa kịp thành lời\n[01:19.00] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\n[01:23.00] Rượu vang pha với cơn mưa\n[01:26.00] Hàng trăm lý do cũng chẳng thể cứu vãn\n[01:28.00] Biết sao hết cho vừa? Lòng nhau mới thấu đây em\n[01:33.00] Dệt hàng triệu vết thương, tự vùi mình trước gương\n[01:36.00] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\n[01:39.00] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\n[01:43.00] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\n[01:46.00] Tất cả là tại vì em, em, em, em, em, e-em\n[01:50.00] Người xa lạ anh từng quen\n[01:53.00] Tất cả là tại vì em, em, em, em, em, e-em\n[01:57.00] Kẻ ngốc đang say tình dưới ngọn đèn\n[01:59.00] Tất cả là tại vì em, em, em, em, em, e-em\n[02:03.00] Người xa lạ anh từng quen\n[02:06.00] Tất cả là tại vì em, em, em, em, em, yeah-eh-eh\n[02:10.00] Kẻ ngốc đang say tình dưới ngọn đèn\n[02:13.00] Lau đôi mi, đây là nước mắt hay mưa\n[02:15.00] Buông đôi tay, anh đâu muốn phải dây dưa\n[02:17.00] Quên đi đôi mắt ấy khi xưa, chẳng bên nhau được nữa\n[02:20.00] Sau bao lần đau, anh lại cho đi và quên\n[02:22.00] Anh ghét nỗi đau, cơn mưa đêm kia và em\n[02:24.00] Ta vội quên rồi, những điều sao thật quen\n[02:27.00] Để nỗi buồn kia gọi tên mỗi khi bài ca bật lên\n[02:28.00] Và sau những cảm xúc nhất thời\n[02:30.00] Người bên em giờ này chẳng còn là anh\n[02:33.00] Gửi lại quá khứ cung đàn đã vỡ\n[02:37.00] Vì những vấn vương ấy chưa kịp thành lời\n[02:39.00] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\n[02:43.00] Rượu vang pha với cơn mưa\n[02:45.00] Hàng trăm lý do cũng chẳng thể cứu vãn\n[02:48.00] Biết sao hết cho vừa lòng nhau mới thấu đây em?\n[02:52.00] Dệt hàng triệu vết thương, tự vùi mình trước gương\n[02:56.00] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\n[03:03.00] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\n[03:07.00] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\n[03:11.00] Tất cả là tại vì em...\n[03:15.00] Người xa lạ anh từng quen...\n[03:19.00] Tất cả là tại vì em...\n[Chorus: CAPTAIN BOY & CoolKid]\n[Verse 1: Pháp Kiều & CAPTAIN BOY]\n[Pre-Chorus: Quang Hùng MasterD]\n[Chorus: Quang Hùng MasterD & CAPTAIN BOY]\n[Post-Chorus: Quang Hùng MasterD & CoolKid]\n[Verse 2: Pháp Kiều]\n[Pre-Chorus: CoolKid & Quang Hùng MasterD]\n[Chorus: Cả nhóm]\n[Outro]	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
13	56	[00:21.57] Nơi anh bao năm không có nắng\n[00:24.28] Và mưa giăng nơi em đôi khi cũng chưa từng muốn ngừng\n[00:27.00] Mà đi bao xa ta vẫn thấy ngắn\n[00:29.19] Vì nơi đâu cũng là nhà\n[00:32.46] Anh băng qua bao la con sóng trắng\n[00:35.13] Niềm tin mong manh cũng chỉ biết giăng buồm thật căng\n[00:37.75] Để mà lênh đênh trôi mang theo bao cố gắng\n[00:40.10] Dù mưa gió có lỡ xô anh đi xa bến bờ\n[00:43.03] Vì ngày đó anh chẳng cần biết điều gì đến\n[00:46.95] Cũng chẳng thể viết vội đoạn kết\n[00:49.67] Khi còn chưa đi hết những xước chai, những đúng sai\n[00:53.96] Và ngoài đó hoang tàn giằng xé\n[00:56.64] Thì ở đây vẫn có điều nhỏ bé\n[00:59.46] Mà lặng lẽ vun xây những mơ mộng này\n[01:02.25] Để hôm nay khi đứng đây, em chính là điều nhỏ bé ở bên bờ\n[01:05.62] (<I'm in love, I'm in love, in love with you>) ooh, my love\n[01:08.42] (<I'm in love, I'm in love, in love with you>) nơi ấy em chờ\n[01:11.15] (<I'm in love, I'm in love, in love with you>) ở bên bờ, ở bên bờ cùng mong nhớ\n[01:16.64] (<I'm in love, I'm in love, in love with you>) ooh, my love\n[01:19.37] (<I'm in love, I'm in love, in love with you>) nơi ấy em chờ\n[01:22.06] (<I'm in love, I'm in love, in love with you>)\n[01:24.28] Em vẫn luôn rạng rỡ, gom từng thương nhớ nơi bến bờ\n[01:27.51] Yeah, nhiều cô gái không hiểu được anh\n[01:29.78] Và có nhiều mối quan hệ ngày xưa cũng tự kết thúc vì nó\n[01:32.72] Anh là kiểu người mà nếu muốn đùa cợt thì nhanh\n[01:35.28] Nhưng để ngồi xuống nói chuyện mở lòng thực sự thì khó\n[01:37.45] Chắc là anh không giỏi chuyện đó, anh vô thức giấu hết đi\n[01:40.31] Anh vô thức giấu hết đi vào trong hố đen những luồng suy nghĩ\n[01:43.17] Và em là người đầu tiên dạy anh nghĩ gì phải nói ra\n[01:45.87] Nhưng nhiều lúc nói tự nhiên cổ họng của anh bị nghẹn và\n[01:48.25] Não không nghĩ được gì cả, cảm giác đấy khá kì lạ\n[01:51.06] Cảm giác như không sắp xếp được đúng suy nghĩ để cho mình tả\n[01:53.75] Lớn lên anh nhận ra mở lòng là kĩ năng\n[01:56.15] Anh nghĩ EQ anh chưa cao và anh chưa thực sự chín chắn, ah\n[01:59.25] Đôi nào chả có cãi vã khi căng thẳng tăng dần lên\n[02:01.92] Sẽ có những chủ đề thực sự nhạy cảm nếu như đề cập đến\n[02:04.68] Nhưng cho đến cuối em vẫn bình tĩnh nghe anh (nghe)\n[02:07.43] Nói với anh rằng nếu từ đầu anh cho em biết thì mưa giông trong đầu anh sẽ tạnh thôi\n[02:11.46] Ngày trôi, đầu anh trở nên thảnh thơi\n[02:13.62] Anh thấy hạnh phúc khi ở cùng em nhìn mưa bên ngoài rơi\n[02:16.49] Anh chưa bao giờ cảm thấy an toàn và yên tâm như thế\n[02:19.12] Và mình có thể nói chuyện hàng giờ về chỉ một chủ đề\n[02:22.12] You're the only girl showing me the way to love\n[02:24.62] Only one I trust, ain't afraid to tell the world\n[02:27.50] Many things to learn, anh không cần gì hơn\n[02:29.57] Ngoài thấy em ở bên cạnh anh khi anh mở mắt dậy vào sáng sớm, ah\n[02:32.06] Ooh, my love (I'm in love, I'm in love, in love with you)\n[02:34.62] Ooh, my love (yeah) (I'm in love, I'm in love, in love with you)\n[02:37.32] Nơi ấy em chờ (I'm in love, I'm in love, in love with you) (this song's for you)\n[02:40.21] Ở bên bờ, ở bên bờ cùng mong nhớ (ah, ah, ah, ah)\n[02:43.81] (<I'm in love, I'm in love, in love with you>) ooh, my love\n[02:46.59] (<I'm in love, I'm in love, in love with you>) nơi ấy em chờ\n[02:49.21] (<I'm in love, I'm in love, in love with you>) yeah\n[02:51.43] Em vẫn luôn rạng rỡ, gom từng thương nhớ nơi bến bờ (yeah, yeah, yeah, yeah)\n[02:54.65] (<I'm in love, I'm in love, in love with you>) I'm in love with you\n[02:57.65] (<I'm in love, I'm in love>) in love with you, in love (I'm in love, I'm in love, in love with you)\n[03:00.21] (<I'm in love, I'm in love, in love with you>) I'm in love with you (hah)\n[03:04.52] My love ở bên bờ (Low G) (I'm in love, I'm in love, in love with you)\n[03:06.78] Bên bờ có em chờ (and JustaTee) (I'm in love, I'm in love, in love with you)\n[03:09.18] Ooh-ooh-ooh (2025) (I'm in love, I'm in love, in love with you)\n[03:13.00] I'm in love with you, with you, with you	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
14	63	[ti:Top 1 (Trong Mắt Em)]\r\n[ar:buitruonglinh]\r\n[al:Top 1 (Trong Mắt Em)]\r\n[by:Antigravity]\r\n\r\n[00:00.00]Top 1 (Trong Mắt Em) - buitruonglinh\r\n[00:08.50]...\r\n[00:10.25]Anh thường hay thức khuya\r\n[00:11.80]Nghĩ về thứ anh vẫn luôn mong đợi\r\n[00:14.65]Rằng phải làm sao?\r\n[00:15.88]Cũng chẳng biết đến bao giờ?\r\n[00:20.30]Những lời ca dở dang\r\n[00:21.91]Anh ngồi viết mãi vẫn còn chưa xong\r\n[00:24.70]Chạy theo đằng sau ánh sáng\r\n[00:27.10]Cuối nơi chân trời\r\n[00:29.49]Rồi em đến đây\r\n[00:30.80]Dịu dàng cạnh bên anh\r\n[00:33.08]Cơn mưa rơi trở nên long lanh\r\n[00:35.47]Chẳng còn đợi trông\r\n[00:37.48]Vì giấc mơ có em thêm màu xanh\r\n[00:40.27]Thật lòng chẳng xa xôi\r\n[00:43.08]Ước muốn anh ở ngay đây thôi\r\n[00:45.85]Anh không bận tâm nữa\r\n[00:47.46]Vì anh có em\r\n[00:50.43]Nếu như ngày mai không diễn ra\r\n[00:52.81]Giống cách mà anh cứ luôn mơ mộng?\r\n[00:55.60]Thì vẫn có một người luôn phía sau\r\n[00:58.01]Nhẹ nắm tay anh\r\n[01:00.41]Biết còn nhiều điều lo lắng đang vây quanh\r\n[01:03.99]Dặn lòng phải xứng đáng hơn\r\n[01:05.98]Để anh trở thành chàng trai\r\n[01:07.59]Top 1 trong mắt em\r\n[01:11.35]Phải tự thân vượt lên, anh vốn không thích hai chữ đáng thương\r\n[01:14.07]Nhiều người nói là không được đâu nhưng anh vẫn cứ ngang ngược\r\n[01:16.47]Bởi vì sâu ở trong đầu anh toàn chứa những thứ hoang đường\r\n[01:19.08]Và từ hồi bé anh đã mơ ước được hát như chú Đan Trường\r\n[01:21.75]Bầu trời đêm okay cho nên không sao\r\n[01:23.88]Có đứa nhóc ôm đàn ngân nga những câu yêu đời\r\n[01:26.55]Dù cho phải gặp bao nhiêu gian khó\r\n[01:27.80]Vẫn luôn là em dõi theo anh\r\n[01:29.74]Dù anh đi đến đâu...\r\n[01:31.60]Nếu như ngày mai không diễn ra\r\n[01:33.99]Giống cách mà anh cứ luôn mơ mộng?\r\n[01:36.78]Thì vẫn có một người luôn phía sau\r\n[01:39.17]Nhẹ nắm tay anh\r\n[01:41.59]Biết còn nhiều điều lo lắng đang vây quanh\r\n[01:44.78]Dặn lòng phải xứng đáng hơn\r\n[01:46.80]Để anh trở thành chàng trai\r\n[01:48.50]Top 1 trong mắt em\r\n[01:52.50]Những cơ hội vụt qua đôi tay\r\n[01:55.20]Vậy chắc chưa phải là ngày hôm nay\r\n[01:57.80]Thì cứ tiếp tục để chạy theo tiếng gọi\r\n[01:59.80]Từng câu nói mà anh\r\n[02:00.91]Vẫn luôn tin vào\r\n[02:02.49]Có những lần đôi mắt anh lạc phương hướng\r\n[02:04.90]Để rồi đêm tối anh không về nhà\r\n[02:07.69]Thì vẫn luôn là em\r\n[02:08.87]Ngọn đèn rực rỡ chiếu soi nơi anh...\r\n[02:12.47]Nếu như ngày mai không diễn ra\r\n[02:15.32]Giống cách mà anh cứ luôn mơ mộng?\r\n[02:18.11]Thì vẫn có một người luôn phía sau\r\n[02:20.50]Nhẹ nắm tay anh\r\n[02:22.90]Biết còn nhiều điều lo lắng đang vây quanh\r\n[02:26.50]Dặn lòng phải xứng đáng hơn\r\n[02:28.50]Để anh trở thành chàng trai\r\n[02:30.50]Top 1 trong mắt em...\r\n[02:35.00]Top 1 trong mắt em\r\n[02:40.00]Top 1 trong mắt em...\r\n[02:46.00]...	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
15	22	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
16	21	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
17	23	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
18	15	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...	PUBLISHED	1	2026-10-31 08:34:25.722	2026-10-31 08:34:25.722
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.password_reset_tokens (id, user_id, token_hash, expires_at, used_at, created_at, staff_id) FROM stdin;
\.


--
-- Data for Name: personal_lyrics; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.personal_lyrics (id, user_id, track_id, lyric_type, lyric_content, created_at, updated_at) FROM stdin;
1	8	49	CUSTOM	[Intro]\r\n[00:00] (Nhạc dạo đầu)\r\n[Verse 1: CONGB & Cody Nam Võ]\r\n[00:15] Kể từ khi gặp em, trí nhớ hơi bị kém\r\n[00:19] Những món ăn thân quen sao nay bỗng dưng chẳng thèm?\r\n[00:22] Dù bụng đói cồn cào, lại chẳng thể nói lời nào\r\n[00:26] Vì gu em không thích người quá cao\r\n[00:30] Mà anh chẳng hề cao, tính nóng hơi bị láo\r\n[00:33] Nói những câu tào lao khi em nói câu xin chào\r\n[00:37] Vậy thì theo anh đến một nơi, không có biển khơi\r\n[00:41] Chỉ có vườn với trái cây mà thôi\r\n[Pre-Chorus: Quang Hùng MasterD]\r\n[00:44] Vườn anh có trái dưa, trái dâu, trái thơm, trái nho, có luôn banana\r\n[00:50] Nhưng thiếu đi trái tim của một người\r\n[00:53] Lòng anh như gió đông giữa trời đêm\r\n[00:55] Mong thấy em khi bình minh lên, oh-hoh\r\n[Chorus: Cody Nam Võ & Quang Hùng MasterD]\r\n[00:57] Tình đầu ngây thơ mà em, đúng không?\r\n[01:01] Còn chưa nắm tay, chưa về tới phòng\r\n[01:04] Mình còn trông ngóng biết nhiều về nhau\r\n[01:07] Đêm đến ta lại ngắm sao, làm sao mở lòng?\r\n[01:12] Chẳng phải em muốn được anh ghé tai?\r\n[01:15] Thầm thì vài câu suốt bao đêm dài\r\n[01:19] Trời cao có thấu nỗi lòng tận mây xanh?\r\n[01:22] Nói em nghe bí mật của anh!\r\n[Rap Verse: Wren Evans]\r\n[01:26] Nói hết bí mật thì có yêu không?\r\n[01:30] Muốn thấy bí mật hay em muốn nghe bằng lời nói?\r\n[01:34] Đến đây với anh, trăm nghe không bằng một lần thấy\r\n[01:37] Ai rồi cũng phải yêu rồi đấy, baby, ooh-ooh\r\n[01:41] Phải làm sao để gặp my baby?\r\n[01:44] Muốn yêu em chân thành vì anh đâu muốn yêu theo phong trào mà bae\r\n[01:48] Em quen anh chân thành, làm một bộ phim hai ta đóng vai người yêu\r\n[01:52] Rất muốn ai đó có thể nói ra hết sự thật\r\n[01:54] Rằng anh thương em rất nhiều\r\n[01:56] Giờ này nếu thắc mắc em qua bên...\r\n[Bridge: Cody Nam Võ, CONGB & Quang Hùng MasterD]\r\n[02:00] ("Baby à, anh đã nói là em trao cho anh trái tim, sao lại là trái bơ đó hả? Thôi CONGB dô!")\r\n[02:08] Vậy người có muốn mình tay nắm tay?\r\n[02:12] Tình anh đã trao không cần giãi bày\r\n[02:15] Nụ cười em sáng hơn mặt trăng đang lên\r\n[02:19] Chiếu sâu vào trái tim, anh không đỡ được\r\n[02:23] Tặng nàng bài thơ dù không có hay\r\n[02:26] Chỉ mong em hiểu lấy tâm tư này\r\n[02:30] Trời cao có thấu nỗi lòng tận mây xanh?\r\n[02:34] Nói em nghe bí mật của anh!\r\n(Tone nâng nửa cung)\r\n\r\n[Chorus: Wren Evans & Cody Nam Võ]\r\n[02:38] Tình đầu ngây thơ mà em, đúng không?\r\n[02:41] Còn chưa nắm tay, chưa về tới phòng\r\n[02:45] Mình còn trông ngóng biết nhiều về nhau\r\n[02:48] Đêm đến ta lại ngắm sao, làm sao mở lòng?\r\n[02:52] Chẳng phải em muốn được anh ghé tai?\r\n[02:56] Thầm thì vài câu suốt bao đêm dài\r\n[03:00] Trời cao có thấu nỗi lòng tận mây xanh?\r\n[03:04] Nói em nghe bí mật của anh!\r\n[Outro]\r\n[03:08] Bí mật của anh...\r\n[03:12] Nói em nghe bí mật của anh...	2026-10-18 04:08:25.657	2026-10-18 04:27:43.854
2	8	59	CUSTOM	[00:10.00] Anh thường hay thức khuya\n[00:11.00] Nghĩ về thứ anh vẫn luôn mong đợi\n[00:14.00] Rằng phải làm sao?\n[00:15.00] Cũng chẳng biết đến bao giờ?\n[00:20.00] Những lời ca dở dang\n[00:21.00] Anh ngồi viết mãi vẫn còn chưa xong\n[00:24.00] Chạy theo đằng sau ánh sáng\n[00:27.00] Cuối nơi chân trời.\n[00:29.00] Rồi em đến đây dịu dàng cạnh bên anh\n[00:33.00] Cơn mưa rơi trở nên long lanh\n[00:35.00] Chẳng còn đợi trông\n[00:37.00] Vì giấc mơ có em thêm màu xanh\n[00:40.00] Thật lòng chẳng xa xôi\n[00:43.00] Ước muốn anh ở ngay đây thôi\n[00:45.00] Anh không bận tâm nữa\n[00:47.00] Vì anh có em.\n[00:50.00] Nếu như ngày mai không diễn ra\n[00:52.00] Giống cách mà anh cứ luôn mơ mộng?\n[00:55.00] Thì vẫn có một người luôn phía sau\n[00:58.00] Nhẹ nắm tay anh\n[01:00.00] Biết còn nhiều điều lo lắng đang vây quanh\n[01:03.00] Dặn lòng phải xứng đáng hơn\n[01:05.00] Để anh trở thành chàng trai\n[01:07.00] Top 1 trong mắt em.\n[01:13.00] Phải tự thân vượt lên, anh vốn không thích hai chữ đáng thương\n[01:15.00] Nhiều người nói là không được đâu nhưng anh vẫn cứ ngang ngược\n[01:17.00] Bởi vì sâu ở trong đầu anh toàn chứa những thứ hoang đường\n[01:19.00] Và từ hồi bé anh đã mơ ước được hát như chú Đan Trường\n[01:21.00] Bầu trời đêm okay cho nên không sao\n[01:23.00] Có đứa nhóc ôm đàn ngân nga những câu yêu đời\n[01:26.00] Dù cho phải gặp bao nhiêu gian khó\n[01:28.00] Vẫn luôn là em dõi theo anh\n[01:31.00] Dù anh đi đến đâu...\n[01:45.00] Nếu như ngày mai không diễn ra\n[01:47.00] Giống cách mà anh cứ luôn mơ mộng?\n[01:50.00] Thì vẫn có một người luôn phía sau\n[01:53.00] Nhẹ nắm tay anh\n[01:55.00] Biết còn nhiều điều lo lắng đang vây quanh\n[01:58.00] Dặn lòng phải xứng đáng hơn\n[02:00.00] Để anh trở thành chàng trai\n[02:02.00] Top 1 trong mắt em.\n[02:08.00] Những cơ hội vụt qua đôi tay\n[02:11.00] Vậy chắc chưa phải là ngày hôm nay\n[02:14.00] Thì cứ tiếp tục để chạy theo tiếng gọi\n[02:17.00] Từng câu nói mà anh vẫn luôn tin vào.\n[02:20.00] Có những lần đôi mắt anh lạc phương hướng\n[02:23.00] Để rồi đêm tối anh không về nhà\n[02:26.00] Thì vẫn luôn là em\n[02:28.00] Ngọn đèn rực rỡ chiếu soi nơi anh...\n[02:30.00] Nếu như ngày mai không diễn ra\n[02:32.00] Giống cách mà anh cứ luôn mơ mộng\n[02:35.00] Thì vẫn có một người luôn phía sau nhẹ nắm tay anh\n[02:40.00] Biết còn nhiều điều lo lắng đang vây quanh\n[02:43.00] Dặn lòng phải xứng đáng hơn\n[02:45.00] Để anh trở thành chàng trai\n[02:48.00] Top 1 trong mắt em...\n[02:53.00] Top 1 trong mắt em.\n[Verse 1]\n[Chorus]\n[Verse 2]\n[Chorus]\n[Bridge]\n[Chorus & Outro]	2026-10-23 06:10:57.506	2026-10-23 06:12:06.533
3	8	48	CUSTOM	[Verse 1]\r\n[00:10] Anh thường hay thức khuya\r\n[00:11] Nghĩ về thứ anh vẫn luôn mong đợi\r\n[00:14] Rằng phải làm sao?\r\n[00:15] Cũng chẳng biết đến bao giờ?\r\n[00:20] Những lời ca dở dang\r\n[00:21] Anh ngồi viết mãi vẫn còn chưa xong\r\n[00:24] Chạy theo đằng sau ánh sáng\r\n[00:27] Cuối nơi chân trời.\r\n[00:29] Rồi em đến đây dịu dàng cạnh bên anh\r\n[00:33] Cơn mưa rơi trở nên long lanh\r\n[00:35] Chẳng còn đợi trông\r\n[00:37] Vì giấc mơ có em thêm màu xanh\r\n[00:40] Thật lòng chẳng xa xôi\r\n[00:43] Ước muốn anh ở ngay đây thôi\r\n[00:45] Anh không bận tâm nữa\r\n[00:47] Vì anh có em.\r\n[Chorus]\r\n[00:50] Nếu như ngày mai không diễn ra\r\n[00:52] Giống cách mà anh cứ luôn mơ mộng?\r\n[00:55] Thì vẫn có một người luôn phía sau\r\n[00:58] Nhẹ nắm tay anh\r\n[01:00] Biết còn nhiều điều lo lắng đang vây quanh\r\n[01:03] Dặn lòng phải xứng đáng hơn\r\n[01:05] Để anh trở thành chàng trai\r\n[01:07] Top 1 trong mắt em.\r\n[Verse 2]\r\n[01:13] Phải tự thân vượt lên, anh vốn không thích hai chữ đáng thương\r\n[01:15] Nhiều người nói là không được đâu nhưng anh vẫn cứ ngang ngược\r\n[01:17] Bởi vì sâu ở trong đầu anh toàn chứa những thứ hoang đường\r\n[01:19] Và từ hồi bé anh đã mơ ước được hát như chú Đan Trường\r\n[01:21] Bầu trời đêm okay cho nên không sao\r\n[01:23] Có đứa nhóc ôm đàn ngân nga những câu yêu đời\r\n[01:26] Dù cho phải gặp bao nhiêu gian khó\r\n[01:28] Vẫn luôn là em dõi theo anh\r\n[01:31] Dù anh đi đến đâu...\r\n[Chorus]\r\n[01:45] Nếu như ngày mai không diễn ra\r\n[01:47] Giống cách mà anh cứ luôn mơ mộng?\r\n[01:50] Thì vẫn có một người luôn phía sau\r\n[01:53] Nhẹ nắm tay anh\r\n[01:55] Biết còn nhiều điều lo lắng đang vây quanh\r\n[01:58] Dặn lòng phải xứng đáng hơn\r\n[02:00] Để anh trở thành chàng trai\r\n[02:02] Top 1 trong mắt em.\r\n[Bridge]\r\n[02:08] Những cơ hội vụt qua đôi tay\r\n[02:11] Vậy chắc chưa phải là ngày hôm nay\r\n[02:14] Thì cứ tiếp tục để chạy theo tiếng gọi\r\n[02:17] Từng câu nói mà anh vẫn luôn tin vào.\r\n[02:20] Có những lần đôi mắt anh lạc phương hướng\r\n[02:23] Để rồi đêm tối anh không về nhà\r\n[02:26] Thì vẫn luôn là em\r\n[02:28] Ngọn đèn rực rỡ chiếu soi nơi anh...\r\n[Chorus & Outro]\r\n[02:30] Nếu như ngày mai không diễn ra\r\n[02:32] Giống cách mà anh cứ luôn mơ mộng\r\n[02:35] Thì vẫn có một người luôn phía sau nhẹ nắm tay anh\r\n[02:40] Biết còn nhiều điều lo lắng đang vây quanh\r\n[02:43] Dặn lòng phải xứng đáng hơn\r\n[02:45] Để anh trở thành chàng trai\r\n[02:48] Top 1 trong mắt em...\r\n[02:53] Top 1 trong mắt em.	2026-10-18 04:08:18.719	2026-10-18 04:16:33.268
4	8	47	CUSTOM	[00:02] Còn cần thiết nữa, nói chi đến đây cũng thừa\r\n[00:04] Giờ chỉ còn mình với vấn vương (Rượu vang pha với cơn mưa)\r\n[00:07] Hàng trăm lý do cũng chẳng thể cứu vãn\r\n[00:09] Biết sao hết cho vừa?\r\n[00:11] Lòng nhau mới thấu đây em\r\n[Chorus: CAPTAIN BOY & CoolKid]\r\n[00:13] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\r\n[00:17] Rượu vang pha với cơn mưa\r\n[00:20] Hàng trăm lý do cũng chẳng thể cứu vãn\r\n[00:22] Biết sao hết cho vừa? Lòng nhau mới thấu đây em\r\n[00:26] Dệt hàng triệu vết thương, tự vùi mình trước gương\r\n[00:30] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\r\n[00:33] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\n[00:37] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\r\n[Verse 1: Pháp Kiều & CAPTAIN BOY]\r\n[00:41] Ta chia tay, vì sao em ơi?\r\n[00:44] Điều này anh muốn hỏi lâu rồi\r\n[00:47] Những khung trời kỷ niệm vỡ đôi\r\n[00:50] Có phải vì một câu anh đã lỡ lời?\r\n[00:54] Sau đêm nay, tự ta cho ta\r\n[00:57] Em và anh một đoạn kết mới\r\n[01:00] Dù rằng mình còn yêu nhau rất nhiều đấy\r\n[01:04] Nhưng để ở lại thì anh nghĩ là không\r\n[Pre-Chorus: Quang Hùng MasterD]\r\n[01:06] Và sau những cảm xúc nhất thời\r\n[01:10] Người bên em giờ này chẳng còn là anh\r\n[01:13] Gửi lại quá khứ cung đàn đã vỡ\r\n[01:17] Vì những vấn vương ấy chưa kịp thành lời\r\n[Chorus: Quang Hùng MasterD & CAPTAIN BOY]\r\n[01:19] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\r\n[01:23] Rượu vang pha với cơn mưa\r\n[01:26] Hàng trăm lý do cũng chẳng thể cứu vãn\r\n[01:28] Biết sao hết cho vừa? Lòng nhau mới thấu đây em\r\n[01:33] Dệt hàng triệu vết thương, tự vùi mình trước gương\r\n[01:36] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\r\n[01:39] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\n[01:43] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\r\n[Post-Chorus: Quang Hùng MasterD & CoolKid]\r\n[01:46] Tất cả là tại vì em, em, em, em, em, e-em\r\n[01:50] Người xa lạ anh từng quen\r\n[01:53] Tất cả là tại vì em, em, em, em, em, e-em\r\n[01:57] Kẻ ngốc đang say tình dưới ngọn đèn\r\n[01:59] Tất cả là tại vì em, em, em, em, em, e-em\r\n[02:03] Người xa lạ anh từng quen\r\n[02:06] Tất cả là tại vì em, em, em, em, em, yeah-eh-eh\r\n[02:10] Kẻ ngốc đang say tình dưới ngọn đèn\r\n[Verse 2: Pháp Kiều]\r\n[02:13] Lau đôi mi, đây là nước mắt hay mưa\r\n[02:15] Buông đôi tay, anh đâu muốn phải dây dưa\r\n[02:17] Quên đi đôi mắt ấy khi xưa, chẳng bên nhau được nữa\r\n[02:20] Sau bao lần đau, anh lại cho đi và quên\r\n[02:22] Anh ghét nỗi đau, cơn mưa đêm kia và em\r\n[02:24] Ta vội quên rồi, những điều sao thật quen\r\n[02:27] Để nỗi buồn kia gọi tên mỗi khi bài ca bật lên\r\n[Pre-Chorus: CoolKid & Quang Hùng MasterD]\r\n[02:28] Và sau những cảm xúc nhất thời\r\n[02:30] Người bên em giờ này chẳng còn là anh\r\n[02:33] Gửi lại quá khứ cung đàn đã vỡ\r\n[02:37] Vì những vấn vương ấy chưa kịp thành lời\r\n[Chorus: Cả nhóm]\r\n[02:39] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\r\n[02:43] Rượu vang pha với cơn mưa\r\n[02:45] Hàng trăm lý do cũng chẳng thể cứu vãn\r\n[02:48] Biết sao hết cho vừa lòng nhau mới thấu đây em?\r\n[02:52] Dệt hàng triệu vết thương, tự vùi mình trước gương\r\n[02:56] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\r\n[03:03] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\n[03:07] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\r\n[Outro]\r\n[03:11] Tất cả là tại vì em...\r\n[03:15] Người xa lạ anh từng quen...\r\n[03:19] Tất cả là tại vì em...	2026-10-18 04:07:58.548	2026-10-18 04:09:04.695
6	10	10	CUSTOM	[00:29.94] Em là ai từ đâu bước đến nơi đây dịu dàng chân phương (dịu dàng chân phương)\n[00:34.67] Em là ai tựa như ánh nắng ban mai ngọt ngào trong sương (ngọt ngào trong sương)\n[00:40.13] Ngắm em thật lâu, con tim anh yếu mềm\n[00:45.38] Đắm say từ phút đó, từng giây trôi yêu thêm\n[00:50.42] Bao ngày qua bình minh đánh thức xua tan bộn bề nơi anh (bộn bề nơi anh)\n[00:55.45] Bao ngày qua niềm thương nỗi nhớ bay theo bầu trời trong xanh (bầu trời trong xanh)\n[01:01.06] Liếc đôi hàng mi mong manh, anh thẫn thờ\n[01:06.20] Muốn hôn nhẹ mái tóc, bờ môi em, anh mơ\n[01:11.39] Cầm tay anh (anh), dựa vai anh (anh)\n[01:14.10] Kề bên anh, nơi này có anh\n[01:16.09] Gió mang câu tình ca, ngàn ánh sao vụt qua, nhẹ ôm lấy em\n[01:20.45] (Yêu em, thương em, con tim anh chân thành)\n[01:21.78] Cầm tay anh (anh), dựa vai anh (anh)\n[01:24.53] Kề bên anh, nơi này có anh\n[01:26.78] Khép đôi mi thật lâu\n[01:28.25] Nguyện mãi bên cạnh nhau, yêu say đắm như ngày đầu\n[01:31.71] Mùa xuân đến bình yên, cho anh những giấc mơ\n[01:36.95] Hạ lưu giữ ngày mưa, ngọt ngào nên thơ\n[01:42.56] Mùa thu lá vàng rơi, đông sang, anh nhớ em\n[01:47.84] Tình yêu bé nhỏ xin dành tặng riêng em\n[02:03.49] (Yeah)\nCòn đó tiếng nói ấy bên tai vấn vương bao ngày qua\nÁnh mắt bối rối nhớ thương bao ngày qua\nYêu em anh thẫn thờ, con tim bâng khuâng đâu có ngờ\nChẳng bao giờ phải mong chờ, đợi ai trong chiều hoàng hôn mờ\nĐắm chìm hòa vào vần thơ, ngắm nhìn khờ dại mộng mơ\nĐừng bước vội vàng rồi làm ngơ, lạnh lùng đó làm bộ dạng thờ ơ\nNhìn anh đi em nha, hướng nụ cười cho riêng anh nha\nĐơn giản là yêu, con tim anh lên tiếng thôi\nCầm tay anh (anh), dựa vai anh (anh)\nKề bên anh, nơi này có anh\nGió mang câu tình ca, ngàn ánh sao vụt qua, nhẹ ôm lấy em\n(Yêu em, thương em, con tim anh chân thành)\nCầm tay anh (anh), dựa vai anh (anh)\nKề bên anh, nơi này có anh\nKhép đôi mi thật lâu\nNguyện mãi bên cạnh nhau, yêu say đắm như ngày đầu\nMùa xuân đến bình yên, cho anh những giấc mơ\nHạ lưu giữ ngày mưa, ngọt ngào nên thơ\nMùa thu lá vàng rơi, đông sang, anh nhớ em\nTình yêu bé nhỏ xin dành tặng riêng em\nAh-ah-oh-oh-oh-oh-oh-oh-oh, nhớ thương em\nOh-oh-oh-oh-oh-oh-oh-oh-oh, nhớ thương em lắm\nAh, phía sau chân trời\nCó ai băng qua lối về, cùng em đi trên đoạn đường dài\nCầm tay anh (anh), dựa vai anh (anh)\nKề bên anh, nơi này có anh\nGió mang câu tình ca, ngàn ánh sao vụt qua, nhẹ ôm lấy em\n(Yêu em, thương em, con tim anh chân thành)\nCầm tay anh (anh), dựa vai anh (anh)\nKề bên anh, nơi này có anh\nKhép đôi mi thật lâu\nNguyện mãi bên cạnh nhau, yêu say đắm như ngày đầu (oh-oh)\nMùa xuân đến bình yên, cho anh những giấc mơ\nHạ lưu giữ ngày mưa, ngọt ngào nên thơ\nMùa thu lá vàng rơi, đông sang, anh nhớ em\nTình yêu bé nhỏ xin dành tặng riêng em	2026-10-09 10:03:23.723	2026-10-13 12:25:51.556
7	7	58	CUSTOM	[00:18.00] Let's get the party started\n[00:20.00] See you at the bar, you was hardly talkin'\n[00:22.00] That's when I knew that your heart was scarrin'\n[00:24.00] Friends to lovers, need a part to star in, like, "Wait, babe\n[00:27.00] Let me ask your pardon\n[00:29.00] This ain't Gucci, this is Prada, darlin'\n[00:31.00] If you want somethin', you can ask me, darlin'"\n[00:34.00] Then you started laughin' 'cause you think I'm jokin'\n[00:36.00] But lookin' in your eyes is the best thing\n[00:38.00] Brake lights givin' you the red skin\n[00:40.00] You was in a bad mood from we stepped in\n[00:42.00] Though you checked out 'fore we even checked in\n[00:44.00] On the phone you gon' vent to your best friend\n[00:46.00] The one who gave me the lecture, but I ain't gon' sweat you, babe\n[00:49.00] I'ma let you catch up with your boy, undress you\n[00:52.00] And let me tell you why I'ma bless you\n[00:55.00] It's the way my mind is fallin' away\n[00:59.00] In my heart, I know\n[01:02.00] You feel the same when you're with me\n[01:05.00] You know I'm all you need\n[01:07.00] You're where I wanna be\n[01:09.00] My darling, can't you see?\n[01:12.00] I love you\n[01:16.00] I love you\n[01:20.00] I love you\n[01:24.00] I love you\n[01:29.00] I love you\n[01:31.00] Fell into you\n[01:33.00] Say you want me in the mood\n[01:35.00] Tryna hide my feelings for you\n[01:37.00] Don't wanna argue, not with you\n[01:39.00] Tell me why you're so in denial\n[01:41.00] Hold me close, don't tell me goodnight\n[01:43.00] Are you down to get me?\n[01:46.00] Tell me when you're ready, I'm ready\n[01:49.00] We can get into it or we can get intimate\n[01:52.00] The shower when you sing in it\n[01:53.00] Better than Beyoncé, I like the sound of fiancée\n[01:56.00] You know it's got a little ring to it\n[01:58.00] And really when I think of it\n[01:59.00] Growin' up, I didn't ever see marriages\n[02:01.00] No weddings, no horse, no carriages\n[02:03.00] I wanna do things different and change the narrative\n[02:06.00] God knows you a wild child, beautiful child, I need your help\n[02:09.00] Lookin' like you come from the '90s by yourself\n[02:11.00] My mum sixty-one and her favourite line to tell her son is\n[02:14.00] "Sometimes she wish that she had a girl"\n[02:15.00] I wanna take you back to a time, back to a trip\n[02:18.00] You had that white wine that I never got to sip\n[02:20.00] And dinner wasn't ruined 'cause you never got to pick\n[02:22.00] I know that everybody told me that I'm sick 'cause\n[02:24.00] It's the way my mind is fallin' away\n[02:28.00] In my heart, I know\n[02:30.00] You feel the same when you're with me\n[02:33.00] You know I'm all you need\n[02:36.00] You're where I wanna be\n[02:38.00] My darling, can't you see?\n[02:41.00] I love you (Me and you, never let me go)\n[02:45.00] (Me and you, I'll tell you two times)\n[02:47.00] I love you (Me and you, never let me go)\n[02:50.00] (Me and you, tell me two times)\n[02:52.00] I love you (Me and you, never let me go)\n[02:54.00] (Me and you, tell me two times)\n[02:56.00] I love you (Me and you, never let me go)\n[02:58.00] (Me and you, tell me two times)\n[03:00.00] I said lean with it, rock with it\n[03:03.00] Your finger, I could put a rock in it\n[03:05.00] Fin-finger, I could put a rock in it\n[03:07.00] Bank card, they gon' put a block in it\n[03:09.00] Said rock with it, bounce with it\n[03:12.00] The left wrist, I could put my house in it\n[03:14.00] You wanna bet, babe? I could put my house in it\n[03:16.00] Paper, I could put my spouse in it\n[03:18.00] I said shimmy shimmy yay, shimmy\n[03:20.00] Shimmy shimmy yah\n[03:21.00] 5'9", brown eyes, and she in it, in it\n[03:23.00] Shimmy shimmy yay, shimmy\n[03:25.00] Shimmy shimmy yah\n[03:26.00] 5'9", brown eyes, innit, innit\n[03:28.00] Shimmy shimmy yay, shimmy\n[03:30.00] Shimmy shimmy yah\n[03:31.00] 5'9", brown eyes, and she in-in—\n[03:33.00] Shimmy shimmy yay, shimmy\n[03:34.00] Shimmy shimmy yah\n[03:35.00] 5'9", brown eyes...	2026-10-23 03:53:53.742	2026-10-23 04:01:15.76
8	9	50	CUSTOM	[00:00.60] Từ giờ anh sẽ xóa đi hết kỉ niệm\n[00:05.15] Anh sẽ quên hết thứ anh đã tin\n[00:09.94] Chẳng để sót lại gì làm anh lưu luyến\n[00:16.85] Anh chẳng còn sức để ôm vào lòng\n[00:21.05] Hãy để mọi thứ trôi đi theo dòng\n[00:25.50] Hãy cứ xem như chuyện mình chỉ là giấc mơ\n[00:33.20] Cũng đã bao tháng trôi qua\n[00:37.20] Mà anh cứ ngỡ chỉ mới hôm qua\n[00:40.79] Có lẽ anh chỉ chực chờ hoài, rồi đếm giây trôi\n[00:44.50] Xong cứ nghĩ mãi về đôi ta, oh\n[00:48.50] Từng hứa sẽ quên em nhanh\n[00:52.00] Mà dường như cơn mưa mãi không tạnh\n[00:55.50] Nhìn em vui hạnh phúc bên ai rồi\n[00:59.20] Mà sao tim anh chẳng đành?\n[01:03.20] Từ giờ anh sẽ xóa đi hết kỷ niệm\n[01:07.04] Anh sẽ quên hết thứ anh đã tin\n[01:11.84] Chẳng để sót lại gì làm anh lưu luyến\n[01:18.25] Anh chẳng còn sức để ôm vào lòng\n[01:22.50] Hãy để mọi thứ trôi đi theo dòng\n[01:27.00] Và cứ xem như chuyện mình chỉ là giấc mơ (chỉ là giấc mơ)\n[01:34.00] Baby, anh nhận ra ta chưa từng chịu nghe nhau nói\n[01:36.40] Cứ trách và móc để dần nỗi nhớ nhân đôi\n[01:38.40] Không bận tâm rồi một ngày cơn giông tới\n[01:40.59] Để nó cuốn đi hết, giờ thì hai đứa hai nơi\n[01:42.70] Ta phí thời giờ với những lần tranh cãi\n[01:44.70] Cũng chỉ để nhận lại dòng nước mắt tuôn rơi\n[01:47.00] Rớt thành dòng, tích thành vùng biên hải\n[01:49.00] Rồi lại đặt câu hỏi, "Sao tan nát em ơi?"\n[01:51.20] Oh, ta thường sống như vậy mà\n[01:53.20] Biết là bad vẫn cố chấp như vậy mà\n[01:55.20] Nước mắt siết thành thác, tới khô khốc như vậy mà\n[01:57.20] Tình mình hóa tan nát cũng vì ngu ngốc như vậy mà\n[01:59.20] Oh, chỉ là vài lời cuối rồi anh hứa rằng mình sẽ cố quên đi em\n[02:03.00] Nếu mai này em tìm được hạnh phúc, hãy chậm lại một chút để lắng nghe nhau thêm\n[02:06.20] Anh đã cố để quên em nhanh\n[02:09.80] Mà dường như cơn mưa mãi không tạnh\n[02:13.19] Nhìn em vui hạnh phúc bên ai rồi\n[02:17.00] Mà sao tim anh chẳng đành\n[02:21.00] Từ giờ anh sẽ xóa đi hết kỷ niệm\n[02:24.80] Anh sẽ quên hết thứ anh đã tin\n[02:29.00] Chẳng để sót lại gì làm anh lưu luyến\n[02:35.80] Anh chẳng còn sức để ôm vào lòng\n[02:40.00] Hãy để mọi thứ trôi đi theo dòng\n[02:44.50] Và cứ xem như chuyện mình chỉ là giấc mơ\n[02:51.80] Anh từng ước thời gian ngưng đọng\n[02:55.80] Để được ôm em vào mãi trong lòng\n[02:59.80] Giờ mọi thứ như hóa vô vọng\n[03:03.80] Anh phải làm sao để qua cơn giông?\n[03:07.80] Từng lời em nói còn vang bên tai\n[03:11.80] Dù anh đã cố để chẳng nhớ lại\n[03:15.80] Từ giờ ta chấm dứt chia hai\n[03:19.19] Hãy quên giấc mơ yêu mãi không phai	2026-10-18 04:11:02.147	2026-10-18 04:13:33.218
9	8	20	CUSTOM	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...	2026-10-11 11:34:34.227	2026-10-11 12:24:39.545
10	8	19	CUSTOM	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...	2026-10-11 11:28:21.352	2026-10-11 12:31:14.697
11	8	46	CUSTOM	[00:00.00] [Verse 1]\n[00:10.00] Anh thường hay thức khuya\n[00:11.00] Nghĩ về thứ anh vẫn luôn mong đợi\n[00:14.00] Rằng phải làm sao?\n[00:15.00] Cũng chẳng biết đến bao giờ?\n[00:20.00] Những lời ca dở dang\n[00:21.00] Anh ngồi viết mãi vẫn còn chưa xong\n[00:24.00] Chạy theo đằng sau ánh sáng\n[00:27.00] Cuối nơi chân trời.\n[00:29.00] Rồi em đến đây dịu dàng cạnh bên anh\n[00:33.00] Cơn mưa rơi trở nên long lanh\n[00:35.00] Chẳng còn đợi trông\n[00:37.00] Vì giấc mơ có em thêm màu xanh\n[00:40.00] Thật lòng chẳng xa xôi\n[00:43.00] Ước muốn anh ở ngay đây thôi\n[00:45.00] Anh không bận tâm nữa\n[00:47.00] Vì anh có em.\n[00:50.00] Nếu như ngày mai không diễn ra\n[00:52.00] Giống cách mà anh cứ luôn mơ mộng?\n[00:55.00] Thì vẫn có một người luôn phía sau\n[00:58.00] Nhẹ nắm tay anh\n[01:00.00] Biết còn nhiều điều lo lắng đang vây quanh\n[01:03.00] Dặn lòng phải xứng đáng hơn\n[01:05.00] Để anh trở thành chàng trai\n[01:07.00] Top 1 trong mắt em.\n[01:13.00] Phải tự thân vượt lên, anh vốn không thích hai chữ đáng thương\n[01:15.00] Nhiều người nói là không được đâu nhưng anh vẫn cứ ngang ngược\n[01:17.00] Bởi vì sâu ở trong đầu anh toàn chứa những thứ hoang đường\n[01:19.00] Và từ hồi bé anh đã mơ ước được hát như chú Đan Trường\n[01:21.00] Bầu trời đêm okay cho nên không sao\n[01:23.00] Có đứa nhóc ôm đàn ngân nga những câu yêu đời\n[01:26.00] Dù cho phải gặp bao nhiêu gian khó\n[01:28.00] Vẫn luôn là em dõi theo anh\n[01:31.00] Dù anh đi đến đâu...\n[01:45.00] Nếu như ngày mai không diễn ra\n[01:47.00] Giống cách mà anh cứ luôn mơ mộng?\n[01:50.00] Thì vẫn có một người luôn phía sau\n[01:53.00] Nhẹ nắm tay anh\n[01:55.00] Biết còn nhiều điều lo lắng đang vây quanh\n[01:58.00] Dặn lòng phải xứng đáng hơn\n[02:00.00] Để anh trở thành chàng trai\n[02:02.00] Top 1 trong mắt em.\n[02:08.00] Những cơ hội vụt qua đôi tay\n[02:11.00] Vậy chắc chưa phải là ngày hôm nay\n[02:14.00] Thì cứ tiếp tục để chạy theo tiếng gọi\n[02:17.00] Từng câu nói mà anh vẫn luôn tin vào.\n[02:20.00] Có những lần đôi mắt anh lạc phương hướng\n[02:23.00] Để rồi đêm tối anh không về nhà\n[02:26.00] Thì vẫn luôn là em\n[02:28.00] Ngọn đèn rực rỡ chiếu soi nơi anh...\n[02:30.00] Nếu như ngày mai không diễn ra\n[02:32.00] Giống cách mà anh cứ luôn mơ mộng\n[02:35.00] Thì vẫn có một người luôn phía sau nhẹ nắm tay anh\n[02:40.00] Biết còn nhiều điều lo lắng đang vây quanh\n[02:43.00] Dặn lòng phải xứng đáng hơn\n[02:45.00] Để anh trở thành chàng trai\n[02:48.00] Top 1 trong mắt em...\n[02:53.00] Top 1 trong mắt em.\n[Chorus]\n[Verse 2]\n[Chorus]\n[Bridge]\n[Chorus & Outro]	2026-10-18 03:27:17.708	2026-10-18 04:15:47.504
12	8	45	CUSTOM	[00:02.00] Còn cần thiết nữa, nói chi đến đây cũng thừa\n[00:04.00] Giờ chỉ còn mình với vấn vương (Rượu vang pha với cơn mưa)\n[00:07.00] Hàng trăm lý do cũng chẳng thể cứu vãn\n[00:09.00] Biết sao hết cho vừa?\n[00:11.00] Lòng nhau mới thấu đây em\n[00:13.00] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\n[00:17.00] Rượu vang pha với cơn mưa\n[00:20.00] Hàng trăm lý do cũng chẳng thể cứu vãn\n[00:22.00] Biết sao hết cho vừa? Lòng nhau mới thấu đây em\n[00:26.00] Dệt hàng triệu vết thương, tự vùi mình trước gương\n[00:30.00] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\n[00:33.00] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\n[00:37.00] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\n[00:41.00] Ta chia tay, vì sao em ơi?\n[00:44.00] Điều này anh muốn hỏi lâu rồi\n[00:47.00] Những khung trời kỷ niệm vỡ đôi\n[00:50.00] Có phải vì một câu anh đã lỡ lời?\n[00:54.00] Sau đêm nay, tự ta cho ta\n[00:57.00] Em và anh một đoạn kết mới\n[01:00.00] Dù rằng mình còn yêu nhau rất nhiều đấy\n[01:04.00] Nhưng để ở lại thì anh nghĩ là không\n[01:06.00] Và sau những cảm xúc nhất thời\n[01:10.00] Người bên em giờ này chẳng còn là anh\n[01:13.00] Gửi lại quá khứ cung đàn đã vỡ\n[01:17.00] Vì những vấn vương ấy chưa kịp thành lời\n[01:19.00] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\n[01:23.00] Rượu vang pha với cơn mưa\n[01:26.00] Hàng trăm lý do cũng chẳng thể cứu vãn\n[01:28.00] Biết sao hết cho vừa? Lòng nhau mới thấu đây em\n[01:33.00] Dệt hàng triệu vết thương, tự vùi mình trước gương\n[01:36.00] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\n[01:39.00] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\n[01:43.00] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\n[01:46.00] Tất cả là tại vì em, em, em, em, em, e-em\n[01:50.00] Người xa lạ anh từng quen\n[01:53.00] Tất cả là tại vì em, em, em, em, em, e-em\n[01:57.00] Kẻ ngốc đang say tình dưới ngọn đèn\n[01:59.00] Tất cả là tại vì em, em, em, em, em, e-em\n[02:03.00] Người xa lạ anh từng quen\n[02:06.00] Tất cả là tại vì em, em, em, em, em, yeah-eh-eh\n[02:10.00] Kẻ ngốc đang say tình dưới ngọn đèn\n[02:13.00] Lau đôi mi, đây là nước mắt hay mưa\n[02:15.00] Buông đôi tay, anh đâu muốn phải dây dưa\n[02:17.00] Quên đi đôi mắt ấy khi xưa, chẳng bên nhau được nữa\n[02:20.00] Sau bao lần đau, anh lại cho đi và quên\n[02:22.00] Anh ghét nỗi đau, cơn mưa đêm kia và em\n[02:24.00] Ta vội quên rồi, những điều sao thật quen\n[02:27.00] Để nỗi buồn kia gọi tên mỗi khi bài ca bật lên\n[02:28.00] Và sau những cảm xúc nhất thời\n[02:30.00] Người bên em giờ này chẳng còn là anh\n[02:33.00] Gửi lại quá khứ cung đàn đã vỡ\n[02:37.00] Vì những vấn vương ấy chưa kịp thành lời\n[02:39.00] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\n[02:43.00] Rượu vang pha với cơn mưa\n[02:45.00] Hàng trăm lý do cũng chẳng thể cứu vãn\n[02:48.00] Biết sao hết cho vừa lòng nhau mới thấu đây em?\n[02:52.00] Dệt hàng triệu vết thương, tự vùi mình trước gương\n[02:56.00] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\n[03:03.00] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\n[03:07.00] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\n[03:11.00] Tất cả là tại vì em...\n[03:15.00] Người xa lạ anh từng quen...\n[03:19.00] Tất cả là tại vì em...\n[Chorus: CAPTAIN BOY & CoolKid]\n[Verse 1: Pháp Kiều & CAPTAIN BOY]\n[Pre-Chorus: Quang Hùng MasterD]\n[Chorus: Quang Hùng MasterD & CAPTAIN BOY]\n[Post-Chorus: Quang Hùng MasterD & CoolKid]\n[Verse 2: Pháp Kiều]\n[Pre-Chorus: CoolKid & Quang Hùng MasterD]\n[Chorus: Cả nhóm]\n[Outro]	2026-10-18 03:27:12.163	2026-10-18 03:32:22.53
13	9	56	CUSTOM	[00:21.57] Nơi anh bao năm không có nắng\n[00:24.28] Và mưa giăng nơi em đôi khi cũng chưa từng muốn ngừng\n[00:27.00] Mà đi bao xa ta vẫn thấy ngắn\n[00:29.19] Vì nơi đâu cũng là nhà\n[00:32.46] Anh băng qua bao la con sóng trắng\n[00:35.13] Niềm tin mong manh cũng chỉ biết giăng buồm thật căng\n[00:37.75] Để mà lênh đênh trôi mang theo bao cố gắng\n[00:40.10] Dù mưa gió có lỡ xô anh đi xa bến bờ\n[00:43.03] Vì ngày đó anh chẳng cần biết điều gì đến\n[00:46.95] Cũng chẳng thể viết vội đoạn kết\n[00:49.67] Khi còn chưa đi hết những xước chai, những đúng sai\n[00:53.96] Và ngoài đó hoang tàn giằng xé\n[00:56.64] Thì ở đây vẫn có điều nhỏ bé\n[00:59.46] Mà lặng lẽ vun xây những mơ mộng này\n[01:02.25] Để hôm nay khi đứng đây, em chính là điều nhỏ bé ở bên bờ\n[01:05.62] (<I'm in love, I'm in love, in love with you>) ooh, my love\n[01:08.42] (<I'm in love, I'm in love, in love with you>) nơi ấy em chờ\n[01:11.15] (<I'm in love, I'm in love, in love with you>) ở bên bờ, ở bên bờ cùng mong nhớ\n[01:16.64] (<I'm in love, I'm in love, in love with you>) ooh, my love\n[01:19.37] (<I'm in love, I'm in love, in love with you>) nơi ấy em chờ\n[01:22.06] (<I'm in love, I'm in love, in love with you>)\n[01:24.28] Em vẫn luôn rạng rỡ, gom từng thương nhớ nơi bến bờ\n[01:27.51] Yeah, nhiều cô gái không hiểu được anh\n[01:29.78] Và có nhiều mối quan hệ ngày xưa cũng tự kết thúc vì nó\n[01:32.72] Anh là kiểu người mà nếu muốn đùa cợt thì nhanh\n[01:35.28] Nhưng để ngồi xuống nói chuyện mở lòng thực sự thì khó\n[01:37.45] Chắc là anh không giỏi chuyện đó, anh vô thức giấu hết đi\n[01:40.31] Anh vô thức giấu hết đi vào trong hố đen những luồng suy nghĩ\n[01:43.17] Và em là người đầu tiên dạy anh nghĩ gì phải nói ra\n[01:45.87] Nhưng nhiều lúc nói tự nhiên cổ họng của anh bị nghẹn và\n[01:48.25] Não không nghĩ được gì cả, cảm giác đấy khá kì lạ\n[01:51.06] Cảm giác như không sắp xếp được đúng suy nghĩ để cho mình tả\n[01:53.75] Lớn lên anh nhận ra mở lòng là kĩ năng\n[01:56.15] Anh nghĩ EQ anh chưa cao và anh chưa thực sự chín chắn, ah\n[01:59.25] Đôi nào chả có cãi vã khi căng thẳng tăng dần lên\n[02:01.92] Sẽ có những chủ đề thực sự nhạy cảm nếu như đề cập đến\n[02:04.68] Nhưng cho đến cuối em vẫn bình tĩnh nghe anh (nghe)\n[02:07.43] Nói với anh rằng nếu từ đầu anh cho em biết thì mưa giông trong đầu anh sẽ tạnh thôi\n[02:11.46] Ngày trôi, đầu anh trở nên thảnh thơi\n[02:13.62] Anh thấy hạnh phúc khi ở cùng em nhìn mưa bên ngoài rơi\n[02:16.49] Anh chưa bao giờ cảm thấy an toàn và yên tâm như thế\n[02:19.12] Và mình có thể nói chuyện hàng giờ về chỉ một chủ đề\n[02:22.12] You're the only girl showing me the way to love\n[02:24.62] Only one I trust, ain't afraid to tell the world\n[02:27.50] Many things to learn, anh không cần gì hơn\n[02:29.57] Ngoài thấy em ở bên cạnh anh khi anh mở mắt dậy vào sáng sớm, ah\n[02:32.06] Ooh, my love (I'm in love, I'm in love, in love with you)\n[02:34.62] Ooh, my love (yeah) (I'm in love, I'm in love, in love with you)\n[02:37.32] Nơi ấy em chờ (I'm in love, I'm in love, in love with you) (this song's for you)\n[02:40.21] Ở bên bờ, ở bên bờ cùng mong nhớ (ah, ah, ah, ah)\n[02:43.81] (<I'm in love, I'm in love, in love with you>) ooh, my love\n[02:46.59] (<I'm in love, I'm in love, in love with you>) nơi ấy em chờ\n[02:49.21] (<I'm in love, I'm in love, in love with you>) yeah\n[02:51.43] Em vẫn luôn rạng rỡ, gom từng thương nhớ nơi bến bờ (yeah, yeah, yeah, yeah)\n[02:54.65] (<I'm in love, I'm in love, in love with you>) I'm in love with you\n[02:57.65] (<I'm in love, I'm in love>) in love with you, in love (I'm in love, I'm in love, in love with you)\n[03:00.21] (<I'm in love, I'm in love, in love with you>) I'm in love with you (hah)\n[03:04.52] My love ở bên bờ (Low G) (I'm in love, I'm in love, in love with you)\n[03:06.78] Bên bờ có em chờ (and JustaTee) (I'm in love, I'm in love, in love with you)\n[03:09.18] Ooh-ooh-ooh (2025) (I'm in love, I'm in love, in love with you)\n[03:13.00] I'm in love with you, with you, with you	2026-10-18 18:45:19.44	2026-10-24 03:46:23.253
14	8	63	CUSTOM	[ti:Top 1 (Trong Mắt Em)]\r\n[ar:buitruonglinh]\r\n[al:Top 1 (Trong Mắt Em)]\r\n[by:Antigravity]\r\n\r\n[00:00.00]Top 1 (Trong Mắt Em) - buitruonglinh\r\n[00:08.50]...\r\n[00:10.25]Anh thường hay thức khuya\r\n[00:11.80]Nghĩ về thứ anh vẫn luôn mong đợi\r\n[00:14.65]Rằng phải làm sao?\r\n[00:15.88]Cũng chẳng biết đến bao giờ?\r\n[00:20.30]Những lời ca dở dang\r\n[00:21.91]Anh ngồi viết mãi vẫn còn chưa xong\r\n[00:24.70]Chạy theo đằng sau ánh sáng\r\n[00:27.10]Cuối nơi chân trời\r\n[00:29.49]Rồi em đến đây\r\n[00:30.80]Dịu dàng cạnh bên anh\r\n[00:33.08]Cơn mưa rơi trở nên long lanh\r\n[00:35.47]Chẳng còn đợi trông\r\n[00:37.48]Vì giấc mơ có em thêm màu xanh\r\n[00:40.27]Thật lòng chẳng xa xôi\r\n[00:43.08]Ước muốn anh ở ngay đây thôi\r\n[00:45.85]Anh không bận tâm nữa\r\n[00:47.46]Vì anh có em\r\n[00:50.43]Nếu như ngày mai không diễn ra\r\n[00:52.81]Giống cách mà anh cứ luôn mơ mộng?\r\n[00:55.60]Thì vẫn có một người luôn phía sau\r\n[00:58.01]Nhẹ nắm tay anh\r\n[01:00.41]Biết còn nhiều điều lo lắng đang vây quanh\r\n[01:03.99]Dặn lòng phải xứng đáng hơn\r\n[01:05.98]Để anh trở thành chàng trai\r\n[01:07.59]Top 1 trong mắt em\r\n[01:11.35]Phải tự thân vượt lên, anh vốn không thích hai chữ đáng thương\r\n[01:14.07]Nhiều người nói là không được đâu nhưng anh vẫn cứ ngang ngược\r\n[01:16.47]Bởi vì sâu ở trong đầu anh toàn chứa những thứ hoang đường\r\n[01:19.08]Và từ hồi bé anh đã mơ ước được hát như chú Đan Trường\r\n[01:21.75]Bầu trời đêm okay cho nên không sao\r\n[01:23.88]Có đứa nhóc ôm đàn ngân nga những câu yêu đời\r\n[01:26.55]Dù cho phải gặp bao nhiêu gian khó\r\n[01:27.80]Vẫn luôn là em dõi theo anh\r\n[01:29.74]Dù anh đi đến đâu...\r\n[01:31.60]Nếu như ngày mai không diễn ra\r\n[01:33.99]Giống cách mà anh cứ luôn mơ mộng?\r\n[01:36.78]Thì vẫn có một người luôn phía sau\r\n[01:39.17]Nhẹ nắm tay anh\r\n[01:41.59]Biết còn nhiều điều lo lắng đang vây quanh\r\n[01:44.78]Dặn lòng phải xứng đáng hơn\r\n[01:46.80]Để anh trở thành chàng trai\r\n[01:48.50]Top 1 trong mắt em\r\n[01:52.50]Những cơ hội vụt qua đôi tay\r\n[01:55.20]Vậy chắc chưa phải là ngày hôm nay\r\n[01:57.80]Thì cứ tiếp tục để chạy theo tiếng gọi\r\n[01:59.80]Từng câu nói mà anh\r\n[02:00.91]Vẫn luôn tin vào\r\n[02:02.49]Có những lần đôi mắt anh lạc phương hướng\r\n[02:04.90]Để rồi đêm tối anh không về nhà\r\n[02:07.69]Thì vẫn luôn là em\r\n[02:08.87]Ngọn đèn rực rỡ chiếu soi nơi anh...\r\n[02:12.47]Nếu như ngày mai không diễn ra\r\n[02:15.32]Giống cách mà anh cứ luôn mơ mộng?\r\n[02:18.11]Thì vẫn có một người luôn phía sau\r\n[02:20.50]Nhẹ nắm tay anh\r\n[02:22.90]Biết còn nhiều điều lo lắng đang vây quanh\r\n[02:26.50]Dặn lòng phải xứng đáng hơn\r\n[02:28.50]Để anh trở thành chàng trai\r\n[02:30.50]Top 1 trong mắt em...\r\n[02:35.00]Top 1 trong mắt em\r\n[02:40.00]Top 1 trong mắt em...\r\n[02:46.00]...	2026-10-27 09:15:54.625	2026-10-27 09:16:09.449
15	8	22	CUSTOM	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...	2026-10-11 12:40:35.924	2026-10-23 05:45:52.741
16	8	21	CUSTOM	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...	2026-10-11 12:29:20.299	2026-10-23 05:26:05.087
17	8	23	CUSTOM	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...	2026-10-11 12:42:57.053	2026-10-23 05:44:15.242
18	19	15	CUSTOM	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...	2026-10-10 04:18:11.421	2026-10-10 04:19:55.926
\.


--
-- Data for Name: playlist_tracks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.playlist_tracks (playlist_id, track_id, added_by_user_id, "position", added_at, id) FROM stdin;
16	50	9	5	2026-10-18 04:16:06.55	77
6	16	3	3	2026-10-10 08:16:09.121	19
6	12	3	4	2026-10-10 08:16:09.918	21
6	13	3	5	2026-10-10 08:16:14.269	22
6	11	3	6	2026-10-10 08:16:16.278	23
6	10	3	7	2026-10-10 08:16:18.011	24
6	6	3	8	2026-10-10 08:16:20.136	25
17	16	9	7	2026-10-18 03:11:16.523	65
7	15	6	1	2026-10-10 07:16:15.026	12
7	11	6	2	2026-10-10 07:16:21.166	13
7	9	6	3	2026-10-10 07:16:22.136	14
7	7	6	4	2026-10-10 07:16:23.653	15
7	12	6	5	2026-10-10 07:16:25.011	16
6	8	3	1	2026-10-10 07:22:37.245	18
6	15	3	2	2026-10-10 07:22:33.314	17
11	10	21	1	2026-10-13 15:04:04.013	32
11	8	21	2	2026-10-13 15:04:04.013	33
11	9	21	3	2026-10-13 15:04:04.013	34
12	7	22	1	2026-10-13 15:04:04.013	35
12	6	22	2	2026-10-13 15:04:04.013	36
12	15	22	3	2026-10-13 15:04:04.013	37
13	13	23	1	2026-10-13 15:04:04.013	38
13	11	23	2	2026-10-13 15:04:04.013	39
13	12	23	3	2026-10-13 15:04:04.013	40
13	26	23	4	2026-10-13 15:04:04.013	41
14	8	24	2	2026-10-13 15:04:04.013	43
14	9	24	3	2026-10-13 15:04:04.013	44
15	10	25	1	2026-10-13 15:04:04.013	46
15	7	25	2	2026-10-13 15:04:04.013	47
15	13	25	3	2026-10-13 15:04:04.013	48
15	6	25	4	2026-10-13 15:04:04.013	49
15	11	25	5	2026-10-13 15:04:04.013	50
16	38	9	1	2026-10-15 14:57:04.928	51
16	36	9	2	2026-10-15 14:57:05.411	52
16	34	9	3	2026-10-15 14:57:06.437	53
17	38	9	1	2026-10-18 01:51:18.482	54
17	36	9	2	2026-10-18 01:51:19.454	55
17	33	9	5	2026-10-18 01:51:40.422	59
17	15	9	8	2026-10-18 03:11:23.341	67
17	34	9	3	2026-10-18 01:51:28.704	56
17	26	9	4	2026-10-18 01:51:29.7	58
17	8	9	6	2026-10-18 02:46:45.504	62
16	26	9	4	2026-10-18 02:48:47.212	64
17	11	9	9	2026-10-18 03:11:24.738	70
17	13	9	10	2026-10-18 03:11:26.848	71
17	12	9	11	2026-10-18 03:11:32.797	72
17	10	9	12	2026-10-18 03:11:36.234	73
17	9	9	13	2026-10-18 03:11:42.028	75
\.


--
-- Data for Name: playlists; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.playlists (id, owner_user_id, name, description, visibility, cover_public_id, cover_url, created_at, updated_at, created_by_user_id, is_private, slug, title) FROM stdin;
7	6	Mèo Béo	Béo béo	PRIVATE	\N	data:image/svg+xml;charset=UTF-8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20600%20600%22%3E%0A%20%20%20%20%3Cdefs%3E%3ClinearGradient%20id%3D%22g%22%20x1%3D%220%22%20y1%3D%220%22%20x2%3D%221%22%20y2%3D%221%22%3E%3Cstop%20stop-color%3D%22%230e7490%22%2F%3E%3Cstop%20offset%3D%221%22%20stop-color%3D%22%23d4a373%22%2F%3E%3C%2FlinearGradient%3E%3C%2Fdefs%3E%0A%20%20%20%20%3Crect%20width%3D%22600%22%20height%3D%22600%22%20rx%3D%2232%22%20fill%3D%22url(%23g)%22%2F%3E%0A%20%20%20%20%3Cpath%20d%3D%22M-30%20380C100%20210%20170%20530%20315%20315S520%20120%20660%20268%22%20fill%3D%22none%22%20stroke%3D%22%2367e8f9%22%20stroke-width%3D%2280%22%20stroke-linecap%3D%22round%22%20opacity%3D%22.8%22%2F%3E%0A%20%20%20%20%3Ctext%20x%3D%2242%22%20y%3D%22535%22%20fill%3D%22white%22%20font-family%3D%22Arial%2Csans-serif%22%20font-weight%3D%22700%22%20font-size%3D%2238%22%3ES%E1%BB%9AM%20MAI%3C%2Ftext%3E%0A%20%20%3C%2Fsvg%3E	2026-10-10 07:16:00.446	2026-10-10 07:16:25.788	6	t	meo-beo	Mèo Béo
13	23	Anime Soundtracks & J-Pop Hits	Collection of iconic themes from Evangelion, Frieren, and Makoto Shinkai works.	PRIVATE	cover-playlist-13.webp	/api/media/cover/cover-playlist-13.webp	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	23	f	anime-soundtracks-jpop-hits	Anime Soundtracks & J-Pop Hits
15	25	SoundWave Hot Trends Daily	Những giai điệu đang thịnh hành và được yêu thích nhất trên SoundWave.	PRIVATE	cover-playlist-15.webp	/api/media/cover/cover-playlist-15.webp	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	25	f	soundwave-hot-trends-daily	SoundWave Hot Trends Daily
14	24	Acoustic & Late Night Chill	Âm nhạc mộc mạc thư giãn đêm khuya cho tâm hồn thư thái.	PRIVATE	cover-playlist-14.jpg	/api/media/cover/cover-playlist-14.jpg	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	24	f	acoustic-late-night-chill	Acoustic & Late Night Chill
6	3	tổng hợp	dau	PRIVATE	cover-playlist-6.jpg	/api/media/cover/cover-playlist-6.jpg	2026-10-09 20:11:36.313	2026-10-10 08:17:30.502	3	t	tong-hop	tổng hợp
11	21	Giai Điệu V-Pop Ngọt Ngào	Tuyển tập những bản ballad và pop Việt Nam da diết, tình cảm nhất.	PRIVATE	cover-playlist-11.webp	/api/media/cover/cover-playlist-11.webp	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	21	f	giai-dieu-vpop-ngot-ngao	Giai Điệu V-Pop Ngọt Ngào
12	22	Vibe Rap Việt Cực Cháy	List nhạc rap khởi động ngày mới tràn đầy năng lượng cùng HIEUTHUHAI, MCK, Low G.	PRIVATE	cover-playlist-12.webp	/api/media/cover/cover-playlist-12.webp	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	22	f	vibe-rap-viet-cuc-chay	Vibe Rap Việt Cực Cháy
17	9	Ngọt		PRIVATE	cover-playlist-17.jpg	/api/media/cover/cover-playlist-17.jpg	2026-10-18 01:50:58.531	2026-10-18 03:11:44.125	9	t	ngot-1	Ngọt
16	9	Nhạc của Tuấn		PRIVATE	cover-playlist-16.jpg	/api/media/cover/cover-playlist-16.jpg	2026-10-15 14:56:58.077	2026-10-18 04:29:59.619	9	t	nhac-cua-tuan	Nhạc của Tuấn
4	3	Ngọt		PRIVATE	cover-playlist-4.jpg	/api/media/cover/cover-playlist-4.jpg	2026-10-09 19:42:24.862	2026-10-09 19:42:24.862	3	t	ngot	Ngọt
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.refresh_tokens (id, user_id, token_hash, expires_at, revoked_at, created_at, staff_id) FROM stdin;
1526	4	2d51dcf89864ba5ccc8dee8a449f239e7706f796aabd02f39e096282916d25e4	2026-11-18 07:44:37.849	\N	2026-11-11 07:44:37.849	\N
1527	4	3b99227ae70734ffaaf6e1328e538a482e9c803fcbc092bb56a1dab38bf53164	2026-11-18 07:44:47.196	\N	2026-11-11 07:44:47.196	\N
1528	5	665ac52d9a5de46bb18be37b75feb17f4d397c3b79b4da12e61dbf51d2b8eea7	2026-11-18 07:51:32.441	\N	2026-11-11 07:51:32.441	\N
1529	5	cec1d339fb0563c4d4391c371ebc4d8479ff8f935d444310acb4bb957af3c5af	2026-11-18 07:51:55.603	\N	2026-11-11 07:51:55.603	\N
1530	5	fd8a308bcf3ac3367c3e21a244a8c94141dc17f7da1ad6bc49b50b150be2e0bc	2026-11-18 07:57:28.056	\N	2026-11-11 07:57:28.056	\N
1531	5	9d92ed8074af7766f8adc6c5b26e9c17c3ab47ce86c55ea268aad56b91b01741	2026-11-18 08:12:01.221	\N	2026-11-11 08:12:01.221	\N
1532	3	194b48b91e7db28de96d515239e40d422403cdc0909d2e0cfafa783a710d5c2f	2026-12-11 08:16:45.41	2026-11-11 08:21:29.259	2026-11-11 08:16:45.41	\N
1533	4	3b4ce1367dedfc14d380cd5461fcfacbcdd57d1672fc11c64758c06557eee7ff	2026-12-11 08:21:44.794	2026-11-11 08:24:07.489	2026-11-11 08:21:44.794	\N
1535	4	c2054159a1ee83296b061817da32c90d0df629863e51750975cac690d7c3ebca	2026-11-18 08:34:14.131	\N	2026-11-11 08:34:14.131	\N
1536	4	cd12e01a42caef8699e4ffa533fa3c3679530ddb49c75591b6bb82b3983fd1cd	2026-11-18 08:39:33.61	\N	2026-11-11 08:39:33.61	\N
1534	4	09fdb4c96ed799e8bdb4a919cb9a2c447d1b54d772fbeab574015a9c2aa600f7	2026-12-11 08:30:08.455	2026-11-11 08:45:00.039	2026-11-11 08:30:08.455	\N
1537	4	8f41256fdd4b5bbaecce5353e57c8f8aab58c7d3ca0c1848b4af212ac5e33560	2026-11-18 08:45:00.041	2026-11-11 08:58:25.428	2026-11-11 08:45:00.041	\N
1539	3	94a10a7875923f9ff4c5f9b81fb2b58d2b203b97242a21ada5bf86759772f3ce	2026-11-18 08:58:58.954	\N	2026-11-11 08:58:58.954	\N
1538	3	8c2c64afcc1b7380cb6d5fe150951e473667cbcc52f5372881d16e9347fd8349	2026-12-11 08:58:34.026	2026-11-11 08:58:58.954	2026-11-11 08:58:34.026	\N
1540	5	a2a5e13a9c3a14d5199a5077ecf9630c9128bbf9413252bd658e7cae05e46935	2026-12-11 08:59:02.495	\N	2026-11-11 08:59:02.495	\N
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (id, code, created_at, description, name) FROM stdin;
7	LISTENER	2026-11-05 07:58:13.238301	Standard SoundWave listener account	Listener
8	STAFF	2026-11-05 07:58:13.34751	Content moderation account	Staff
9	ADMIN	2026-11-05 07:58:13.421311	System administration account	Administrator
\.


--
-- Data for Name: staff_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.staff_roles (id, code, name, description, created_at) FROM stdin;
1	ADMIN	Administrator	Quản trị viên toàn quyền hệ thống SoundWave	2026-10-22 13:50:18.34
2	STAFF	Staff	Nhân viên vận hành và kiểm duyệt nội dung SoundWave	2026-10-22 13:50:18.34
\.


--
-- Data for Name: staffs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.staffs (id, role_id, email, password_hash, full_name, avatar_url, status, last_login_at, created_at, updated_at) FROM stdin;
1	1	admin@soundwave.com	$2a$10$6pPSoWtZk1dZa5jbp3k81.UpH42XtWRWDlnPro9mf7XvY9732If8m	System Administrator	\N	ACTIVE	2026-10-31 01:27:52.753	2026-10-09 05:32:20.233	2026-10-31 01:27:52.871
2	2	staff@soundwave.com	$2a$10$meEHWfdR3hK5/q3.MHwii.lEyMjY/Z9gkKnXBouMa4jMigSkye.yS	Content Moderator	\N	ACTIVE	2026-10-31 02:36:23.8	2026-10-09 05:32:20.505	2026-10-31 02:36:23.995
\.


--
-- Data for Name: system_reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.system_reviews (id, user_id, rating, comment, status, created_at, updated_at) FROM stdin;
1	21	5	Giao diện web màu xanh dương và cát ấm nhìn rất dịu mắt, chất lượng âm thanh bài hát nghe cực kỳ mượt mà!	ACKNOWLEDGED	2026-10-12 15:04:04.013	2026-10-13 15:04:04.013
2	22	5	Nhiều bài rap chất lượng, trình phát nhạc có hàng đợi rất tiện lợi. Chúc SoundWave ngày càng phát triển!	ACKNOWLEDGED	2026-10-11 15:04:04.013	2026-10-13 15:04:04.013
3	23	5	Tuyệt vời, có cả nhạc anime chất lượng cao lẫn nhạc Việt!	ACKNOWLEDGED	2026-10-10 15:04:04.013	2026-10-13 15:04:04.013
4	24	5	Giao diện tối giản, nghe nhạc thư giãn buổi tối rất thích.	ACKNOWLEDGED	2026-10-09 15:04:04.013	2026-10-13 15:04:04.013
5	25	5	Trải nghiệm nghe nhạc liền mạch, tìm kiếm bài hát theo thể loại rất nhanh chóng!	ACKNOWLEDGED	2026-10-08 15:04:04.013	2026-10-13 15:04:04.013
\.


--
-- Data for Name: track_submissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.track_submissions (id, track_id, submitted_by_user_id, reviewer_user_id, status, submitter_note, reviewer_note, rejection_reason, submitted_at, reviewed_at) FROM stdin;
71	17	3	5	APPROVED	\N	\N	\N	2026-11-11 15:58:47.696	2026-11-11 15:59:08.156
68	67	8	\N	PENDING	Album submission: MRT	\N	\N	2026-10-31 09:43:06.284	\N
69	68	8	\N	PENDING	Album submission: MRT	\N	\N	2026-10-31 09:43:06.448	\N
70	69	8	\N	PENDING	Album submission: MRT	\N	\N	2026-10-31 09:43:06.53	\N
60	56	9	21	APPROVED	\N	\N	\N	2026-10-24 10:45:47.849	2026-10-24 10:46:17.124
62	44	9	21	APPROVED	\N	\N	\N	2026-10-24 17:02:51.85	2026-10-24 17:03:07.317
63	61	9	21	APPROVED	\N	\N	\N	2026-10-24 17:19:46.026	2026-10-24 17:20:19.543
6	16	3	21	APPROVED	\N	good music hay nha	\N	2026-10-10 15:05:42.484	2026-10-10 15:06:11.632
7	17	3	21	REJECTED	\N	\N	Audio clipping or severe distortion detected in master stream.	2026-10-10 15:08:50.236	2026-10-10 15:09:04.685
10	20	8	21	REJECTED	\N	\N	Audio file corrupted or encoding does not meet platform standards.	2026-10-11 18:34:34.817	2026-10-11 19:24:34.02
9	19	8	21	REJECTED	\N	\N	Unlicensed sample, beat, or suspected copyright infringement.	2026-10-11 18:28:22.042	2026-10-11 19:31:09.626
4	14	19	21	REJECTED	\N	\N	Incomplete or placeholder metadata (title, artist or artwork).	2026-10-10 10:34:38.919	2026-10-10 11:19:20.404
5	15	19	21	APPROVED	\N	Good Music	\N	2026-10-10 11:18:11.891	2026-10-10 11:19:50.896
16	26	18	21	APPROVED	\N	\N	\N	2026-10-13 12:54:56.462	2026-10-13 13:19:18.747
18	11	16	21	APPROVED	Yêu cầu kiểm duyệt và phát hành bản thu chính thức trên SoundWave.	Đã thẩm định: Chất lượng âm thanh đạt chuẩn, metadata và bản quyền hợp lệ.	\N	2026-10-09 10:04:58.459	2026-10-09 10:04:58.459
29	34	9	21	APPROVED	\N	\N	\N	2026-10-15 19:58:32.912	2026-10-15 19:59:34.745
64	63	8	5	APPROVED	\N	\N	\N	2026-10-27 16:16:09.059	2026-11-11 14:57:28.115
19	12	17	21	APPROVED	Yêu cầu kiểm duyệt và phát hành bản thu chính thức trên SoundWave.	Đã thẩm định: Chất lượng âm thanh đạt chuẩn, metadata và bản quyền hợp lệ.	\N	2026-10-09 10:05:23.504	2026-10-09 10:05:23.504
20	10	10	21	APPROVED	Yêu cầu kiểm duyệt và phát hành bản thu chính thức trên SoundWave.	Đã thẩm định: Chất lượng âm thanh đạt chuẩn, metadata và bản quyền hợp lệ.	\N	2026-10-09 10:03:23.723	2026-10-09 10:03:23.723
21	13	15	21	APPROVED	Yêu cầu kiểm duyệt và phát hành bản thu chính thức trên SoundWave.	Đã thẩm định: Chất lượng âm thanh đạt chuẩn, metadata và bản quyền hợp lệ.	\N	2026-10-09 10:06:00.496	2026-10-09 10:06:00.496
22	8	13	21	APPROVED	Yêu cầu kiểm duyệt và phát hành bản thu chính thức trên SoundWave.	Đã thẩm định: Chất lượng âm thanh đạt chuẩn, metadata và bản quyền hợp lệ.	\N	2026-10-09 10:02:36.028	2026-10-09 10:02:36.028
23	6	12	21	APPROVED	Yêu cầu kiểm duyệt và phát hành bản thu chính thức trên SoundWave.	Đã thẩm định: Chất lượng âm thanh đạt chuẩn, metadata và bản quyền hợp lệ.	\N	2026-10-09 10:01:54.581	2026-10-09 10:01:54.581
26	9	14	21	APPROVED	Yêu cầu kiểm duyệt và phát hành bản thu chính thức trên SoundWave.	Đã thẩm định: Chất lượng âm thanh đạt chuẩn, metadata và bản quyền hợp lệ.	\N	2026-10-09 10:03:04.748	2026-10-09 10:03:04.748
27	7	11	21	APPROVED	Yêu cầu kiểm duyệt và phát hành bản thu chính thức trên SoundWave.	Đã thẩm định: Chất lượng âm thanh đạt chuẩn, metadata và bản quyền hợp lệ.	\N	2026-10-09 10:02:15.314	2026-10-09 10:02:15.314
28	33	7	21	APPROVED	Album submission: HVL	\N	\N	2026-10-15 16:23:42.457	2026-10-15 21:28:26.196
31	36	9	21	APPROVED	\N	\N	\N	2026-10-15 21:41:31.348	2026-10-15 21:42:42.255
33	38	9	21	REJECTED	\N	\N	test notification	2026-10-15 21:52:45.848	2026-10-15 21:53:20.097
34	38	9	21	APPROVED	\N	\N	\N	2026-10-15 21:54:23.039	2026-10-15 21:54:44
43	45	8	21	APPROVED	Album submission: TINHHA	\N	\N	2026-10-18 10:27:12.31	2026-10-18 10:32:16.177
45	47	8	21	APPROVED	Album submission: ANHTRAISAYHI	\N	\N	2026-10-18 11:07:58.6	2026-10-18 11:08:58.693
49	50	9	21	APPROVED	\N	\N	\N	2026-10-18 11:12:15.965	2026-10-18 11:13:26.372
44	46	8	21	APPROVED	Album submission: TINHHA	\N	\N	2026-10-18 10:27:17.757	2026-10-18 11:15:40.893
46	48	8	21	REJECTED	Album submission: ANHTRAISAYHI	\N	Audio file corrupted or encoding does not meet platform standards.	2026-10-18 11:08:18.769	2026-10-18 11:16:27.247
47	49	8	21	APPROVED	Album submission: ANHTRAISAYHI	\N	\N	2026-10-18 11:08:25.711	2026-10-18 11:27:37.857
54	56	9	21	APPROVED	\N	\N	\N	2026-10-19 01:45:19.961	2026-10-19 01:46:19.651
55	57	9	21	APPROVED	\N	\N	\N	2026-10-23 10:44:32.671	2026-10-23 10:45:59.614
56	58	7	21	REJECTED	\N	\N	Description kì cục quá	2026-10-23 10:53:54.165	2026-10-23 10:55:26.357
57	58	7	21	APPROVED	\N	\N	\N	2026-10-23 11:00:39.32	2026-10-23 11:01:10.831
11	21	8	21	APPROVED	\N	good music	\N	2026-10-11 19:29:21.028	2026-10-23 12:25:58.116
42	44	9	21	REJECTED	\N	\N	Incomplete or placeholder metadata (title, artist or artwork). These	2026-10-18 10:19:43.541	2026-10-23 12:27:46.676
13	23	8	21	REJECTED	\N	\N	Incomplete or placeholder metadata (title, artist or artwork).	2026-10-11 19:42:57.721	2026-10-23 12:44:08.127
12	22	8	21	REJECTED	\N	\N	Audio file corrupted or encoding does not meet platform standards.	2026-10-11 19:40:36.557	2026-10-23 12:45:52.388
58	59	8	21	APPROVED	\N	Good Music	\N	2026-10-23 13:11:25.186	2026-10-23 13:12:06.227
\.


--
-- Data for Name: tracks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tracks (id, uploader_user_id, album_id, genre_id, title, slug, description, track_number, publication_status, approved_at, latest_rejection_reason, audio_public_id, audio_url, audio_format, duration_ms, cover_public_id, cover_url, play_count_cache, created_at, updated_at, lyrics) FROM stdin;
5	20	\N	1	Bản Nháp Chưa Duyệt (Seed)	seed-draft-song	Bài hát bản nháp dùng để kiểm tra BR-09 từ chối phát.	\N	DRAFT	\N	\N	audio-track-5.mp3	/api/media/stream/audio-track-5.mp3	mp3	45000	cover-track-5.jpg	/api/media/cover/cover-track-5.jpg	0	2026-10-09 07:52:43.18	2026-10-09 07:52:43.18	\N
14	19	\N	6	LAVIEM	laviem-1791628478397	cheerful music	\N	REJECTED	\N	Incomplete or placeholder metadata (title, artist or artwork).	audio-track-14.mp3	/api/media/stream/audio-track-14.mp3	mp3	270620	cover-track-14.png	/api/media/cover/cover-track-14.png	0	2026-10-10 03:34:38.404	2026-10-10 04:19:29.926	\N
33	7	10	3	MẮT MÔI TAY CHÂN	mat-moi-tay-chan-1792081422366-f8b98a	\N	1	PUBLISHED	2026-10-15 14:28:26.196	\N	audio-track-33.mp3	/api/media/stream/audio-track-33.mp3	mp3	221000	cover-track-33.jpg	/api/media/cover/cover-track-33.jpg	0	2026-10-15 09:23:42.367	2026-10-15 14:28:32.6	\N
34	9	\N	2	Ngồi nhìn em khóc	ngoi-nhin-em-khoc-1792094294074	\N	\N	PUBLISHED	2026-10-15 12:59:34.745	\N	audio-track-34.mp3	/api/media/stream/audio-track-34.mp3	mp3	273231	cover-track-34.jpg	/api/media/cover/cover-track-34.jpg	7	2026-10-15 12:58:14.076	2026-10-15 12:59:39.328	\N
47	8	12	5	LAVIEM	laviem-1792321678547-9df166	funny	1	PUBLISHED	2026-10-18 04:08:58.693	\N	audio-track-47.mp3	/api/media/stream/audio-track-47.mp3	mp3	270620	cover-track-47.png	/api/media/cover/cover-track-47.png	1	2026-10-18 04:07:58.548	2026-10-18 04:09:04.695	[00:02] Còn cần thiết nữa, nói chi đến đây cũng thừa\r\n[00:04] Giờ chỉ còn mình với vấn vương (Rượu vang pha với cơn mưa)\r\n[00:07] Hàng trăm lý do cũng chẳng thể cứu vãn\r\n[00:09] Biết sao hết cho vừa?\r\n[00:11] Lòng nhau mới thấu đây em\r\n[Chorus: CAPTAIN BOY & CoolKid]\r\n[00:13] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\r\n[00:17] Rượu vang pha với cơn mưa\r\n[00:20] Hàng trăm lý do cũng chẳng thể cứu vãn\r\n[00:22] Biết sao hết cho vừa? Lòng nhau mới thấu đây em\r\n[00:26] Dệt hàng triệu vết thương, tự vùi mình trước gương\r\n[00:30] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\r\n[00:33] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\n[00:37] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\r\n[Verse 1: Pháp Kiều & CAPTAIN BOY]\r\n[00:41] Ta chia tay, vì sao em ơi?\r\n[00:44] Điều này anh muốn hỏi lâu rồi\r\n[00:47] Những khung trời kỷ niệm vỡ đôi\r\n[00:50] Có phải vì một câu anh đã lỡ lời?\r\n[00:54] Sau đêm nay, tự ta cho ta\r\n[00:57] Em và anh một đoạn kết mới\r\n[01:00] Dù rằng mình còn yêu nhau rất nhiều đấy\r\n[01:04] Nhưng để ở lại thì anh nghĩ là không\r\n[Pre-Chorus: Quang Hùng MasterD]\r\n[01:06] Và sau những cảm xúc nhất thời\r\n[01:10] Người bên em giờ này chẳng còn là anh\r\n[01:13] Gửi lại quá khứ cung đàn đã vỡ\r\n[01:17] Vì những vấn vương ấy chưa kịp thành lời\r\n[Chorus: Quang Hùng MasterD & CAPTAIN BOY]\r\n[01:19] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\r\n[01:23] Rượu vang pha với cơn mưa\r\n[01:26] Hàng trăm lý do cũng chẳng thể cứu vãn\r\n[01:28] Biết sao hết cho vừa? Lòng nhau mới thấu đây em\r\n[01:33] Dệt hàng triệu vết thương, tự vùi mình trước gương\r\n[01:36] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\r\n[01:39] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\n[01:43] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\r\n[Post-Chorus: Quang Hùng MasterD & CoolKid]\r\n[01:46] Tất cả là tại vì em, em, em, em, em, e-em\r\n[01:50] Người xa lạ anh từng quen\r\n[01:53] Tất cả là tại vì em, em, em, em, em, e-em\r\n[01:57] Kẻ ngốc đang say tình dưới ngọn đèn\r\n[01:59] Tất cả là tại vì em, em, em, em, em, e-em\r\n[02:03] Người xa lạ anh từng quen\r\n[02:06] Tất cả là tại vì em, em, em, em, em, yeah-eh-eh\r\n[02:10] Kẻ ngốc đang say tình dưới ngọn đèn\r\n[Verse 2: Pháp Kiều]\r\n[02:13] Lau đôi mi, đây là nước mắt hay mưa\r\n[02:15] Buông đôi tay, anh đâu muốn phải dây dưa\r\n[02:17] Quên đi đôi mắt ấy khi xưa, chẳng bên nhau được nữa\r\n[02:20] Sau bao lần đau, anh lại cho đi và quên\r\n[02:22] Anh ghét nỗi đau, cơn mưa đêm kia và em\r\n[02:24] Ta vội quên rồi, những điều sao thật quen\r\n[02:27] Để nỗi buồn kia gọi tên mỗi khi bài ca bật lên\r\n[Pre-Chorus: CoolKid & Quang Hùng MasterD]\r\n[02:28] Và sau những cảm xúc nhất thời\r\n[02:30] Người bên em giờ này chẳng còn là anh\r\n[02:33] Gửi lại quá khứ cung đàn đã vỡ\r\n[02:37] Vì những vấn vương ấy chưa kịp thành lời\r\n[Chorus: Cả nhóm]\r\n[02:39] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\r\n[02:43] Rượu vang pha với cơn mưa\r\n[02:45] Hàng trăm lý do cũng chẳng thể cứu vãn\r\n[02:48] Biết sao hết cho vừa lòng nhau mới thấu đây em?\r\n[02:52] Dệt hàng triệu vết thương, tự vùi mình trước gương\r\n[02:56] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\r\n[03:03] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\n[03:07] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\r\n[Outro]\r\n[03:11] Tất cả là tại vì em...\r\n[03:15] Người xa lạ anh từng quen...\r\n[03:19] Tất cả là tại vì em...
48	8	12	5	TOP 1	top-1-1792321698719-42966a	chill	2	REJECTED	\N	Audio file corrupted or encoding does not meet platform standards.	audio-track-48.mp3	/api/media/stream/audio-track-48.mp3	mp3	187742	cover-track-48.png	/api/media/cover/cover-track-48.png	0	2026-10-18 04:08:18.719	2026-10-18 04:16:33.268	[Verse 1]\r\n[00:10] Anh thường hay thức khuya\r\n[00:11] Nghĩ về thứ anh vẫn luôn mong đợi\r\n[00:14] Rằng phải làm sao?\r\n[00:15] Cũng chẳng biết đến bao giờ?\r\n[00:20] Những lời ca dở dang\r\n[00:21] Anh ngồi viết mãi vẫn còn chưa xong\r\n[00:24] Chạy theo đằng sau ánh sáng\r\n[00:27] Cuối nơi chân trời.\r\n[00:29] Rồi em đến đây dịu dàng cạnh bên anh\r\n[00:33] Cơn mưa rơi trở nên long lanh\r\n[00:35] Chẳng còn đợi trông\r\n[00:37] Vì giấc mơ có em thêm màu xanh\r\n[00:40] Thật lòng chẳng xa xôi\r\n[00:43] Ước muốn anh ở ngay đây thôi\r\n[00:45] Anh không bận tâm nữa\r\n[00:47] Vì anh có em.\r\n[Chorus]\r\n[00:50] Nếu như ngày mai không diễn ra\r\n[00:52] Giống cách mà anh cứ luôn mơ mộng?\r\n[00:55] Thì vẫn có một người luôn phía sau\r\n[00:58] Nhẹ nắm tay anh\r\n[01:00] Biết còn nhiều điều lo lắng đang vây quanh\r\n[01:03] Dặn lòng phải xứng đáng hơn\r\n[01:05] Để anh trở thành chàng trai\r\n[01:07] Top 1 trong mắt em.\r\n[Verse 2]\r\n[01:13] Phải tự thân vượt lên, anh vốn không thích hai chữ đáng thương\r\n[01:15] Nhiều người nói là không được đâu nhưng anh vẫn cứ ngang ngược\r\n[01:17] Bởi vì sâu ở trong đầu anh toàn chứa những thứ hoang đường\r\n[01:19] Và từ hồi bé anh đã mơ ước được hát như chú Đan Trường\r\n[01:21] Bầu trời đêm okay cho nên không sao\r\n[01:23] Có đứa nhóc ôm đàn ngân nga những câu yêu đời\r\n[01:26] Dù cho phải gặp bao nhiêu gian khó\r\n[01:28] Vẫn luôn là em dõi theo anh\r\n[01:31] Dù anh đi đến đâu...\r\n[Chorus]\r\n[01:45] Nếu như ngày mai không diễn ra\r\n[01:47] Giống cách mà anh cứ luôn mơ mộng?\r\n[01:50] Thì vẫn có một người luôn phía sau\r\n[01:53] Nhẹ nắm tay anh\r\n[01:55] Biết còn nhiều điều lo lắng đang vây quanh\r\n[01:58] Dặn lòng phải xứng đáng hơn\r\n[02:00] Để anh trở thành chàng trai\r\n[02:02] Top 1 trong mắt em.\r\n[Bridge]\r\n[02:08] Những cơ hội vụt qua đôi tay\r\n[02:11] Vậy chắc chưa phải là ngày hôm nay\r\n[02:14] Thì cứ tiếp tục để chạy theo tiếng gọi\r\n[02:17] Từng câu nói mà anh vẫn luôn tin vào.\r\n[02:20] Có những lần đôi mắt anh lạc phương hướng\r\n[02:23] Để rồi đêm tối anh không về nhà\r\n[02:26] Thì vẫn luôn là em\r\n[02:28] Ngọn đèn rực rỡ chiếu soi nơi anh...\r\n[Chorus & Outro]\r\n[02:30] Nếu như ngày mai không diễn ra\r\n[02:32] Giống cách mà anh cứ luôn mơ mộng\r\n[02:35] Thì vẫn có một người luôn phía sau nhẹ nắm tay anh\r\n[02:40] Biết còn nhiều điều lo lắng đang vây quanh\r\n[02:43] Dặn lòng phải xứng đáng hơn\r\n[02:45] Để anh trở thành chàng trai\r\n[02:48] Top 1 trong mắt em...\r\n[02:53] Top 1 trong mắt em.
49	8	12	5	SECRET	secret-1792321705657-278984	cool	3	PUBLISHED	2026-10-18 04:27:37.857	\N	audio-track-49.mp3	/api/media/stream/audio-track-49.mp3	mp3	280560	cover-track-49.png	/api/media/cover/cover-track-49.png	6	2026-10-18 04:08:25.657	2026-10-18 04:27:43.854	[Intro]\r\n[00:00] (Nhạc dạo đầu)\r\n[Verse 1: CONGB & Cody Nam Võ]\r\n[00:15] Kể từ khi gặp em, trí nhớ hơi bị kém\r\n[00:19] Những món ăn thân quen sao nay bỗng dưng chẳng thèm?\r\n[00:22] Dù bụng đói cồn cào, lại chẳng thể nói lời nào\r\n[00:26] Vì gu em không thích người quá cao\r\n[00:30] Mà anh chẳng hề cao, tính nóng hơi bị láo\r\n[00:33] Nói những câu tào lao khi em nói câu xin chào\r\n[00:37] Vậy thì theo anh đến một nơi, không có biển khơi\r\n[00:41] Chỉ có vườn với trái cây mà thôi\r\n[Pre-Chorus: Quang Hùng MasterD]\r\n[00:44] Vườn anh có trái dưa, trái dâu, trái thơm, trái nho, có luôn banana\r\n[00:50] Nhưng thiếu đi trái tim của một người\r\n[00:53] Lòng anh như gió đông giữa trời đêm\r\n[00:55] Mong thấy em khi bình minh lên, oh-hoh\r\n[Chorus: Cody Nam Võ & Quang Hùng MasterD]\r\n[00:57] Tình đầu ngây thơ mà em, đúng không?\r\n[01:01] Còn chưa nắm tay, chưa về tới phòng\r\n[01:04] Mình còn trông ngóng biết nhiều về nhau\r\n[01:07] Đêm đến ta lại ngắm sao, làm sao mở lòng?\r\n[01:12] Chẳng phải em muốn được anh ghé tai?\r\n[01:15] Thầm thì vài câu suốt bao đêm dài\r\n[01:19] Trời cao có thấu nỗi lòng tận mây xanh?\r\n[01:22] Nói em nghe bí mật của anh!\r\n[Rap Verse: Wren Evans]\r\n[01:26] Nói hết bí mật thì có yêu không?\r\n[01:30] Muốn thấy bí mật hay em muốn nghe bằng lời nói?\r\n[01:34] Đến đây với anh, trăm nghe không bằng một lần thấy\r\n[01:37] Ai rồi cũng phải yêu rồi đấy, baby, ooh-ooh\r\n[01:41] Phải làm sao để gặp my baby?\r\n[01:44] Muốn yêu em chân thành vì anh đâu muốn yêu theo phong trào mà bae\r\n[01:48] Em quen anh chân thành, làm một bộ phim hai ta đóng vai người yêu\r\n[01:52] Rất muốn ai đó có thể nói ra hết sự thật\r\n[01:54] Rằng anh thương em rất nhiều\r\n[01:56] Giờ này nếu thắc mắc em qua bên...\r\n[Bridge: Cody Nam Võ, CONGB & Quang Hùng MasterD]\r\n[02:00] ("Baby à, anh đã nói là em trao cho anh trái tim, sao lại là trái bơ đó hả? Thôi CONGB dô!")\r\n[02:08] Vậy người có muốn mình tay nắm tay?\r\n[02:12] Tình anh đã trao không cần giãi bày\r\n[02:15] Nụ cười em sáng hơn mặt trăng đang lên\r\n[02:19] Chiếu sâu vào trái tim, anh không đỡ được\r\n[02:23] Tặng nàng bài thơ dù không có hay\r\n[02:26] Chỉ mong em hiểu lấy tâm tư này\r\n[02:30] Trời cao có thấu nỗi lòng tận mây xanh?\r\n[02:34] Nói em nghe bí mật của anh!\r\n(Tone nâng nửa cung)\r\n\r\n[Chorus: Wren Evans & Cody Nam Võ]\r\n[02:38] Tình đầu ngây thơ mà em, đúng không?\r\n[02:41] Còn chưa nắm tay, chưa về tới phòng\r\n[02:45] Mình còn trông ngóng biết nhiều về nhau\r\n[02:48] Đêm đến ta lại ngắm sao, làm sao mở lòng?\r\n[02:52] Chẳng phải em muốn được anh ghé tai?\r\n[02:56] Thầm thì vài câu suốt bao đêm dài\r\n[03:00] Trời cao có thấu nỗi lòng tận mây xanh?\r\n[03:04] Nói em nghe bí mật của anh!\r\n[Outro]\r\n[03:08] Bí mật của anh...\r\n[03:12] Nói em nghe bí mật của anh...
58	7	\N	1	Raindance	raindance-1792752833740	Ca khúc nổi tiếng của rapper người Anh Dave kết hợp với nữ ca sĩ Tems, thuộc album The Boy Who Played the Harp phát hành năm 2025.	\N	PUBLISHED	2026-10-23 04:01:10.831	\N	audio-track-58.mp3	/api/media/stream/audio-track-58.mp3	mp3	221008	cover-track-58.png	/api/media/cover/cover-track-58.png	1	2026-10-23 03:53:53.742	2026-10-23 04:01:15.76	[00:18.00] Let's get the party started\n[00:20.00] See you at the bar, you was hardly talkin'\n[00:22.00] That's when I knew that your heart was scarrin'\n[00:24.00] Friends to lovers, need a part to star in, like, "Wait, babe\n[00:27.00] Let me ask your pardon\n[00:29.00] This ain't Gucci, this is Prada, darlin'\n[00:31.00] If you want somethin', you can ask me, darlin'"\n[00:34.00] Then you started laughin' 'cause you think I'm jokin'\n[00:36.00] But lookin' in your eyes is the best thing\n[00:38.00] Brake lights givin' you the red skin\n[00:40.00] You was in a bad mood from we stepped in\n[00:42.00] Though you checked out 'fore we even checked in\n[00:44.00] On the phone you gon' vent to your best friend\n[00:46.00] The one who gave me the lecture, but I ain't gon' sweat you, babe\n[00:49.00] I'ma let you catch up with your boy, undress you\n[00:52.00] And let me tell you why I'ma bless you\n[00:55.00] It's the way my mind is fallin' away\n[00:59.00] In my heart, I know\n[01:02.00] You feel the same when you're with me\n[01:05.00] You know I'm all you need\n[01:07.00] You're where I wanna be\n[01:09.00] My darling, can't you see?\n[01:12.00] I love you\n[01:16.00] I love you\n[01:20.00] I love you\n[01:24.00] I love you\n[01:29.00] I love you\n[01:31.00] Fell into you\n[01:33.00] Say you want me in the mood\n[01:35.00] Tryna hide my feelings for you\n[01:37.00] Don't wanna argue, not with you\n[01:39.00] Tell me why you're so in denial\n[01:41.00] Hold me close, don't tell me goodnight\n[01:43.00] Are you down to get me?\n[01:46.00] Tell me when you're ready, I'm ready\n[01:49.00] We can get into it or we can get intimate\n[01:52.00] The shower when you sing in it\n[01:53.00] Better than Beyoncé, I like the sound of fiancée\n[01:56.00] You know it's got a little ring to it\n[01:58.00] And really when I think of it\n[01:59.00] Growin' up, I didn't ever see marriages\n[02:01.00] No weddings, no horse, no carriages\n[02:03.00] I wanna do things different and change the narrative\n[02:06.00] God knows you a wild child, beautiful child, I need your help\n[02:09.00] Lookin' like you come from the '90s by yourself\n[02:11.00] My mum sixty-one and her favourite line to tell her son is\n[02:14.00] "Sometimes she wish that she had a girl"\n[02:15.00] I wanna take you back to a time, back to a trip\n[02:18.00] You had that white wine that I never got to sip\n[02:20.00] And dinner wasn't ruined 'cause you never got to pick\n[02:22.00] I know that everybody told me that I'm sick 'cause\n[02:24.00] It's the way my mind is fallin' away\n[02:28.00] In my heart, I know\n[02:30.00] You feel the same when you're with me\n[02:33.00] You know I'm all you need\n[02:36.00] You're where I wanna be\n[02:38.00] My darling, can't you see?\n[02:41.00] I love you (Me and you, never let me go)\n[02:45.00] (Me and you, I'll tell you two times)\n[02:47.00] I love you (Me and you, never let me go)\n[02:50.00] (Me and you, tell me two times)\n[02:52.00] I love you (Me and you, never let me go)\n[02:54.00] (Me and you, tell me two times)\n[02:56.00] I love you (Me and you, never let me go)\n[02:58.00] (Me and you, tell me two times)\n[03:00.00] I said lean with it, rock with it\n[03:03.00] Your finger, I could put a rock in it\n[03:05.00] Fin-finger, I could put a rock in it\n[03:07.00] Bank card, they gon' put a block in it\n[03:09.00] Said rock with it, bounce with it\n[03:12.00] The left wrist, I could put my house in it\n[03:14.00] You wanna bet, babe? I could put my house in it\n[03:16.00] Paper, I could put my spouse in it\n[03:18.00] I said shimmy shimmy yay, shimmy\n[03:20.00] Shimmy shimmy yah\n[03:21.00] 5'9", brown eyes, and she in it, in it\n[03:23.00] Shimmy shimmy yay, shimmy\n[03:25.00] Shimmy shimmy yah\n[03:26.00] 5'9", brown eyes, innit, innit\n[03:28.00] Shimmy shimmy yay, shimmy\n[03:30.00] Shimmy shimmy yah\n[03:31.00] 5'9", brown eyes, and she in-in—\n[03:33.00] Shimmy shimmy yay, shimmy\n[03:34.00] Shimmy shimmy yah\n[03:35.00] 5'9", brown eyes...
59	8	\N	5	TOP1	top1-1792761057504	Chill and relax	\N	PUBLISHED	2026-10-23 06:12:06.227	\N	audio-track-59.mp3	/api/media/stream/audio-track-59.mp3	mp3	187742	cover-track-59.png	/api/media/cover/cover-track-59.png	1	2026-10-23 06:10:57.506	2026-10-23 06:12:06.533	[00:10.00] Anh thường hay thức khuya\n[00:11.00] Nghĩ về thứ anh vẫn luôn mong đợi\n[00:14.00] Rằng phải làm sao?\n[00:15.00] Cũng chẳng biết đến bao giờ?\n[00:20.00] Những lời ca dở dang\n[00:21.00] Anh ngồi viết mãi vẫn còn chưa xong\n[00:24.00] Chạy theo đằng sau ánh sáng\n[00:27.00] Cuối nơi chân trời.\n[00:29.00] Rồi em đến đây dịu dàng cạnh bên anh\n[00:33.00] Cơn mưa rơi trở nên long lanh\n[00:35.00] Chẳng còn đợi trông\n[00:37.00] Vì giấc mơ có em thêm màu xanh\n[00:40.00] Thật lòng chẳng xa xôi\n[00:43.00] Ước muốn anh ở ngay đây thôi\n[00:45.00] Anh không bận tâm nữa\n[00:47.00] Vì anh có em.\n[00:50.00] Nếu như ngày mai không diễn ra\n[00:52.00] Giống cách mà anh cứ luôn mơ mộng?\n[00:55.00] Thì vẫn có một người luôn phía sau\n[00:58.00] Nhẹ nắm tay anh\n[01:00.00] Biết còn nhiều điều lo lắng đang vây quanh\n[01:03.00] Dặn lòng phải xứng đáng hơn\n[01:05.00] Để anh trở thành chàng trai\n[01:07.00] Top 1 trong mắt em.\n[01:13.00] Phải tự thân vượt lên, anh vốn không thích hai chữ đáng thương\n[01:15.00] Nhiều người nói là không được đâu nhưng anh vẫn cứ ngang ngược\n[01:17.00] Bởi vì sâu ở trong đầu anh toàn chứa những thứ hoang đường\n[01:19.00] Và từ hồi bé anh đã mơ ước được hát như chú Đan Trường\n[01:21.00] Bầu trời đêm okay cho nên không sao\n[01:23.00] Có đứa nhóc ôm đàn ngân nga những câu yêu đời\n[01:26.00] Dù cho phải gặp bao nhiêu gian khó\n[01:28.00] Vẫn luôn là em dõi theo anh\n[01:31.00] Dù anh đi đến đâu...\n[01:45.00] Nếu như ngày mai không diễn ra\n[01:47.00] Giống cách mà anh cứ luôn mơ mộng?\n[01:50.00] Thì vẫn có một người luôn phía sau\n[01:53.00] Nhẹ nắm tay anh\n[01:55.00] Biết còn nhiều điều lo lắng đang vây quanh\n[01:58.00] Dặn lòng phải xứng đáng hơn\n[02:00.00] Để anh trở thành chàng trai\n[02:02.00] Top 1 trong mắt em.\n[02:08.00] Những cơ hội vụt qua đôi tay\n[02:11.00] Vậy chắc chưa phải là ngày hôm nay\n[02:14.00] Thì cứ tiếp tục để chạy theo tiếng gọi\n[02:17.00] Từng câu nói mà anh vẫn luôn tin vào.\n[02:20.00] Có những lần đôi mắt anh lạc phương hướng\n[02:23.00] Để rồi đêm tối anh không về nhà\n[02:26.00] Thì vẫn luôn là em\n[02:28.00] Ngọn đèn rực rỡ chiếu soi nơi anh...\n[02:30.00] Nếu như ngày mai không diễn ra\n[02:32.00] Giống cách mà anh cứ luôn mơ mộng\n[02:35.00] Thì vẫn có một người luôn phía sau nhẹ nắm tay anh\n[02:40.00] Biết còn nhiều điều lo lắng đang vây quanh\n[02:43.00] Dặn lòng phải xứng đáng hơn\n[02:45.00] Để anh trở thành chàng trai\n[02:48.00] Top 1 trong mắt em...\n[02:53.00] Top 1 trong mắt em.\n[Verse 1]\n[Chorus]\n[Verse 2]\n[Chorus]\n[Bridge]\n[Chorus & Outro]
61	9	\N	5	In Love	in-love-1792862381088	\N	\N	TAKEN_DOWN	2026-10-24 10:20:19.543	\N	audio-track-61.mp3	/api/media/stream/audio-track-61.mp3	mp3	200923	cover-track-61.webp	/api/media/cover/cover-track-61.webp	0	2026-10-24 10:19:41.089	2026-10-24 10:20:39.656	\N
17	3	1	3	IDK	idk-1791644929842	\N	\N	PUBLISHED	2026-11-11 08:59:08.156	\N	audio-track-17.mp3	/api/media/stream/audio-track-17.mp3	mp3	367525	cover-track-17.jpg	/api/media/cover/cover-track-17.jpg	0	2026-10-10 08:08:49.844	2026-11-11 08:59:13.828	\N
6	12	\N	3	Baby	baby-mck	Bản hit đầy cảm xúc từ album 99% của MCK.	1	PUBLISHED	2026-10-09 10:01:54.581	\N	audio-track-6.mp3	/api/media/stream/audio-track-6.mp3	mp3	173740	cover-track-6.webp	/api/media/cover/cover-track-6.webp	15216	2026-10-09 10:01:54.581	2026-10-11 03:20:10.897	\N
8	13	\N	2	Giữa Đại Lộ Đông Tây	giua-dai-lo-dong-tay	Ca khúc ballad da diết sáng tác bởi Hứa Kim Tuyền qua giọng hát nội lực của Uyên Linh.	1	PUBLISHED	2026-10-09 10:02:36.028	\N	audio-track-8.mp3	/api/media/stream/audio-track-8.mp3	mp3	226691	cover-track-8.webp	/api/media/cover/cover-track-8.webp	19810	2026-10-09 10:02:36.028	2026-10-09 10:02:36.028	\N
16	3	1	3	MẮT MÔI TAY CHÂN	mat-moi-tay-chan-1791644742088	\N	3	PUBLISHED	2026-10-10 08:06:11.632	\N	audio-track-16.mp3	/api/media/stream/audio-track-16.mp3	mp3	221797	cover-track-16.jpg	/api/media/cover/cover-track-16.jpg	9	2026-10-10 08:05:42.09	2026-10-11 03:20:00.763	\N
36	9	\N	2	Không Buông	khong-buong-1792100491097	\N	\N	PUBLISHED	2026-10-15 14:42:42.255	\N	audio-track-36.mp3	/api/media/stream/audio-track-36.mp3	mp3	174875	cover-track-36.jpg	/api/media/cover/cover-track-36.jpg	8	2026-10-15 14:41:31.098	2026-10-15 14:42:46.426	\N
44	9	\N	5	Phải lòng	phai-long-1792318735196	\N	\N	TAKEN_DOWN	2026-10-24 10:03:07.317	\N	audio-track-44.mp3	/api/media/stream/audio-track-44.mp3	mp3	268525	cover-track-44.webp	/api/media/cover/cover-track-44.webp	0	2026-10-18 03:18:55.197	2026-10-24 10:08:25.757	\N
50	9	\N	4	Buông	buong-1792321862145	\N	\N	PUBLISHED	2026-10-18 04:13:26.372	\N	audio-track-50.mp3	/api/media/stream/audio-track-50.mp3	mp3	205171	cover-track-50.jpg	/api/media/cover/cover-track-50.jpg	8	2026-10-18 04:11:02.147	2026-10-18 04:13:33.218	[00:00.60] Từ giờ anh sẽ xóa đi hết kỉ niệm\n[00:05.15] Anh sẽ quên hết thứ anh đã tin\n[00:09.94] Chẳng để sót lại gì làm anh lưu luyến\n[00:16.85] Anh chẳng còn sức để ôm vào lòng\n[00:21.05] Hãy để mọi thứ trôi đi theo dòng\n[00:25.50] Hãy cứ xem như chuyện mình chỉ là giấc mơ\n[00:33.20] Cũng đã bao tháng trôi qua\n[00:37.20] Mà anh cứ ngỡ chỉ mới hôm qua\n[00:40.79] Có lẽ anh chỉ chực chờ hoài, rồi đếm giây trôi\n[00:44.50] Xong cứ nghĩ mãi về đôi ta, oh\n[00:48.50] Từng hứa sẽ quên em nhanh\n[00:52.00] Mà dường như cơn mưa mãi không tạnh\n[00:55.50] Nhìn em vui hạnh phúc bên ai rồi\n[00:59.20] Mà sao tim anh chẳng đành?\n[01:03.20] Từ giờ anh sẽ xóa đi hết kỷ niệm\n[01:07.04] Anh sẽ quên hết thứ anh đã tin\n[01:11.84] Chẳng để sót lại gì làm anh lưu luyến\n[01:18.25] Anh chẳng còn sức để ôm vào lòng\n[01:22.50] Hãy để mọi thứ trôi đi theo dòng\n[01:27.00] Và cứ xem như chuyện mình chỉ là giấc mơ (chỉ là giấc mơ)\n[01:34.00] Baby, anh nhận ra ta chưa từng chịu nghe nhau nói\n[01:36.40] Cứ trách và móc để dần nỗi nhớ nhân đôi\n[01:38.40] Không bận tâm rồi một ngày cơn giông tới\n[01:40.59] Để nó cuốn đi hết, giờ thì hai đứa hai nơi\n[01:42.70] Ta phí thời giờ với những lần tranh cãi\n[01:44.70] Cũng chỉ để nhận lại dòng nước mắt tuôn rơi\n[01:47.00] Rớt thành dòng, tích thành vùng biên hải\n[01:49.00] Rồi lại đặt câu hỏi, "Sao tan nát em ơi?"\n[01:51.20] Oh, ta thường sống như vậy mà\n[01:53.20] Biết là bad vẫn cố chấp như vậy mà\n[01:55.20] Nước mắt siết thành thác, tới khô khốc như vậy mà\n[01:57.20] Tình mình hóa tan nát cũng vì ngu ngốc như vậy mà\n[01:59.20] Oh, chỉ là vài lời cuối rồi anh hứa rằng mình sẽ cố quên đi em\n[02:03.00] Nếu mai này em tìm được hạnh phúc, hãy chậm lại một chút để lắng nghe nhau thêm\n[02:06.20] Anh đã cố để quên em nhanh\n[02:09.80] Mà dường như cơn mưa mãi không tạnh\n[02:13.19] Nhìn em vui hạnh phúc bên ai rồi\n[02:17.00] Mà sao tim anh chẳng đành\n[02:21.00] Từ giờ anh sẽ xóa đi hết kỷ niệm\n[02:24.80] Anh sẽ quên hết thứ anh đã tin\n[02:29.00] Chẳng để sót lại gì làm anh lưu luyến\n[02:35.80] Anh chẳng còn sức để ôm vào lòng\n[02:40.00] Hãy để mọi thứ trôi đi theo dòng\n[02:44.50] Và cứ xem như chuyện mình chỉ là giấc mơ\n[02:51.80] Anh từng ước thời gian ngưng đọng\n[02:55.80] Để được ôm em vào mãi trong lòng\n[02:59.80] Giờ mọi thứ như hóa vô vọng\n[03:03.80] Anh phải làm sao để qua cơn giông?\n[03:07.80] Từng lời em nói còn vang bên tai\n[03:11.80] Dù anh đã cố để chẳng nhớ lại\n[03:15.80] Từ giờ ta chấm dứt chia hai\n[03:19.19] Hãy quên giấc mơ yêu mãi không phai
67	8	16	5	LAV	lav-1793439786219-2b0451	\N	1	PENDING	\N	\N	audio-track-67.mp3	/api/media/stream/audio-track-67.mp3	mp3	270620	cover-track-67.png	/api/media/cover/cover-track-67.png	0	2026-10-31 02:43:06.222	2026-10-31 02:43:06.222	\N
68	8	16	5	TOP 1	top-1-1793439786408-6ae43e	\N	2	PENDING	\N	\N	audio-track-68.mp3	/api/media/stream/audio-track-68.mp3	mp3	187742	cover-track-68.png	/api/media/cover/cover-track-68.png	0	2026-10-31 02:43:06.409	2026-10-31 02:43:06.409	\N
69	8	16	5	MRT	mrt-1793439786490-ee33e6	\N	3	PENDING	\N	\N	audio-track-69.mp3	/api/media/stream/audio-track-69.mp3	mp3	210862	cover-track-69.png	/api/media/cover/cover-track-69.png	0	2026-10-31 02:43:06.491	2026-10-31 02:43:06.491	\N
26	18	\N	7	One more time one more chance	one-more-time-one-more-chance-1791896096019	\N	\N	PUBLISHED	2026-10-13 06:19:18.747	\N	audio-track-26.mp3	/api/media/stream/audio-track-26.mp3	mp3	334367	cover-track-26.jpg	/api/media/cover/cover-track-26.jpg	6	2026-10-13 05:54:56.019	2026-10-13 06:20:22.293	\N
7	11	\N	3	Exit Sign	exit-sign-hieuthuhai	Ca khúc nổi bật trong album Ai Cũng Phải Bắt Đầu Từ Đâu Đó của HIEUTHUHAI kết hợp cùng marzuz và Kewtiie.	2	PUBLISHED	2026-10-09 10:02:15.314	\N	audio-track-7.mp3	/api/media/stream/audio-track-7.mp3	mp3	201718	cover-track-7.webp	/api/media/cover/cover-track-7.webp	28471	2026-10-09 10:02:15.314	2026-10-11 03:20:10.993	\N
13	15	\N	1	Yoru ni Kakeru (夜に駆ける)	yoru-ni-kakeru	Bản hit đột phá toàn cầu của bộ đôi YOASOBI dựa trên tiểu thuyết Tanatosu no Yūwaku.	1	PUBLISHED	2026-10-09 10:06:00.496	\N	audio-track-13.mp3	/api/media/stream/audio-track-13.mp3	mp3	275043	cover-track-13.webp	/api/media/cover/cover-track-13.webp	38933	2026-10-09 10:06:00.496	2026-10-09 10:06:00.496	\N
20	8	\N	6	SECRET	secret-1791743674225	This is a vibrant song	\N	REJECTED	\N	Audio file corrupted or encoding does not meet platform standards.	audio-track-20.mp3	/api/media/stream/audio-track-20.mp3	mp3	280560	cover-track-20.png	/api/media/cover/cover-track-20.png	0	2026-10-11 11:34:34.227	2026-10-11 12:24:39.545	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...
38	9	\N	8	3017-2	3017-2-1792101165612	3017	\N	PUBLISHED	2026-10-15 14:54:44	\N	audio-track-38.mp3	/api/media/stream/audio-track-38.mp3	mp3	268525	cover-track-38.jpg	/api/media/cover/cover-track-38.jpg	11	2026-10-15 14:52:45.612	2026-10-15 14:54:49.301	\N
45	8	11	6	LAVIEM	laviem-1792319232160-1fad98	Music good	1	PUBLISHED	2026-10-18 03:32:16.177	\N	audio-track-45.mp3	/api/media/stream/audio-track-45.mp3	mp3	270620	cover-track-45.png	/api/media/cover/cover-track-45.png	1	2026-10-18 03:27:12.163	2026-10-18 03:32:22.53	[00:02.00] Còn cần thiết nữa, nói chi đến đây cũng thừa\n[00:04.00] Giờ chỉ còn mình với vấn vương (Rượu vang pha với cơn mưa)\n[00:07.00] Hàng trăm lý do cũng chẳng thể cứu vãn\n[00:09.00] Biết sao hết cho vừa?\n[00:11.00] Lòng nhau mới thấu đây em\n[00:13.00] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\n[00:17.00] Rượu vang pha với cơn mưa\n[00:20.00] Hàng trăm lý do cũng chẳng thể cứu vãn\n[00:22.00] Biết sao hết cho vừa? Lòng nhau mới thấu đây em\n[00:26.00] Dệt hàng triệu vết thương, tự vùi mình trước gương\n[00:30.00] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\n[00:33.00] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\n[00:37.00] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\n[00:41.00] Ta chia tay, vì sao em ơi?\n[00:44.00] Điều này anh muốn hỏi lâu rồi\n[00:47.00] Những khung trời kỷ niệm vỡ đôi\n[00:50.00] Có phải vì một câu anh đã lỡ lời?\n[00:54.00] Sau đêm nay, tự ta cho ta\n[00:57.00] Em và anh một đoạn kết mới\n[01:00.00] Dù rằng mình còn yêu nhau rất nhiều đấy\n[01:04.00] Nhưng để ở lại thì anh nghĩ là không\n[01:06.00] Và sau những cảm xúc nhất thời\n[01:10.00] Người bên em giờ này chẳng còn là anh\n[01:13.00] Gửi lại quá khứ cung đàn đã vỡ\n[01:17.00] Vì những vấn vương ấy chưa kịp thành lời\n[01:19.00] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\n[01:23.00] Rượu vang pha với cơn mưa\n[01:26.00] Hàng trăm lý do cũng chẳng thể cứu vãn\n[01:28.00] Biết sao hết cho vừa? Lòng nhau mới thấu đây em\n[01:33.00] Dệt hàng triệu vết thương, tự vùi mình trước gương\n[01:36.00] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\n[01:39.00] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\n[01:43.00] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\n[01:46.00] Tất cả là tại vì em, em, em, em, em, e-em\n[01:50.00] Người xa lạ anh từng quen\n[01:53.00] Tất cả là tại vì em, em, em, em, em, e-em\n[01:57.00] Kẻ ngốc đang say tình dưới ngọn đèn\n[01:59.00] Tất cả là tại vì em, em, em, em, em, e-em\n[02:03.00] Người xa lạ anh từng quen\n[02:06.00] Tất cả là tại vì em, em, em, em, em, yeah-eh-eh\n[02:10.00] Kẻ ngốc đang say tình dưới ngọn đèn\n[02:13.00] Lau đôi mi, đây là nước mắt hay mưa\n[02:15.00] Buông đôi tay, anh đâu muốn phải dây dưa\n[02:17.00] Quên đi đôi mắt ấy khi xưa, chẳng bên nhau được nữa\n[02:20.00] Sau bao lần đau, anh lại cho đi và quên\n[02:22.00] Anh ghét nỗi đau, cơn mưa đêm kia và em\n[02:24.00] Ta vội quên rồi, những điều sao thật quen\n[02:27.00] Để nỗi buồn kia gọi tên mỗi khi bài ca bật lên\n[02:28.00] Và sau những cảm xúc nhất thời\n[02:30.00] Người bên em giờ này chẳng còn là anh\n[02:33.00] Gửi lại quá khứ cung đàn đã vỡ\n[02:37.00] Vì những vấn vương ấy chưa kịp thành lời\n[02:39.00] Trái tim anh chẳng còn cần thiết nữa, nói chi đến đây cũng thừa\n[02:43.00] Rượu vang pha với cơn mưa\n[02:45.00] Hàng trăm lý do cũng chẳng thể cứu vãn\n[02:48.00] Biết sao hết cho vừa lòng nhau mới thấu đây em?\n[02:52.00] Dệt hàng triệu vết thương, tự vùi mình trước gương\n[02:56.00] Nhìn một người đã từng thương sao nay xa lạ đến bất thường\n[03:03.00] Cố gắng cũng chỉ bằng không, nước mắt ngược dòng\n[03:07.00] Chảy ngược tận sâu bên trong nghẹn đắng nơi lồng ngực\n[03:11.00] Tất cả là tại vì em...\n[03:15.00] Người xa lạ anh từng quen...\n[03:19.00] Tất cả là tại vì em...\n[Chorus: CAPTAIN BOY & CoolKid]\n[Verse 1: Pháp Kiều & CAPTAIN BOY]\n[Pre-Chorus: Quang Hùng MasterD]\n[Chorus: Quang Hùng MasterD & CAPTAIN BOY]\n[Post-Chorus: Quang Hùng MasterD & CoolKid]\n[Verse 2: Pháp Kiều]\n[Pre-Chorus: CoolKid & Quang Hùng MasterD]\n[Chorus: Cả nhóm]\n[Outro]
46	8	11	2	TOP 1	top-1-1792319237706-a41201	feedling	2	PUBLISHED	2026-10-18 04:15:40.893	\N	audio-track-46.mp3	/api/media/stream/audio-track-46.mp3	mp3	187742	cover-track-46.png	/api/media/cover/cover-track-46.png	0	2026-10-18 03:27:17.708	2026-10-18 04:15:47.504	[00:00.00] [Verse 1]\n[00:10.00] Anh thường hay thức khuya\n[00:11.00] Nghĩ về thứ anh vẫn luôn mong đợi\n[00:14.00] Rằng phải làm sao?\n[00:15.00] Cũng chẳng biết đến bao giờ?\n[00:20.00] Những lời ca dở dang\n[00:21.00] Anh ngồi viết mãi vẫn còn chưa xong\n[00:24.00] Chạy theo đằng sau ánh sáng\n[00:27.00] Cuối nơi chân trời.\n[00:29.00] Rồi em đến đây dịu dàng cạnh bên anh\n[00:33.00] Cơn mưa rơi trở nên long lanh\n[00:35.00] Chẳng còn đợi trông\n[00:37.00] Vì giấc mơ có em thêm màu xanh\n[00:40.00] Thật lòng chẳng xa xôi\n[00:43.00] Ước muốn anh ở ngay đây thôi\n[00:45.00] Anh không bận tâm nữa\n[00:47.00] Vì anh có em.\n[00:50.00] Nếu như ngày mai không diễn ra\n[00:52.00] Giống cách mà anh cứ luôn mơ mộng?\n[00:55.00] Thì vẫn có một người luôn phía sau\n[00:58.00] Nhẹ nắm tay anh\n[01:00.00] Biết còn nhiều điều lo lắng đang vây quanh\n[01:03.00] Dặn lòng phải xứng đáng hơn\n[01:05.00] Để anh trở thành chàng trai\n[01:07.00] Top 1 trong mắt em.\n[01:13.00] Phải tự thân vượt lên, anh vốn không thích hai chữ đáng thương\n[01:15.00] Nhiều người nói là không được đâu nhưng anh vẫn cứ ngang ngược\n[01:17.00] Bởi vì sâu ở trong đầu anh toàn chứa những thứ hoang đường\n[01:19.00] Và từ hồi bé anh đã mơ ước được hát như chú Đan Trường\n[01:21.00] Bầu trời đêm okay cho nên không sao\n[01:23.00] Có đứa nhóc ôm đàn ngân nga những câu yêu đời\n[01:26.00] Dù cho phải gặp bao nhiêu gian khó\n[01:28.00] Vẫn luôn là em dõi theo anh\n[01:31.00] Dù anh đi đến đâu...\n[01:45.00] Nếu như ngày mai không diễn ra\n[01:47.00] Giống cách mà anh cứ luôn mơ mộng?\n[01:50.00] Thì vẫn có một người luôn phía sau\n[01:53.00] Nhẹ nắm tay anh\n[01:55.00] Biết còn nhiều điều lo lắng đang vây quanh\n[01:58.00] Dặn lòng phải xứng đáng hơn\n[02:00.00] Để anh trở thành chàng trai\n[02:02.00] Top 1 trong mắt em.\n[02:08.00] Những cơ hội vụt qua đôi tay\n[02:11.00] Vậy chắc chưa phải là ngày hôm nay\n[02:14.00] Thì cứ tiếp tục để chạy theo tiếng gọi\n[02:17.00] Từng câu nói mà anh vẫn luôn tin vào.\n[02:20.00] Có những lần đôi mắt anh lạc phương hướng\n[02:23.00] Để rồi đêm tối anh không về nhà\n[02:26.00] Thì vẫn luôn là em\n[02:28.00] Ngọn đèn rực rỡ chiếu soi nơi anh...\n[02:30.00] Nếu như ngày mai không diễn ra\n[02:32.00] Giống cách mà anh cứ luôn mơ mộng\n[02:35.00] Thì vẫn có một người luôn phía sau nhẹ nắm tay anh\n[02:40.00] Biết còn nhiều điều lo lắng đang vây quanh\n[02:43.00] Dặn lòng phải xứng đáng hơn\n[02:45.00] Để anh trở thành chàng trai\n[02:48.00] Top 1 trong mắt em...\n[02:53.00] Top 1 trong mắt em.\n[Chorus]\n[Verse 2]\n[Chorus]\n[Bridge]\n[Chorus & Outro]
63	8	\N	5	TOP1	top1-1793117754617	\N	\N	PUBLISHED	2026-11-11 07:57:28.115	\N	audio-track-63.mp3	/api/media/stream/audio-track-63.mp3	mp3	187742	cover-track-63.png	/api/media/cover/cover-track-63.png	0	2026-10-27 09:15:54.625	2026-11-11 07:57:37.601	[ti:Top 1 (Trong Mắt Em)]\r\n[ar:buitruonglinh]\r\n[al:Top 1 (Trong Mắt Em)]\r\n[by:Antigravity]\r\n\r\n[00:00.00]Top 1 (Trong Mắt Em) - buitruonglinh\r\n[00:08.50]...\r\n[00:10.25]Anh thường hay thức khuya\r\n[00:11.80]Nghĩ về thứ anh vẫn luôn mong đợi\r\n[00:14.65]Rằng phải làm sao?\r\n[00:15.88]Cũng chẳng biết đến bao giờ?\r\n[00:20.30]Những lời ca dở dang\r\n[00:21.91]Anh ngồi viết mãi vẫn còn chưa xong\r\n[00:24.70]Chạy theo đằng sau ánh sáng\r\n[00:27.10]Cuối nơi chân trời\r\n[00:29.49]Rồi em đến đây\r\n[00:30.80]Dịu dàng cạnh bên anh\r\n[00:33.08]Cơn mưa rơi trở nên long lanh\r\n[00:35.47]Chẳng còn đợi trông\r\n[00:37.48]Vì giấc mơ có em thêm màu xanh\r\n[00:40.27]Thật lòng chẳng xa xôi\r\n[00:43.08]Ước muốn anh ở ngay đây thôi\r\n[00:45.85]Anh không bận tâm nữa\r\n[00:47.46]Vì anh có em\r\n[00:50.43]Nếu như ngày mai không diễn ra\r\n[00:52.81]Giống cách mà anh cứ luôn mơ mộng?\r\n[00:55.60]Thì vẫn có một người luôn phía sau\r\n[00:58.01]Nhẹ nắm tay anh\r\n[01:00.41]Biết còn nhiều điều lo lắng đang vây quanh\r\n[01:03.99]Dặn lòng phải xứng đáng hơn\r\n[01:05.98]Để anh trở thành chàng trai\r\n[01:07.59]Top 1 trong mắt em\r\n[01:11.35]Phải tự thân vượt lên, anh vốn không thích hai chữ đáng thương\r\n[01:14.07]Nhiều người nói là không được đâu nhưng anh vẫn cứ ngang ngược\r\n[01:16.47]Bởi vì sâu ở trong đầu anh toàn chứa những thứ hoang đường\r\n[01:19.08]Và từ hồi bé anh đã mơ ước được hát như chú Đan Trường\r\n[01:21.75]Bầu trời đêm okay cho nên không sao\r\n[01:23.88]Có đứa nhóc ôm đàn ngân nga những câu yêu đời\r\n[01:26.55]Dù cho phải gặp bao nhiêu gian khó\r\n[01:27.80]Vẫn luôn là em dõi theo anh\r\n[01:29.74]Dù anh đi đến đâu...\r\n[01:31.60]Nếu như ngày mai không diễn ra\r\n[01:33.99]Giống cách mà anh cứ luôn mơ mộng?\r\n[01:36.78]Thì vẫn có một người luôn phía sau\r\n[01:39.17]Nhẹ nắm tay anh\r\n[01:41.59]Biết còn nhiều điều lo lắng đang vây quanh\r\n[01:44.78]Dặn lòng phải xứng đáng hơn\r\n[01:46.80]Để anh trở thành chàng trai\r\n[01:48.50]Top 1 trong mắt em\r\n[01:52.50]Những cơ hội vụt qua đôi tay\r\n[01:55.20]Vậy chắc chưa phải là ngày hôm nay\r\n[01:57.80]Thì cứ tiếp tục để chạy theo tiếng gọi\r\n[01:59.80]Từng câu nói mà anh\r\n[02:00.91]Vẫn luôn tin vào\r\n[02:02.49]Có những lần đôi mắt anh lạc phương hướng\r\n[02:04.90]Để rồi đêm tối anh không về nhà\r\n[02:07.69]Thì vẫn luôn là em\r\n[02:08.87]Ngọn đèn rực rỡ chiếu soi nơi anh...\r\n[02:12.47]Nếu như ngày mai không diễn ra\r\n[02:15.32]Giống cách mà anh cứ luôn mơ mộng?\r\n[02:18.11]Thì vẫn có một người luôn phía sau\r\n[02:20.50]Nhẹ nắm tay anh\r\n[02:22.90]Biết còn nhiều điều lo lắng đang vây quanh\r\n[02:26.50]Dặn lòng phải xứng đáng hơn\r\n[02:28.50]Để anh trở thành chàng trai\r\n[02:30.50]Top 1 trong mắt em...\r\n[02:35.00]Top 1 trong mắt em\r\n[02:40.00]Top 1 trong mắt em...\r\n[02:46.00]...
9	14	\N	4	Tìm Em	tim-em-hngle-bao-anh	Giai điệu R&B nhẹ nhàng, lãng mạn qua sự kết hợp ăn ý giữa Hngle và Bảo Anh.	1	PUBLISHED	2026-10-09 10:03:04.748	\N	audio-track-9.mp3	/api/media/stream/audio-track-9.mp3	mp3	272170	cover-track-9.webp	/api/media/cover/cover-track-9.webp	12305	2026-10-09 10:03:04.748	2026-10-09 10:03:04.748	\N
11	16	\N	7	Haru (晴る)	haru-yorushika	Ca khúc chủ đề mở đầu của anime Frieren: Beyond Journey's End thực hiện bởi nhóm nhạc Yorushika.	1	PUBLISHED	2026-10-09 10:04:58.459	\N	audio-track-11.mp3	/api/media/stream/audio-track-11.mp3	mp3	276715	cover-track-11.webp	/api/media/cover/cover-track-11.webp	21752	2026-10-09 10:04:58.459	2026-10-09 10:04:58.459	\N
12	17	\N	1	A Cruel Angel's Thesis (残酷な天使のテーゼ)	a-cruel-angels-thesis	Bài hát chủ đề huyền thoại của anime Neon Genesis Evangelion trình bày bởi Yoko Takahashi.	1	PUBLISHED	2026-10-09 10:05:23.504	\N	audio-track-12.mp3	/api/media/stream/audio-track-12.mp3	mp3	243905	cover-track-12.webp	/api/media/cover/cover-track-12.webp	34520	2026-10-09 10:05:23.504	2026-10-09 10:05:23.504	\N
22	8	\N	5	MRT	mrt-1791747635924	\N	\N	REJECTED	\N	Audio file corrupted or encoding does not meet platform standards.	audio-track-22.mp3	/api/media/stream/audio-track-22.mp3	mp3	210862	cover-track-22.png	/api/media/cover/cover-track-22.png	0	2026-10-11 12:40:35.924	2026-10-23 05:45:52.741	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...
56	9	\N	4	In Love	in-love-1792837675833	Love	\N	PUBLISHED	2026-10-24 03:46:17.124	\N	audio-track-56.mp3	/api/media/stream/audio-track-56.mp3	mp3	200923	cover-track-56.jpg	/api/media/cover/cover-track-56.jpg	16	2026-10-18 18:45:19.44	2026-10-24 03:46:23.253	[00:21.57] Nơi anh bao năm không có nắng\n[00:24.28] Và mưa giăng nơi em đôi khi cũng chưa từng muốn ngừng\n[00:27.00] Mà đi bao xa ta vẫn thấy ngắn\n[00:29.19] Vì nơi đâu cũng là nhà\n[00:32.46] Anh băng qua bao la con sóng trắng\n[00:35.13] Niềm tin mong manh cũng chỉ biết giăng buồm thật căng\n[00:37.75] Để mà lênh đênh trôi mang theo bao cố gắng\n[00:40.10] Dù mưa gió có lỡ xô anh đi xa bến bờ\n[00:43.03] Vì ngày đó anh chẳng cần biết điều gì đến\n[00:46.95] Cũng chẳng thể viết vội đoạn kết\n[00:49.67] Khi còn chưa đi hết những xước chai, những đúng sai\n[00:53.96] Và ngoài đó hoang tàn giằng xé\n[00:56.64] Thì ở đây vẫn có điều nhỏ bé\n[00:59.46] Mà lặng lẽ vun xây những mơ mộng này\n[01:02.25] Để hôm nay khi đứng đây, em chính là điều nhỏ bé ở bên bờ\n[01:05.62] (<I'm in love, I'm in love, in love with you>) ooh, my love\n[01:08.42] (<I'm in love, I'm in love, in love with you>) nơi ấy em chờ\n[01:11.15] (<I'm in love, I'm in love, in love with you>) ở bên bờ, ở bên bờ cùng mong nhớ\n[01:16.64] (<I'm in love, I'm in love, in love with you>) ooh, my love\n[01:19.37] (<I'm in love, I'm in love, in love with you>) nơi ấy em chờ\n[01:22.06] (<I'm in love, I'm in love, in love with you>)\n[01:24.28] Em vẫn luôn rạng rỡ, gom từng thương nhớ nơi bến bờ\n[01:27.51] Yeah, nhiều cô gái không hiểu được anh\n[01:29.78] Và có nhiều mối quan hệ ngày xưa cũng tự kết thúc vì nó\n[01:32.72] Anh là kiểu người mà nếu muốn đùa cợt thì nhanh\n[01:35.28] Nhưng để ngồi xuống nói chuyện mở lòng thực sự thì khó\n[01:37.45] Chắc là anh không giỏi chuyện đó, anh vô thức giấu hết đi\n[01:40.31] Anh vô thức giấu hết đi vào trong hố đen những luồng suy nghĩ\n[01:43.17] Và em là người đầu tiên dạy anh nghĩ gì phải nói ra\n[01:45.87] Nhưng nhiều lúc nói tự nhiên cổ họng của anh bị nghẹn và\n[01:48.25] Não không nghĩ được gì cả, cảm giác đấy khá kì lạ\n[01:51.06] Cảm giác như không sắp xếp được đúng suy nghĩ để cho mình tả\n[01:53.75] Lớn lên anh nhận ra mở lòng là kĩ năng\n[01:56.15] Anh nghĩ EQ anh chưa cao và anh chưa thực sự chín chắn, ah\n[01:59.25] Đôi nào chả có cãi vã khi căng thẳng tăng dần lên\n[02:01.92] Sẽ có những chủ đề thực sự nhạy cảm nếu như đề cập đến\n[02:04.68] Nhưng cho đến cuối em vẫn bình tĩnh nghe anh (nghe)\n[02:07.43] Nói với anh rằng nếu từ đầu anh cho em biết thì mưa giông trong đầu anh sẽ tạnh thôi\n[02:11.46] Ngày trôi, đầu anh trở nên thảnh thơi\n[02:13.62] Anh thấy hạnh phúc khi ở cùng em nhìn mưa bên ngoài rơi\n[02:16.49] Anh chưa bao giờ cảm thấy an toàn và yên tâm như thế\n[02:19.12] Và mình có thể nói chuyện hàng giờ về chỉ một chủ đề\n[02:22.12] You're the only girl showing me the way to love\n[02:24.62] Only one I trust, ain't afraid to tell the world\n[02:27.50] Many things to learn, anh không cần gì hơn\n[02:29.57] Ngoài thấy em ở bên cạnh anh khi anh mở mắt dậy vào sáng sớm, ah\n[02:32.06] Ooh, my love (I'm in love, I'm in love, in love with you)\n[02:34.62] Ooh, my love (yeah) (I'm in love, I'm in love, in love with you)\n[02:37.32] Nơi ấy em chờ (I'm in love, I'm in love, in love with you) (this song's for you)\n[02:40.21] Ở bên bờ, ở bên bờ cùng mong nhớ (ah, ah, ah, ah)\n[02:43.81] (<I'm in love, I'm in love, in love with you>) ooh, my love\n[02:46.59] (<I'm in love, I'm in love, in love with you>) nơi ấy em chờ\n[02:49.21] (<I'm in love, I'm in love, in love with you>) yeah\n[02:51.43] Em vẫn luôn rạng rỡ, gom từng thương nhớ nơi bến bờ (yeah, yeah, yeah, yeah)\n[02:54.65] (<I'm in love, I'm in love, in love with you>) I'm in love with you\n[02:57.65] (<I'm in love, I'm in love>) in love with you, in love (I'm in love, I'm in love, in love with you)\n[03:00.21] (<I'm in love, I'm in love, in love with you>) I'm in love with you (hah)\n[03:04.52] My love ở bên bờ (Low G) (I'm in love, I'm in love, in love with you)\n[03:06.78] Bên bờ có em chờ (and JustaTee) (I'm in love, I'm in love, in love with you)\n[03:09.18] Ooh-ooh-ooh (2025) (I'm in love, I'm in love, in love with you)\n[03:13.00] I'm in love with you, with you, with you
57	9	\N	4	Blue	blue-1792752258691	"Blue" is a song by Canadian singer Yung Kai from his debut studio album Stay with the Ocean, I'll Find You (2025).	\N	PUBLISHED	2026-10-23 03:45:59.614	\N	audio-track-57.mp3	/api/media/stream/audio-track-57.mp3	mp3	214357	cover-track-57.jpg	/api/media/cover/cover-track-57.jpg	0	2026-10-23 03:44:18.693	2026-10-23 03:46:08.526	\N
23	8	\N	8	SAU HÌNH BÓNG ẤY	sau-hinh-bong-ay-1791747777052	\N	\N	REJECTED	\N	Incomplete or placeholder metadata (title, artist or artwork).	audio-track-23.mp3	/api/media/stream/audio-track-23.mp3	mp3	212108	cover-track-23.png	/api/media/cover/cover-track-23.png	0	2026-10-11 12:42:57.053	2026-10-23 05:44:15.242	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...
10	10	\N	1	Nơi Này Có Anh	noi-nay-co-anh	Bản tình ca Pop ngọt ngào, lãng mạn đình đám của Sơn Tùng M-TP.	\N	PUBLISHED	2026-10-09 10:03:23.723	\N	audio-track-10.mp3	/api/media/stream/audio-track-10.mp3	mp3	278282	cover-track-10.webp	/api/media/cover/cover-track-10.webp	45657	2026-10-09 10:03:23.723	2026-10-13 12:25:51.556	[00:29.94] Em là ai từ đâu bước đến nơi đây dịu dàng chân phương (dịu dàng chân phương)\n[00:34.67] Em là ai tựa như ánh nắng ban mai ngọt ngào trong sương (ngọt ngào trong sương)\n[00:40.13] Ngắm em thật lâu, con tim anh yếu mềm\n[00:45.38] Đắm say từ phút đó, từng giây trôi yêu thêm\n[00:50.42] Bao ngày qua bình minh đánh thức xua tan bộn bề nơi anh (bộn bề nơi anh)\n[00:55.45] Bao ngày qua niềm thương nỗi nhớ bay theo bầu trời trong xanh (bầu trời trong xanh)\n[01:01.06] Liếc đôi hàng mi mong manh, anh thẫn thờ\n[01:06.20] Muốn hôn nhẹ mái tóc, bờ môi em, anh mơ\n[01:11.39] Cầm tay anh (anh), dựa vai anh (anh)\n[01:14.10] Kề bên anh, nơi này có anh\n[01:16.09] Gió mang câu tình ca, ngàn ánh sao vụt qua, nhẹ ôm lấy em\n[01:20.45] (Yêu em, thương em, con tim anh chân thành)\n[01:21.78] Cầm tay anh (anh), dựa vai anh (anh)\n[01:24.53] Kề bên anh, nơi này có anh\n[01:26.78] Khép đôi mi thật lâu\n[01:28.25] Nguyện mãi bên cạnh nhau, yêu say đắm như ngày đầu\n[01:31.71] Mùa xuân đến bình yên, cho anh những giấc mơ\n[01:36.95] Hạ lưu giữ ngày mưa, ngọt ngào nên thơ\n[01:42.56] Mùa thu lá vàng rơi, đông sang, anh nhớ em\n[01:47.84] Tình yêu bé nhỏ xin dành tặng riêng em\n[02:03.49] (Yeah)\nCòn đó tiếng nói ấy bên tai vấn vương bao ngày qua\nÁnh mắt bối rối nhớ thương bao ngày qua\nYêu em anh thẫn thờ, con tim bâng khuâng đâu có ngờ\nChẳng bao giờ phải mong chờ, đợi ai trong chiều hoàng hôn mờ\nĐắm chìm hòa vào vần thơ, ngắm nhìn khờ dại mộng mơ\nĐừng bước vội vàng rồi làm ngơ, lạnh lùng đó làm bộ dạng thờ ơ\nNhìn anh đi em nha, hướng nụ cười cho riêng anh nha\nĐơn giản là yêu, con tim anh lên tiếng thôi\nCầm tay anh (anh), dựa vai anh (anh)\nKề bên anh, nơi này có anh\nGió mang câu tình ca, ngàn ánh sao vụt qua, nhẹ ôm lấy em\n(Yêu em, thương em, con tim anh chân thành)\nCầm tay anh (anh), dựa vai anh (anh)\nKề bên anh, nơi này có anh\nKhép đôi mi thật lâu\nNguyện mãi bên cạnh nhau, yêu say đắm như ngày đầu\nMùa xuân đến bình yên, cho anh những giấc mơ\nHạ lưu giữ ngày mưa, ngọt ngào nên thơ\nMùa thu lá vàng rơi, đông sang, anh nhớ em\nTình yêu bé nhỏ xin dành tặng riêng em\nAh-ah-oh-oh-oh-oh-oh-oh-oh, nhớ thương em\nOh-oh-oh-oh-oh-oh-oh-oh-oh, nhớ thương em lắm\nAh, phía sau chân trời\nCó ai băng qua lối về, cùng em đi trên đoạn đường dài\nCầm tay anh (anh), dựa vai anh (anh)\nKề bên anh, nơi này có anh\nGió mang câu tình ca, ngàn ánh sao vụt qua, nhẹ ôm lấy em\n(Yêu em, thương em, con tim anh chân thành)\nCầm tay anh (anh), dựa vai anh (anh)\nKề bên anh, nơi này có anh\nKhép đôi mi thật lâu\nNguyện mãi bên cạnh nhau, yêu say đắm như ngày đầu (oh-oh)\nMùa xuân đến bình yên, cho anh những giấc mơ\nHạ lưu giữ ngày mưa, ngọt ngào nên thơ\nMùa thu lá vàng rơi, đông sang, anh nhớ em\nTình yêu bé nhỏ xin dành tặng riêng em
21	8	\N	5	Thế Giới Của Anh	the-gioi-cua-anh-1791746960294	Funny music	\N	PUBLISHED	2026-10-23 05:25:58.116	\N	audio-track-21.mp3	/api/media/stream/audio-track-21.mp3	mp3	270620	cover-track-21.png	/api/media/cover/cover-track-21.png	0	2026-10-11 12:29:20.299	2026-10-23 05:26:05.087	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...
15	19	\N	2	LAVIEM	laviem-1791631091415	Funny	\N	PUBLISHED	2026-10-10 04:19:50.896	\N	audio-track-15.mp3	/api/media/stream/audio-track-15.mp3	mp3	187742	cover-track-15.png	/api/media/cover/cover-track-15.png	6	2026-10-10 04:18:11.421	2026-10-10 04:19:55.926	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...
19	8	\N	2	TOP 1	top-1-1791743301344	relaxing music	\N	REJECTED	\N	Unlicensed sample, beat, or suspected copyright infringement.	audio-track-19.mp3	/api/media/stream/audio-track-19.mp3	mp3	187742	cover-track-19.png	/api/media/cover/cover-track-19.png	0	2026-10-11 11:28:21.352	2026-10-11 12:31:14.697	[BÀI HÁT: LAVIEM]\r\nTrình bày: Quang Hùng MasterD, CAPTAIN BOY, Pháp Kiều, CoolKid, Danny Chung\r\n\r\n---\r\n[INTRO]\r\n(Còn cần thiết nữa, nói chi đến đây cũng thừa\r\nRượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa? Lòng nhau mới thấu đây em)\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[VERSE 1]\r\nTa chia tay (Ta chia tay), vì sao em ơi? (Vì sao?)\r\nĐiều này anh muốn hỏi lâu rồi\r\nNhững khung trời kỷ niệm vỡ đôi\r\nCó phải vì một câu anh đã lỡ lời?\r\n(CAPTAIN BOY bay tới đây, yeah)\r\nSau đêm nay (Sau đêm nay), tự ta cho ta (Tự ta cho ta)\r\nEm và anh một đoạn kết mới\r\nDù rằng mình còn yêu nhau rất nhiều đấy\r\nNhưng để ở lại thì anh nghĩ là không\r\n\r\n[PRE-CHORUS]\r\nVà sau những cảm xúc nhất thời\r\nNgười bên em giờ này chẳng còn là anh\r\nGửi lại quá khứ, cung đàn đã vỡ\r\nVì những vấn vương ấy chưa kịp thành lời...\r\n\r\n[CHORUS]\r\nTrái tim anh chẳng còn cần thiết nữa\r\nNói chi đến đây cũng thừa, rượu vang pha với cơn mưa\r\nHàng trăm lý do cũng chẳng thể cứu vãn\r\nBiết sao hết cho vừa lòng nhau mới thấu đây em?\r\nDệt hàng triệu vết thương, tự vùi mình trước gương\r\nNhìn một người đã từng thương sao nay xa lạ đến bất thường?\r\nCố gắng cũng chỉ bằng không, nước mắt ngược dòng\r\nChảy ngược tận sâu bên trong, nghẹn đắng nơi lồng ngực\r\n\r\n[BRIDGE (Pháp Kiều - Japanese)]\r\nKono yo ni wa mō imi nante nai\r\nNiji-san, sayonara\r\nHikari ga areba kake, yami mo aru\r\n\r\n[POST-CHORUS / HOOK]\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, e-em\r\nKẻ ngốc đang say tình dưới ngọn đèn\r\nTất cả là tại vì em, em, em, em, em, e-em (Baby)\r\nNgười xa lạ anh từng quen\r\nTất cả là tại vì em, em, em, em, em, yeah-eh...\r\n\r\n[OUTRO]\r\nTất cả là tại vì em...
\.


--
-- Data for Name: user_profiles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_profiles (user_id, username, display_name, bio, avatar_public_id, avatar_url, date_of_birth, country_code, created_at, updated_at) FROM stdin;
4	admin	System Administrator	\N	\N	\N	\N	\N	2026-11-05 07:58:13.865	2026-11-05 07:58:13.865
5	staff	Content Moderator	\N	\N	\N	\N	\N	2026-11-05 07:58:14.179	2026-11-05 07:58:14.179
18	yamazaki	Masayoshi Yamazaki	Veteran Japanese singer-songwriter celebrated for the iconic theme 'One more time, One more chance'.	avatar-user-18.webp	/api/media/avatar/avatar-user-18.webp	\N	VN	2026-11-08 13:10:31.412	2026-11-11 22:39:07.463
19	lowg	Low G	Rapper thuộc Rapital, được mệnh danh là 'chủ tọa' với phong cách flow mượt mà đặc trưng.	avatar-user-19.webp	/api/media/avatar/avatar-user-19.webp	\N	VN	2026-11-08 13:10:31.567	2026-11-11 22:39:07.464
20	minhan	Minh An	Acoustic and Indie pop artist crafting gentle, soulful melodies for quiet contemplation.	avatar-user-20.jpg	/api/media/avatar/avatar-user-20.jpg	\N	VN	2026-11-08 13:10:31.682	2026-11-11 22:39:07.464
3	lehaiduy	Lê Hải Duy	Creator & Music Producer on MagiSound.	avatar-user-3.jpg	/api/media/avatar/avatar-user-3.jpg	\N	VN	2026-11-08 13:10:31.772	2026-11-11 22:39:07.465
7	thienphuc	Thiên Phúc	Creator & Music Artist on MagiSound.	avatar-user-7.jpg	/api/media/avatar/avatar-user-7.jpg	\N	VN	2026-11-08 13:10:31.928	2026-11-11 22:39:07.465
8	minhtri	Minh Trí	Producer & Sound Designer on MagiSound.	avatar-user-8.jpg	/api/media/avatar/avatar-user-8.jpg	\N	VN	2026-11-08 13:10:32.024	2026-11-11 22:39:07.466
9	anhtuan	Anh Tuấn	Indie Beatmaker & Audio Engineer.	avatar-user-9.jpg	/api/media/avatar/avatar-user-9.jpg	\N	VN	2026-11-08 13:10:32.159	2026-11-11 22:39:07.467
10	sontungmtp	Sơn Tùng M-TP	Ca sĩ, nhạc sĩ, nhà sản xuất âm nhạc V-Pop hàng đầu. Founder M-TP Entertainment.	avatar-user-10.webp	/api/media/avatar/avatar-user-10.webp	\N	VN	2026-11-08 13:10:30.38	2026-11-11 22:39:07.457
11	hieuthuhai	HIEUTHUHAI	Rapper thành viên nhóm nhạc GERDNANG. Chủ nhân album thành công 'Ai Cũng Phải Bắt Đầu Từ Đâu Đó'.	avatar-user-11.webp	/api/media/avatar/avatar-user-11.webp	\N	VN	2026-11-08 13:10:30.54	2026-11-11 22:39:07.458
12	mck99	MCK	Rapper, ca sĩ, nhạc sĩ thuộc tổ đội RPT. Chủ nhân album đình đám '99%'.	avatar-user-12.webp	/api/media/avatar/avatar-user-12.webp	\N	VN	2026-11-08 13:10:30.638	2026-11-11 22:39:07.459
13	uyenlinh	Uyên Linh	Nữ ca sĩ sở hữu giọng hát nội lực, truyền cảm với các bản hit Ballad da diết.	avatar-user-13.webp	/api/media/avatar/avatar-user-13.webp	\N	VN	2026-11-08 13:10:30.756	2026-11-11 22:39:07.46
14	hngle	Hngle	Nghệ sĩ Indie R&B trẻ với màu sắc âm nhạc hiện đại, cảm xúc và bay bổng.	avatar-user-14.webp	/api/media/avatar/avatar-user-14.webp	\N	VN	2026-11-08 13:10:30.868	2026-11-11 22:39:07.461
15	yoasobi	YOASOBI	Japanese music superduo composed of producer Ayase and vocalist ikura, turning novels into music.	avatar-user-15.webp	/api/media/avatar/avatar-user-15.webp	\N	VN	2026-11-08 13:10:30.977	2026-11-11 22:39:07.462
16	yorushika	Yorushika	Japanese rock duo consisting of producer n-buna and vocalist suis. Creators of nostalgic melodic themes.	avatar-user-16.webp	/api/media/avatar/avatar-user-16.webp	\N	VN	2026-11-08 13:10:31.106	2026-11-11 22:39:07.462
21	staff_soundwave	Moderation Staff	\N	\N	\N	\N	\N	2026-11-11 19:10:10.848	2026-11-11 19:10:10.848
22	admin_soundwave	System Administrator	\N	\N	\N	\N	\N	2026-11-11 19:10:10.848	2026-11-11 19:10:10.848
17	yokotakahashi	Yoko Takahashi	Legendary Japanese singer acclaimed for performing the theme songs of Neon Genesis Evangelion.	avatar-user-17.webp	/api/media/avatar/avatar-user-17.webp	\N	VN	2026-11-08 13:10:31.245	2026-11-11 22:39:07.463
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, email, password_hash, status, email_verified_at, last_login_at, deleted_at, created_at, updated_at, locked_until) FROM stdin;
24	minhduc.chill@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
25	baotram.music@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
5	listener.test@gmail.com	$2a$10$smPHQrUMX2QksGRg5ypptumAHqwHuneDBoOvY3bC7ZpySe/vI8SXy	ACTIVE	\N	\N	\N	2026-10-09 06:22:11.396	2026-10-09 06:22:11.396	\N
15	yoasobi@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	2026-10-13 08:11:06.281	\N	2026-10-13 15:04:04.013	2026-10-13 08:11:06.281	\N
4	tuantace201233@gmail.com	$2a$10$Eew3S4KHhCUotbqC9SgP3OM1rVhQl9VYzAz1Qcf57a2laNm6Uqn3i	ACTIVE	2026-10-09 06:16:20.48	2026-10-13 05:37:25.81	\N	2026-10-09 06:15:51.293	2026-10-13 05:37:25.81	\N
7	dotranthienphuc230@gmail.com	$2a$10$lIb0PDasweSn2jTgy3Afheal1uCZ2SBI4nFzieQsQ8WaZbBq7ZIY6	ACTIVE	2026-10-09 07:13:33.114	2026-10-27 18:05:27.375	\N	2026-10-09 07:13:12.81	2026-10-27 18:05:27.446	\N
10	sontungmtp@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	2026-10-31 02:03:31.404	\N	2026-10-13 15:04:04.013	2026-10-31 02:03:31.693	\N
8	minhtriojt@gmail.com	$2a$10$ihGJULMcEGY0iY.Dc/DnO.wCGE.pv5hAeEt2emPrg7BaFSyMSB3pe	ACTIVE	2026-10-09 22:59:05.159	2026-10-31 02:13:08.971	\N	2026-10-09 22:58:12.741	2026-10-31 02:13:09.081	\N
6	haotntce200338@gmail.com	$2a$10$BuvfPsHK7K08MIEDltSnlOaxV9.yxDp9UrJJfk7bMQbrkUAlN6Tkm	ACTIVE	2026-10-09 06:23:12.264	2026-10-23 04:48:40.826	\N	2026-10-09 06:22:54.239	2026-10-23 04:48:41.06	\N
3	lehaiduy1900@gmail.com	$2a$10$0gOv7O05thBZLs/mYHaYB.Tr2DyOKhELyww3kfYBMrQ7G2GnNusSu	ACTIVE	2026-10-09 05:53:40.056	2026-10-13 11:19:10.244	\N	2026-10-09 05:53:10.389	2026-10-13 11:19:10.244	\N
11	hieuthuhai@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
12	mck@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
13	uyenlinh@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
14	hngle@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
16	yorushika@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
17	yokotakahashi@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
18	yamazaki@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
19	lowg@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
20	minhan.creator@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
21	lananh.listener@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
22	quanghuy.rap@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
23	yuki.anime@soundwave.io	$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM.	ACTIVE	2026-10-13 15:04:04.013	\N	\N	2026-10-13 15:04:04.013	2026-10-13 15:04:04.013	\N
9	truonganhtuan04072020@gmail.com	$2a$10$aNvzQW3jPTFjF./v3GEfu.Eq/ci9c/M7mU2rDOiLPf7rXU3AAF3Jq	ACTIVE	2026-10-13 05:40:41.778	2026-10-31 02:28:49.32	\N	2026-10-13 05:40:15.607	2026-10-31 02:28:49.858	\N
\.


--
-- Name: account_unlock_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.account_unlock_tokens_id_seq', 1, true);


--
-- Name: albums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.albums_id_seq', 16, true);


--
-- Name: app_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.app_users_id_seq', 22, true);


--
-- Name: app_users_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.app_users_id_seq1', 22, true);


--
-- Name: content_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.content_reports_id_seq', 1, true);


--
-- Name: email_verification_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.email_verification_tokens_id_seq', 6, true);


--
-- Name: genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.genres_id_seq', 8, true);


--
-- Name: listening_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.listening_history_id_seq', 187, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_id_seq', 120, true);


--
-- Name: official_lyrics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.official_lyrics_id_seq', 18, true);


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.password_reset_tokens_id_seq', 1, true);


--
-- Name: personal_lyrics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.personal_lyrics_id_seq', 18, true);


--
-- Name: playlist_tracks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.playlist_tracks_id_seq', 79, true);


--
-- Name: playlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.playlists_id_seq', 17, true);


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 1540, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 9, true);


--
-- Name: staff_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.staff_roles_id_seq', 2, true);


--
-- Name: staffs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.staffs_id_seq', 2, true);


--
-- Name: system_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.system_reviews_id_seq', 5, true);


--
-- Name: track_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.track_submissions_id_seq', 71, true);


--
-- Name: tracks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tracks_id_seq', 69, true);


--
-- Name: account_unlock_tokens account_unlock_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account_unlock_tokens
    ADD CONSTRAINT account_unlock_tokens_pkey PRIMARY KEY (id);


--
-- Name: app_users app_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_pkey PRIMARY KEY (id);


--
-- Name: albums pk_albums; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT pk_albums PRIMARY KEY (id);


--
-- Name: users pk_app_users; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT pk_app_users PRIMARY KEY (id);


--
-- Name: content_reports pk_content_reports; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_reports
    ADD CONSTRAINT pk_content_reports PRIMARY KEY (id);


--
-- Name: email_verification_tokens pk_email_verification_tokens; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_verification_tokens
    ADD CONSTRAINT pk_email_verification_tokens PRIMARY KEY (id);


--
-- Name: favorites pk_favorites; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT pk_favorites PRIMARY KEY (user_id, track_id);


--
-- Name: genres pk_genres; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT pk_genres PRIMARY KEY (id);


--
-- Name: listening_history pk_listening_history; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listening_history
    ADD CONSTRAINT pk_listening_history PRIMARY KEY (id);


--
-- Name: notifications pk_notifications; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT pk_notifications PRIMARY KEY (id);


--
-- Name: official_lyrics pk_official_lyrics; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.official_lyrics
    ADD CONSTRAINT pk_official_lyrics PRIMARY KEY (id);


--
-- Name: password_reset_tokens pk_password_reset_tokens; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT pk_password_reset_tokens PRIMARY KEY (id);


--
-- Name: personal_lyrics pk_personal_lyrics; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_lyrics
    ADD CONSTRAINT pk_personal_lyrics PRIMARY KEY (id);


--
-- Name: playlist_tracks pk_playlist_tracks; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlist_tracks
    ADD CONSTRAINT pk_playlist_tracks PRIMARY KEY (playlist_id, track_id);


--
-- Name: playlists pk_playlists; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT pk_playlists PRIMARY KEY (id);


--
-- Name: refresh_tokens pk_refresh_tokens; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT pk_refresh_tokens PRIMARY KEY (id);


--
-- Name: system_reviews pk_system_reviews; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_reviews
    ADD CONSTRAINT pk_system_reviews PRIMARY KEY (id);


--
-- Name: track_submissions pk_track_submissions; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_submissions
    ADD CONSTRAINT pk_track_submissions PRIMARY KEY (id);


--
-- Name: tracks pk_tracks; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tracks
    ADD CONSTRAINT pk_tracks PRIMARY KEY (id);


--
-- Name: user_profiles pk_user_profiles; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT pk_user_profiles PRIMARY KEY (user_id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: staff_roles staff_roles_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff_roles
    ADD CONSTRAINT staff_roles_code_key UNIQUE (code);


--
-- Name: staff_roles staff_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff_roles
    ADD CONSTRAINT staff_roles_pkey PRIMARY KEY (id);


--
-- Name: staffs staffs_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staffs
    ADD CONSTRAINT staffs_email_key UNIQUE (email);


--
-- Name: staffs staffs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: app_users uk4vj92ux8a2eehds1mdvmks473; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT uk4vj92ux8a2eehds1mdvmks473 UNIQUE (email);


--
-- Name: playlist_tracks uk_playlist_track; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlist_tracks
    ADD CONSTRAINT uk_playlist_track UNIQUE (playlist_id, track_id);


--
-- Name: playlists ukbq229u3bbkas0bmcvn265p3b2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT ukbq229u3bbkas0bmcvn265p3b2 UNIQUE (slug);


--
-- Name: roles ukch1113horj4qr56f91omojv8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT ukch1113horj4qr56f91omojv8 UNIQUE (code);


--
-- Name: albums uq_albums_slug; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT uq_albums_slug UNIQUE (slug);


--
-- Name: users uq_app_users_email; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uq_app_users_email UNIQUE (email);


--
-- Name: email_verification_tokens uq_email_verification_tokens_hash; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_verification_tokens
    ADD CONSTRAINT uq_email_verification_tokens_hash UNIQUE (token_hash);


--
-- Name: genres uq_genres_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT uq_genres_name UNIQUE (name);


--
-- Name: genres uq_genres_slug; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT uq_genres_slug UNIQUE (slug);


--
-- Name: official_lyrics uq_official_lyrics_track; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.official_lyrics
    ADD CONSTRAINT uq_official_lyrics_track UNIQUE (track_id);


--
-- Name: password_reset_tokens uq_password_reset_tokens_hash; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT uq_password_reset_tokens_hash UNIQUE (token_hash);


--
-- Name: personal_lyrics uq_personal_lyrics_user_track_type; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_lyrics
    ADD CONSTRAINT uq_personal_lyrics_user_track_type UNIQUE (user_id, track_id, lyric_type);


--
-- Name: playlist_tracks uq_playlist_tracks_position; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlist_tracks
    ADD CONSTRAINT uq_playlist_tracks_position UNIQUE (playlist_id, "position");


--
-- Name: refresh_tokens uq_refresh_tokens_hash; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT uq_refresh_tokens_hash UNIQUE (token_hash);


--
-- Name: tracks uq_tracks_slug; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tracks
    ADD CONSTRAINT uq_tracks_slug UNIQUE (slug);


--
-- Name: user_profiles uq_user_profiles_username; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT uq_user_profiles_username UNIQUE (username);


--
-- Name: idx_notifications_staff_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_staff_created ON public.notifications USING btree (staff_id, created_at DESC);


--
-- Name: idx_notifications_user_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_user_created ON public.notifications USING btree (user_id, created_at DESC);


--
-- Name: ix_albums_created_by_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_albums_created_by_user_id ON public.albums USING btree (created_by_user_id, status);


--
-- Name: ix_app_users_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_app_users_status ON public.users USING btree (status) WHERE (deleted_at IS NULL);


--
-- Name: ix_content_reports_moderation_queue; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_content_reports_moderation_queue ON public.content_reports USING btree (status, created_at) INCLUDE (track_id, submitted_by_user_id, category);


--
-- Name: ix_content_reports_submitter; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_content_reports_submitter ON public.content_reports USING btree (submitted_by_user_id, created_at DESC);


--
-- Name: ix_email_verification_tokens_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_email_verification_tokens_user_id ON public.email_verification_tokens USING btree (user_id, expires_at);


--
-- Name: ix_favorites_track_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_favorites_track_id ON public.favorites USING btree (track_id);


--
-- Name: ix_listening_history_user_played_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_listening_history_user_played_at ON public.listening_history USING btree (user_id, played_at DESC) INCLUDE (track_id, listened_duration_ms, completed);


--
-- Name: ix_notifications_user_unread; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_notifications_user_unread ON public.notifications USING btree (user_id, read_at, created_at DESC);


--
-- Name: ix_password_reset_tokens_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_password_reset_tokens_user_id ON public.password_reset_tokens USING btree (user_id, expires_at);


--
-- Name: ix_personal_lyrics_user_track; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_personal_lyrics_user_track ON public.personal_lyrics USING btree (user_id, track_id);


--
-- Name: ix_playlist_tracks_track_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_playlist_tracks_track_id ON public.playlist_tracks USING btree (track_id);


--
-- Name: ix_playlists_owner_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_playlists_owner_user_id ON public.playlists USING btree (owner_user_id, updated_at DESC);


--
-- Name: ix_playlists_public; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_playlists_public ON public.playlists USING btree (visibility, updated_at DESC) WHERE ((visibility)::text = 'PUBLIC'::text);


--
-- Name: ix_refresh_tokens_active_by_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_refresh_tokens_active_by_user ON public.refresh_tokens USING btree (user_id, expires_at) WHERE (revoked_at IS NULL);


--
-- Name: ix_system_reviews_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_system_reviews_status ON public.system_reviews USING btree (status, created_at DESC);


--
-- Name: ix_system_reviews_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_system_reviews_user_id ON public.system_reviews USING btree (user_id, created_at DESC);


--
-- Name: ix_track_submissions_moderation_queue; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_track_submissions_moderation_queue ON public.track_submissions USING btree (status, submitted_at) INCLUDE (track_id, submitted_by_user_id, reviewer_user_id);


--
-- Name: ix_tracks_album_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_tracks_album_id ON public.tracks USING btree (album_id, track_number);


--
-- Name: ix_tracks_public_catalog; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_tracks_public_catalog ON public.tracks USING btree (publication_status, genre_id, created_at DESC) INCLUDE (title, slug, uploader_user_id, album_id, cover_url, duration_ms, play_count_cache);


--
-- Name: ix_tracks_uploader_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_tracks_uploader_user_id ON public.tracks USING btree (uploader_user_id, publication_status, created_at DESC);


--
-- Name: ux_track_submissions_one_pending_per_track; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ux_track_submissions_one_pending_per_track ON public.track_submissions USING btree (track_id) WHERE ((status)::text = 'PENDING'::text);


--
-- Name: account_unlock_tokens account_unlock_tokens_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account_unlock_tokens
    ADD CONSTRAINT account_unlock_tokens_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staffs(id);


--
-- Name: email_verification_tokens fk3p1m42k50qhjbo815nl38nfby; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_verification_tokens
    ADD CONSTRAINT fk3p1m42k50qhjbo815nl38nfby FOREIGN KEY (user_id) REFERENCES public.app_users(id);


--
-- Name: app_users fk7sipqsfa0da9aj10gga1iqnk1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT fk7sipqsfa0da9aj10gga1iqnk1 FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: albums fk_albums_created_by_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT fk_albums_created_by_app_users FOREIGN KEY (created_by_user_id) REFERENCES public.users(id);


--
-- Name: content_reports fk_content_reports_handler_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_reports
    ADD CONSTRAINT fk_content_reports_handler_app_users FOREIGN KEY (handled_by_user_id) REFERENCES public.app_users(id);


--
-- Name: content_reports fk_content_reports_submitter_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_reports
    ADD CONSTRAINT fk_content_reports_submitter_app_users FOREIGN KEY (submitted_by_user_id) REFERENCES public.users(id);


--
-- Name: content_reports fk_content_reports_tracks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_reports
    ADD CONSTRAINT fk_content_reports_tracks FOREIGN KEY (track_id) REFERENCES public.tracks(id);


--
-- Name: email_verification_tokens fk_email_verification_tokens_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_verification_tokens
    ADD CONSTRAINT fk_email_verification_tokens_app_users FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: favorites fk_favorites_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT fk_favorites_app_users FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: favorites fk_favorites_tracks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT fk_favorites_tracks FOREIGN KEY (track_id) REFERENCES public.tracks(id);


--
-- Name: genres fk_genres_created_by_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT fk_genres_created_by_app_users FOREIGN KEY (created_by_user_id) REFERENCES public.users(id);


--
-- Name: listening_history fk_listening_history_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listening_history
    ADD CONSTRAINT fk_listening_history_app_users FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: listening_history fk_listening_history_tracks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listening_history
    ADD CONSTRAINT fk_listening_history_tracks FOREIGN KEY (track_id) REFERENCES public.tracks(id);


--
-- Name: notifications fk_notifications_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_app_users FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: official_lyrics fk_official_lyrics_tracks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.official_lyrics
    ADD CONSTRAINT fk_official_lyrics_tracks FOREIGN KEY (track_id) REFERENCES public.tracks(id) ON DELETE CASCADE;


--
-- Name: password_reset_tokens fk_password_reset_tokens_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT fk_password_reset_tokens_app_users FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: personal_lyrics fk_personal_lyrics_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_lyrics
    ADD CONSTRAINT fk_personal_lyrics_app_users FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: personal_lyrics fk_personal_lyrics_tracks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_lyrics
    ADD CONSTRAINT fk_personal_lyrics_tracks FOREIGN KEY (track_id) REFERENCES public.tracks(id) ON DELETE CASCADE;


--
-- Name: playlist_tracks fk_playlist_tracks_added_by_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlist_tracks
    ADD CONSTRAINT fk_playlist_tracks_added_by_app_users FOREIGN KEY (added_by_user_id) REFERENCES public.users(id);


--
-- Name: playlist_tracks fk_playlist_tracks_playlists; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlist_tracks
    ADD CONSTRAINT fk_playlist_tracks_playlists FOREIGN KEY (playlist_id) REFERENCES public.playlists(id) ON DELETE CASCADE;


--
-- Name: playlist_tracks fk_playlist_tracks_tracks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlist_tracks
    ADD CONSTRAINT fk_playlist_tracks_tracks FOREIGN KEY (track_id) REFERENCES public.tracks(id) ON DELETE CASCADE;


--
-- Name: playlists fk_playlists_owner_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT fk_playlists_owner_app_users FOREIGN KEY (owner_user_id) REFERENCES public.users(id);


--
-- Name: refresh_tokens fk_refresh_tokens_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT fk_refresh_tokens_app_users FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: system_reviews fk_system_reviews_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_reviews
    ADD CONSTRAINT fk_system_reviews_app_users FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: track_submissions fk_track_submissions_reviewer_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_submissions
    ADD CONSTRAINT fk_track_submissions_reviewer_app_users FOREIGN KEY (reviewer_user_id) REFERENCES public.app_users(id);


--
-- Name: track_submissions fk_track_submissions_submitter_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_submissions
    ADD CONSTRAINT fk_track_submissions_submitter_app_users FOREIGN KEY (submitted_by_user_id) REFERENCES public.users(id);


--
-- Name: track_submissions fk_track_submissions_tracks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_submissions
    ADD CONSTRAINT fk_track_submissions_tracks FOREIGN KEY (track_id) REFERENCES public.tracks(id);


--
-- Name: tracks fk_tracks_albums; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tracks
    ADD CONSTRAINT fk_tracks_albums FOREIGN KEY (album_id) REFERENCES public.albums(id) ON DELETE SET NULL;


--
-- Name: tracks fk_tracks_genres; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tracks
    ADD CONSTRAINT fk_tracks_genres FOREIGN KEY (genre_id) REFERENCES public.genres(id);


--
-- Name: tracks fk_tracks_uploader_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tracks
    ADD CONSTRAINT fk_tracks_uploader_app_users FOREIGN KEY (uploader_user_id) REFERENCES public.users(id);


--
-- Name: user_profiles fk_user_profiles_app_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT fk_user_profiles_app_users FOREIGN KEY (user_id) REFERENCES public.app_users(id) ON DELETE CASCADE;


--
-- Name: account_unlock_tokens fka3fpk5xbjuof254bc5skirifc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account_unlock_tokens
    ADD CONSTRAINT fka3fpk5xbjuof254bc5skirifc FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: official_lyrics fkaapwxgur5skqdrnov9ldxgq9o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.official_lyrics
    ADD CONSTRAINT fkaapwxgur5skqdrnov9ldxgq9o FOREIGN KEY (created_by_user_id) REFERENCES public.staffs(id);


--
-- Name: password_reset_tokens fkk4vaguhrxs5jl3lqtshglaxo8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT fkk4vaguhrxs5jl3lqtshglaxo8 FOREIGN KEY (user_id) REFERENCES public.app_users(id);


--
-- Name: refresh_tokens fkt72gijoak5yufxws745gwflis; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT fkt72gijoak5yufxws745gwflis FOREIGN KEY (user_id) REFERENCES public.app_users(id);


--
-- Name: notifications notifications_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staffs(id);


--
-- Name: password_reset_tokens password_reset_tokens_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staffs(id);


--
-- Name: refresh_tokens refresh_tokens_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staffs(id);


--
-- Name: staffs staffs_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staffs
    ADD CONSTRAINT staffs_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.staff_roles(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 5zbmZ1MlTgyEtrLioss3RaR3qe4QDAaInNyHIjfTRGI5sIfd9HBXSEbkMCjmEj3

