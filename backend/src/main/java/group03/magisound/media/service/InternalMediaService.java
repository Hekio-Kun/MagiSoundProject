package group03.magisound.media.service;

import group03.magisound.media.dto.response.StoredAudioResponse;
import group03.magisound.media.dto.response.StoredMediaResponse;
import group03.magisound.media.exception.InvalidAvatarFileException;
import group03.magisound.media.exception.InvalidTrackAudioException;
import group03.magisound.media.exception.InvalidTrackCoverException;
import group03.magisound.media.exception.MediaException;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Slf4j
@Service
public class InternalMediaService {

    private static final long MAX_AVATAR_SIZE = 5L * 1024 * 1024;
    private static final long MAX_TRACK_AUDIO_SIZE = 50L * 1024 * 1024;
    private static final long MAX_TRACK_COVER_SIZE = 10L * 1024 * 1024;

    private static final byte[] PNG_SIGNATURE = {(byte) 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A};

    @Value("${app.storage.upload-dir:./uploads}")
    private String baseUploadDir;

    private Path rootDir;
    private Path audiosDir;
    private Path coversDir;
    private Path avatarsDir;

    @PostConstruct
    public void init() {
        try {
            this.rootDir = Paths.get(baseUploadDir).toAbsolutePath().normalize();
            this.audiosDir = rootDir.resolve("tracks");
            this.coversDir = rootDir.resolve("covers");
            this.avatarsDir = rootDir.resolve("avatars");

            Files.createDirectories(this.audiosDir);
            Files.createDirectories(this.coversDir);
            Files.createDirectories(this.avatarsDir);
            log.info("Initialized MagiSound local media storage directories at: {}", rootDir);
        } catch (IOException e) {
            throw new RuntimeException("Could not initialize local storage folders: " + e.getMessage(), e);
        }
    }

    public StoredMediaResponse uploadAvatar(MultipartFile file, Long userId) {
        byte[] content = readValidAvatar(file);
        String ext = detectImageExtension(content, file.getOriginalFilename());
        String filename = "avatar-user-" + userId + "-" + UUID.randomUUID() + "." + ext;
        saveFile(avatarsDir, filename, content);
        String url = "/api/media/avatar/" + filename;
        return new StoredMediaResponse(filename, url);
    }

    public StoredAudioResponse uploadTrackAudio(MultipartFile file, Long userId) {
        byte[] content = readValidTrackAudio(file);
        String format = detectAudioFormat(content);
        String filename = "audio-user-" + userId + "-" + UUID.randomUUID() + "." + format;
        saveFile(audiosDir, filename, content);
        String url = "/api/media/stream/" + filename;
        Integer durationMs = estimateDurationMs(content, format);
        return new StoredAudioResponse(filename, url, format, durationMs);
    }

    public StoredMediaResponse uploadTrackCover(MultipartFile file, Long userId) {
        byte[] content = readValidTrackCover(file);
        String ext = detectImageExtension(content, file.getOriginalFilename());
        String filename = "cover-user-" + userId + "-" + UUID.randomUUID() + "." + ext;
        saveFile(coversDir, filename, content);
        String url = "/api/media/cover/" + filename;
        return new StoredMediaResponse(filename, url);
    }

    public StoredMediaResponse uploadPlaylistCover(MultipartFile file, Long userId) {
        return uploadTrackCover(file, userId);
    }

    public void deleteImageQuietly(String publicId) {
        if (publicId == null || publicId.isBlank()) return;
        deleteQuietly(coversDir.resolve(publicId));
        deleteQuietly(avatarsDir.resolve(publicId));
    }

    public void deleteTrackAudioQuietly(String publicId) {
        if (publicId == null || publicId.isBlank()) return;
        deleteQuietly(audiosDir.resolve(publicId));
    }

    public Resource loadAudioResource(String filename) {
        return loadResource(audiosDir.resolve(filename));
    }

    public Resource loadCoverResource(String filename) {
        return loadResource(coversDir.resolve(filename));
    }

    public Resource loadAvatarResource(String filename) {
        return loadResource(avatarsDir.resolve(filename));
    }

    private Resource loadResource(Path filePath) {
        try {
            Resource resource = new UrlResource(filePath.toUri());
            if (resource.exists() && resource.isReadable()) {
                return resource;
            }
            throw new MediaException("File not found or unreadable: " + filePath.getFileName());
        } catch (MalformedURLException e) {
            throw new MediaException("Malformed URL for file: " + filePath.getFileName());
        }
    }

    private void saveFile(Path folder, String filename, byte[] content) {
        try {
            Path target = folder.resolve(filename).normalize();
            Files.write(target, content);
        } catch (IOException e) {
            throw new MediaException("Failed to save media file to internal storage: " + e.getMessage());
        }
    }

