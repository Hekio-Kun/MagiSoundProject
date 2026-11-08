package group03.magisound.authentication.exception;

public class InvalidOtpException extends AuthenticationException {
    public InvalidOtpException(String message) {
        super("INVALID_OTP", message);
    }
}
