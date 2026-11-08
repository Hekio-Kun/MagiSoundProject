package group03.magisound.exception;

import lombok.Getter;

@Getter
public class ConflictOperationException extends RuntimeException {
    private final String code;

    public ConflictOperationException(String code, String message) {
        super(message);
        this.code = code;
    }

    public ConflictOperationException(String message) {
        super(message);
        this.code = "CONFLICT";
    }
}