    private void deleteQuietly(Path path) {
        try {
            if (Files.exists(path)) {
                Files.delete(path);
            }
        } catch (Exception ignored) {}
    }

    private byte[] readValidAvatar(MultipartFile file) {
        if (file == null || file.isEmpty()) throw new InvalidAvatarFileException("Avatar file is empty");
        if (file.getSize() > MAX_AVATAR_SIZE) throw new InvalidAvatarFileException("Avatar file size exceeds limit (5MB)");
        try {
            byte[] bytes = file.getBytes();
            if (!isPng(bytes) && !isJpeg(bytes) && !isWebp(bytes)) {
                throw new InvalidAvatarFileException("Avatar must be PNG, JPEG, or WebP");
            }
            return bytes;
        } catch (IOException e) {
            throw new InvalidAvatarFileException("Could not read avatar file bytes");
        }
    }

    private byte[] readValidTrackAudio(MultipartFile file) {
        if (file == null || file.isEmpty()) throw new InvalidTrackAudioException("Audio file is empty");
        if (file.getSize() > MAX_TRACK_AUDIO_SIZE) throw new InvalidTrackAudioException("Audio file exceeds limit (50MB)");
        try {
            byte[] bytes = file.getBytes();
            if (!isMp3(bytes) && !isWav(bytes) && !isFlac(bytes)) {
                throw new InvalidTrackAudioException("Audio must be MP3, WAV, or FLAC");
            }
            return bytes;
        } catch (IOException e) {
            throw new InvalidTrackAudioException("Could not read audio bytes");
        }
    }

    private byte[] readValidTrackCover(MultipartFile file) {
        if (file == null || file.isEmpty()) throw new InvalidTrackCoverException("Cover file is empty");
        if (file.getSize() > MAX_TRACK_COVER_SIZE) throw new InvalidTrackCoverException("Cover exceeds limit (10MB)");
        try {
            byte[] bytes = file.getBytes();
            if (!isPng(bytes) && !isJpeg(bytes) && !isWebp(bytes)) {
                throw new InvalidTrackCoverException("Cover must be PNG, JPEG, or WebP");
            }
            return bytes;
        } catch (IOException e) {
            throw new InvalidTrackCoverException("Could not read cover bytes");
        }
    }

    private boolean isPng(byte[] c) {
        if (c.length < 8) return false;
        for (int i = 0; i < 8; i++) {
            if (c[i] != PNG_SIGNATURE[i]) return false;
        }
        return true;
    }

    private boolean isJpeg(byte[] c) {
        return c.length >= 3 && (c[0] & 0xFF) == 0xFF && (c[1] & 0xFF) == 0xD8 && (c[2] & 0xFF) == 0xFF;
    }

    private boolean isWebp(byte[] c) {
        return c.length >= 12 && c[0] == 'R' && c[1] == 'I' && c[2] == 'F' && c[3] == 'F'
                && c[8] == 'W' && c[9] == 'E' && c[10] == 'B' && c[11] == 'P';
    }

    private boolean isMp3(byte[] c) {
        if (c.length < 3) return false;
        if (c[0] == 'I' && c[1] == 'D' && c[2] == '3') return true;
        return (c[0] & 0xFF) == 0xFF && ((c[1] & 0xE0) == 0xE0);
    }

    private boolean isWav(byte[] c) {
        return c.length >= 12 && c[0] == 'R' && c[1] == 'I' && c[2] == 'F' && c[3] == 'F'
                && c[8] == 'W' && c[9] == 'A' && c[10] == 'V' && c[11] == 'E';
    }

    private boolean isFlac(byte[] c) {
        return c.length >= 4 && c[0] == 'f' && c[1] == 'L' && c[2] == 'a' && c[3] == 'C';
    }

    private String detectAudioFormat(byte[] content) {
        if (isWav(content)) return "wav";
        if (isFlac(content)) return "flac";
        return "mp3";
    }

    private String detectImageExtension(byte[] content, String originalFilename) {
        if (isPng(content)) return "png";
        if (isWebp(content)) return "webp";
        return "jpg";
    }

    private Integer estimateDurationMs(byte[] content, String format) {
        // Standard baseline estimate (~192 kbps for MP3, 24 bytes per ms)
        if (content.length > 0) {
            long bytesPerSecond = 24000L;
            long seconds = content.length / bytesPerSecond;
            if (seconds > 0) {
                return (int) Math.min(seconds * 1000, 3600000);
            }
        }
        return 180000; // default 3 minutes
    }
}
