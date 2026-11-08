package group03.magisound.media.exception;

public class InvalidTrackCoverException extends MediaException {
    public InvalidTrackCoverException() {
        super("INVALID_TRACK_COVER", "Cover artwork must be a valid JPG or PNG image under 5MB.");
    }

    public InvalidTrackCoverException(String message) {
        super("INVALID_TRACK_COVER", message);
    }
}
