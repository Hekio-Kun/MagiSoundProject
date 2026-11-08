package group03.magisound.authentication.exception;

public class EmailAlreadyExistsException extends AuthenticationException {
    public EmailAlreadyExistsException() {
        super("EMAIL_ALREADY_EXISTS", "An account already uses this email address.");
    }

    public EmailAlreadyExistsException(String message) {
        super("EMAIL_ALREADY_EXISTS", message);
    }
}
