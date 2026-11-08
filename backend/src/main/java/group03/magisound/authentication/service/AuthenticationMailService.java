package group03.magisound.authentication.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthenticationMailService {
    private final JavaMailSender mailSender;

    @Value("${app.mail.from}")
    private String fromAddress;

    /**
     * Gửi mã OTP dùng một lần để xác thực email đăng ký.
     */
    public void sendVerificationOtp(String recipient, String displayName, String otp, long expirationMinutes) {
        send(recipient, "Verify your MagiSound email",
                "Hello %s,%n%nYour MagiSound verification code is: %s%n%nThis code expires in %d minutes."
                        .formatted(displayName, otp, expirationMinutes));
    }

    /**
     * Gửi mã OTP dùng một lần để đặt lại mật khẩu.
     */
    public void sendPasswordResetOtp(String recipient, String otp, long expirationMinutes) {
        send(recipient, "Reset your MagiSound password",
                "Your MagiSound password reset code is: %s%n%nThis code expires in %d minutes. If you did not request it, ignore this email."
                        .formatted(otp, expirationMinutes));
    }

    /**
     * Gửi thông báo khi có yêu cầu đăng ký bằng email đã tồn tại để chống Account Enumeration và bảo vệ tài khoản.
     */
    public void sendAccountAlreadyExistsNotice(String recipient) {
        send(recipient, "MagiSound account registration attempt",
                "Hello,%n%nSomeone recently attempted to create a new MagiSound account using your email address (%s).%n%nBecause you already have an active MagiSound account, no new account was created.%n%nIf this was you, you can log in directly or reset your password if you forgot it.%n%nIf you did not make this request, you can safely ignore this email. Your account is secure."
                        .formatted(recipient));
    }

    /**
     * Gửi mã OTP dùng một lần để mở khóa tài khoản bị khóa tạm thời.
     */
    public void sendAccountUnlockOtp(String recipient, String otp, long expirationMinutes) {
        send(recipient, "Unlock your MagiSound account",
                "Hello,%n%nYour MagiSound emergency account unlock code is: %s%n%nThis code expires in %d minutes. Enter this code to immediately unlock your account. If you did not request this, please ignore this email."
                        .formatted(otp, expirationMinutes));
    }

    /**
     * Gửi thông tin đăng nhập ban đầu cho nhân viên kiểm duyệt mới (UC-20.2).
     */
    public void sendStaffCredentials(String recipient, String fullName, String temporaryPassword, String loginUrl) {
        log.info("Sending staff credentials email to: {}", recipient);
        send(recipient, "Welcome to MagiSound - Your Staff Account Credentials",
                "Hello %s,%n%nYour staff moderation account has been created on MagiSound.%n%nEmail: %s%nTemporary Password: %s%nLogin URL: %s%n%nPlease log in and change your password immediately."
                        .formatted(fullName, recipient, temporaryPassword, loginUrl));
    }

    private void send(String recipient, String subject, String content) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromAddress);
            message.setTo(recipient);
            message.setSubject(subject);
            message.setText(content);
            mailSender.send(message);
        } catch (Exception ex) {
            log.warn("Failed to dispatch email to {}: {}", recipient, ex.getMessage());
        }
    }
}
