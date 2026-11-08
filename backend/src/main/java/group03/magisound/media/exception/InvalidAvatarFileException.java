package group03.magisound.media.exception;

public class InvalidAvatarFileException extends MediaException {
    public InvalidAvatarFileException() {
        super("INVALID_AVATAR_FILE", "Avatar must be in JPG/PNG format and under 5MB.");
    }

    public InvalidAvatarFileException(String message) {
        super("INVALID_AVATAR_FILE", message);
    }
}
