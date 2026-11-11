package group03.magisound.media.exception;

import lombok.Getter;

@Getter
public class MediaException extends RuntimeException {
    private final String code;

    public MediaException(String message) {
        super(message);
        this.code = "MEDIA_ERROR";
    }

    public MediaException(String message, Throwable cause) {
        super(message, cause);
        this.code = "MEDIA_ERROR";
    }

    public MediaException(String code, String message) {
        super(message);
        this.code = code;
    }
}
