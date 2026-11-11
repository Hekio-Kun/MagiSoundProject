package group03.magisound.media.service;

import group03.magisound.media.exception.MediaException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.Arrays;

/**
 * Service đọc trực tiếp byte range của tệp âm thanh theo đặc tả UC-09 (Play Music) và UC-10 (Control Playback).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ServerStorageService {

    private final InternalMediaService internalMediaService;

    /**
     * Đọc một đoạn byte theo rangeHeader/offset để phục vụ HTTP 206 Partial Content.
     *
     * @param filename Tên file âm thanh hoặc public ID
     * @param start    Vị trí byte bắt đầu
     * @param end      Vị trí byte kết thúc (inclusive)
     * @return Mảng byte chứa dữ liệu âm thanh tương ứng
     */
    public byte[] readByteRange(String filename, long start, long end) {
        if (filename == null || filename.isBlank()) {
            throw new MediaException("Audio filename cannot be blank");
        }

        // If full URL or path was passed, extract basename
        String actualFilename = filename;
        if (actualFilename.contains("/")) {
            actualFilename = actualFilename.substring(actualFilename.lastIndexOf('/') + 1);
        }

        try {
            Resource resource = internalMediaService.loadAudioResource(actualFilename);
            long contentLength = resource.contentLength();
            if (start >= contentLength) {
                return new byte[0];
            }

            long targetEnd = Math.min(end, contentLength - 1);
            int length = (int) (targetEnd - start + 1);
            byte[] buffer = new byte[length];

            try (InputStream is = resource.getInputStream()) {
                long skipped = is.skip(start);
                if (skipped < start) {
                    log.warn("Skipped bytes {} less than requested start {}", skipped, start);
                }
                int bytesRead = 0;
                while (bytesRead < length) {
                    int read = is.read(buffer, bytesRead, length - bytesRead);
                    if (read == -1) break;
                    bytesRead += read;
                }
                if (bytesRead < length) {
                    buffer = Arrays.copyOf(buffer, bytesRead);
                }
            }
            return buffer;
        } catch (Exception e) {
            log.error("Failed to read byte range for file {}: {}", actualFilename, e.getMessage());
            throw new MediaException("Failed to read audio byte range: " + e.getMessage(), e);
        }
    }

    public Resource loadAudioResource(String filename) {
        String actualFilename = filename;
        if (actualFilename.contains("/")) {
            actualFilename = actualFilename.substring(actualFilename.lastIndexOf('/') + 1);
        }
        return internalMediaService.loadAudioResource(actualFilename);
    }
}
