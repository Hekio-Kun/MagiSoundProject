package group03.magisound.media.service;

import group03.magisound.media.dto.response.StoredAudioResponse;
import group03.magisound.media.dto.response.StoredMediaResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

/**
 * Service lưu trữ media đám mây/máy chủ (UC-11.2, UC-14).
 * Cung cấp API upload/xóa media tương thích hoàn toàn với đặc tả Sequence Diagram.
 */
@Service
@RequiredArgsConstructor
public class CloudMediaService {

    private final InternalMediaService internalMediaService;

    public StoredMediaResponse uploadAvatar(MultipartFile file, Long userId) {
        return internalMediaService.uploadAvatar(file, userId);
    }

    public StoredAudioResponse uploadTrackAudio(MultipartFile file, Long userId) {
        return internalMediaService.uploadTrackAudio(file, userId);
    }

    public StoredMediaResponse uploadTrackCover(MultipartFile file, Long userId) {
        return internalMediaService.uploadTrackCover(file, userId);
    }

    public StoredMediaResponse uploadPlaylistCover(MultipartFile file, Long userId) {
        return internalMediaService.uploadPlaylistCover(file, userId);
    }

    public void deleteImageQuietly(String publicId) {
        internalMediaService.deleteImageQuietly(publicId);
    }

    public void deleteTrackAudioQuietly(String publicId) {
        internalMediaService.deleteTrackAudioQuietly(publicId);
    }
}
