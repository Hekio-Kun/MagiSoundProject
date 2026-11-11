package group03.magisound.media.service;

import group03.magisound.media.dto.response.StoredAudioResponse;
import group03.magisound.media.dto.response.StoredMediaResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

/**
 * Service quản lý file lưu trữ âm thanh và ảnh bìa bài hát theo đặc tả UC-14 (Upload, Update, Delete Track).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class FileStorageService {

    private final InternalMediaService internalMediaService;

    public StoredAudioResponse saveAudioFile(MultipartFile audioFile, Long userId) {
        return internalMediaService.uploadTrackAudio(audioFile, userId);
    }

    public StoredMediaResponse saveCoverArt(MultipartFile coverArt, Long userId) {
        if (coverArt == null || coverArt.isEmpty()) {
            return null;
        }
        return internalMediaService.uploadTrackCover(coverArt, userId);
    }

    public void deleteMediaFiles(String audioPublicId, String coverPublicId) {
        if (audioPublicId != null && !audioPublicId.isBlank()) {
            internalMediaService.deleteTrackAudioQuietly(audioPublicId);
        }
        if (coverPublicId != null && !coverPublicId.isBlank()) {
            internalMediaService.deleteImageQuietly(coverPublicId);
        }
    }
}
