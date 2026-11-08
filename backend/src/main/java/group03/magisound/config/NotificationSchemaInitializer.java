package group03.magisound.config;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

/**
 * Initializer tự động kiểm tra và đồng bộ hóa check constraints của bảng notifications
 * và foreign key của user_profiles trỏ tới app_users.
 */
@Slf4j
@Component
@Order(0)
@RequiredArgsConstructor
public class NotificationSchemaInitializer implements ApplicationRunner {

    private final JdbcTemplate jdbcTemplate;

    @Override
    public void run(ApplicationArguments args) {
        try {
            jdbcTemplate.execute("DELETE FROM email_verification_tokens WHERE user_id NOT IN (SELECT id FROM app_users)");
            jdbcTemplate.execute("DELETE FROM password_reset_tokens WHERE user_id NOT IN (SELECT id FROM app_users)");
            jdbcTemplate.execute("DELETE FROM refresh_tokens WHERE user_id NOT IN (SELECT id FROM app_users)");
            // Do not delete user_profiles here to preserve creator profiles during startup synchronization
            log.info("Orphaned user tokens cleaned up successfully.");
        } catch (Exception e) {
            log.warn("Could not clean orphaned user records: {}", e.getMessage());
        }

        try {
            jdbcTemplate.execute("ALTER TABLE user_profiles DROP CONSTRAINT IF EXISTS fk_user_profiles_app_users");
            jdbcTemplate.execute("ALTER TABLE user_profiles ADD CONSTRAINT fk_user_profiles_app_users FOREIGN KEY (user_id) REFERENCES app_users(id) ON DELETE CASCADE");
            log.info("user_profiles foreign key to app_users verified and updated successfully.");
        } catch (Exception e) {
            log.warn("Could not update user_profiles foreign key constraint: {}", e.getMessage());
        }

        try {
            jdbcTemplate.execute("ALTER TABLE notifications DROP CONSTRAINT IF EXISTS ck_notifications_type");
            jdbcTemplate.execute("ALTER TABLE notifications ADD CONSTRAINT ck_notifications_type CHECK (" +
                    "type IN ('TRACK_APPROVED', 'TRACK_REJECTED', 'TRACK_TAKEN_DOWN', 'TRACK_SUBMISSION', " +
                    "'REPORT_RESOLVED', 'REPORT_REJECTED', 'CONTENT_REPORT', 'ACCOUNT_STATUS_CHANGED', " +
                    "'ROLE_CHANGED', 'SYSTEM', 'SYSTEM_NOTICE'))");
            log.info("Notification table constraints verified and updated successfully.");
        } catch (Exception e) {
            log.warn("Could not update notifications table constraint: {}", e.getMessage());
        }
    }
}
