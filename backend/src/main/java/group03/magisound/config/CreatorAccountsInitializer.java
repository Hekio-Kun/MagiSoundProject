package group03.magisound.config;

import group03.magisound.authentication.entity.Role;
import group03.magisound.authentication.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * Automatically synchronizes and seeds creator accounts and user profiles in app_users
 * for all uploader IDs present in the tracks catalog.
 * Resolves the issue where tracks display "Unknown Artist" on Explore, Player, and Catalog pages.
 */
@Slf4j
@Component
@Order(1)
@RequiredArgsConstructor
public class CreatorAccountsInitializer implements ApplicationRunner {

    private final JdbcTemplate jdbcTemplate;
    private final RoleRepository roleRepository;

    private static final String DEFAULT_PASSWORD_HASH = "$2a$10$SKikCyl4aWTIoFeG3ZKpHuiSFnvGCLbsxqEhCXXqTzwzc0daPLdM."; // Test@123456

    private record CreatorSeed(
            long id,
            String email,
            String username,
            String displayName,
            String bio,
            String avatarUrl
    ) {}

    private static final List<CreatorSeed> KNOWN_CREATORS = List.of(
            new CreatorSeed(
                    10L,
                    "sontungmtp@soundwave.io",
                    "sontungmtp",
                    "Sơn Tùng M-TP",
                    "Ca sĩ, nhạc sĩ, nhà sản xuất âm nhạc V-Pop hàng đầu. Founder M-TP Entertainment.",
                    "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565403/soundwave/tracks/covers/project-cover-noi-nay-co-anh.webp"
            ),
            new CreatorSeed(
                    11L,
                    "hieuthuhai@soundwave.io",
                    "hieuthuhai",
                    "HIEUTHUHAI",
                    "Rapper thành viên nhóm nhạc GERDNANG. Chủ nhân album thành công 'Ai Cũng Phải Bắt Đầu Từ Đâu Đó'.",
                    "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565335/soundwave/tracks/covers/project-cover-exit-sign-hieuthuhai.webp"
            ),
            new CreatorSeed(
                    12L,
                    "mck@soundwave.io",
                    "mck99",
                    "MCK",
                    "Rapper, ca sĩ, nhạc sĩ thuộc tổ đội RPT. Chủ nhân album đình đám '99%'.",
                    "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565314/soundwave/tracks/covers/project-cover-baby-mck.webp"
            ),
            new CreatorSeed(
                    13L,
                    "uyenlinh@soundwave.io",
                    "uyenlinh",
                    "Uyên Linh",
                    "Nữ ca sĩ sở hữu giọng hát nội lực, truyền cảm với các bản hit Ballad da diết.",
                    "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565356/soundwave/tracks/covers/project-cover-giua-dai-lo-dong-tay.webp"
            ),
            new CreatorSeed(
                    14L,
                    "hngle@soundwave.io",
                    "hngle",
                    "Hngle",
                    "Nghệ sĩ Indie R&B trẻ với màu sắc âm nhạc hiện đại, cảm xúc và bay bổng.",
                    "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565384/soundwave/tracks/covers/project-cover-tim-em-hngle-bao-anh.webp"
            ),
            new CreatorSeed(
                    15L,
                    "yoasobi@soundwave.io",
                    "yoasobi",
                    "YOASOBI",
                    "Japanese music superduo composed of producer Ayase and vocalist ikura, turning novels into music.",
                    "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565560/soundwave/tracks/covers/project-cover-yoru-ni-kakeru.webp"
            ),
            new CreatorSeed(
                    16L,
                    "yorushika@soundwave.io",
                    "yorushika",
                    "Yorushika",
                    "Japanese rock duo consisting of producer n-buna and vocalist suis. Creators of nostalgic melodic themes.",
                    "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565498/soundwave/tracks/covers/project-cover-haru-yorushika.webp"
            ),
            new CreatorSeed(
                    17L,
                    "yokotakahashi@soundwave.io",
                    "yokotakahashi",
                    "Yoko Takahashi",
                    "Legendary Japanese singer acclaimed for performing the theme songs of Neon Genesis Evangelion.",
                    "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565523/soundwave/tracks/covers/project-cover-a-cruel-angels-thesis.webp"
            ),
            new CreatorSeed(
                    18L,
                    "yamazaki@soundwave.io",
                    "yamazaki",
                    "Masayoshi Yamazaki",
                    "Veteran Japanese singer-songwriter celebrated for the iconic theme 'One more time, One more chance'.",
                    "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565463/soundwave/tracks/covers/project-cover-one-more-time-one-more-chance.webp"
            ),
            new CreatorSeed(
                    19L,
                    "lowg@soundwave.io",
                    "lowg",
                    "Low G",
                    "Rapper thuộc Rapital, được mệnh danh là 'chủ tọa' với phong cách flow mượt mà đặc trưng.",
                    "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565431/soundwave/tracks/covers/project-cover-laviem.webp"
            ),
            new CreatorSeed(
                    20L,
                    "minhan.creator@soundwave.io",
                    "minhan",
                    "Minh An",
                    "Acoustic and Indie pop artist crafting gentle, soulful melodies for quiet contemplation.",
                    "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80"
            ),
            new CreatorSeed(
                    3L,
                    "lehaiduy1900@gmail.com",
                    "lehaiduy",
                    "Lê Hải Duy",
                    "Creator & Music Producer on MagiSound.",
                    "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80"
            ),
            new CreatorSeed(
                    7L,
                    "dotranthienphuc230@gmail.com",
                    "thienphuc",
                    "Thiên Phúc",
                    "Creator & Music Artist on MagiSound.",
                    "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80"
            ),
            new CreatorSeed(
                    8L,
                    "minhtriojt@gmail.com",
                    "minhtri",
                    "Minh Trí",
                    "Producer & Sound Designer on MagiSound.",
                    "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?auto=format&fit=crop&w=400&q=80"
            ),
            new CreatorSeed(
                    9L,
                    "truonganhtuan04072020@gmail.com",
                    "anhtuan",
                    "Anh Tuấn",
                    "Indie Beatmaker & Audio Engineer.",
                    "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=400&q=80"
            )
    );

    @Override
    public void run(ApplicationArguments args) {
        try {
            syncCreators();
        } catch (Exception e) {
            log.error("Failed to synchronize creator accounts: {}", e.getMessage(), e);
        }
    }

    private void syncCreators() {
        Short listenerRoleId = roleRepository.findByCode("LISTENER")
                .map(Role::getId)
                .orElse((short) 7);

        int syncedCount = 0;

        for (CreatorSeed creator : KNOWN_CREATORS) {
            // 1. Ensure user exists in app_users with exact ID
            jdbcTemplate.update("""
                INSERT INTO app_users (id, role_id, email, password_hash, status, email_verified_at, created_at, updated_at)
                VALUES (?, ?, ?, ?, 'ACTIVE', NOW(), NOW(), NOW())
                ON CONFLICT (id) DO UPDATE SET
                    email = EXCLUDED.email,
                    status = 'ACTIVE',
                    updated_at = NOW()
            """, creator.id(), listenerRoleId, creator.email(), DEFAULT_PASSWORD_HASH);

            // 2. Ensure profile exists in user_profiles
            jdbcTemplate.update("""
                INSERT INTO user_profiles (user_id, username, display_name, bio, avatar_url, country_code, created_at, updated_at)
                VALUES (?, ?, ?, ?, ?, 'VN', NOW(), NOW())
                ON CONFLICT (user_id) DO UPDATE SET
                    username = EXCLUDED.username,
                    display_name = EXCLUDED.display_name,
                    bio = EXCLUDED.bio,
                    avatar_url = EXCLUDED.avatar_url,
                    updated_at = NOW()
            """, creator.id(), creator.username(), creator.displayName(), creator.bio(), creator.avatarUrl());

            syncedCount++;
        }

        // 3. Resilient check: Any remaining uploader IDs from tracks that are still not in app_users
        try {
            List<Map<String, Object>> missingUploaders = jdbcTemplate.queryForList("""
                SELECT DISTINCT t.uploader_user_id
                FROM tracks t
                LEFT JOIN app_users u ON t.uploader_user_id = u.id
                WHERE u.id IS NULL
            """);

            for (Map<String, Object> row : missingUploaders) {
                Long uploaderId = ((Number) row.get("uploader_user_id")).longValue();
                String fallbackEmail = "creator" + uploaderId + "@magisound.com";
                String fallbackUsername = "creator_" + uploaderId;
                String fallbackDisplayName = "Creator #" + uploaderId;

                jdbcTemplate.update("""
                    INSERT INTO app_users (id, role_id, email, password_hash, status, email_verified_at, created_at, updated_at)
                    VALUES (?, ?, ?, ?, 'ACTIVE', NOW(), NOW(), NOW())
                    ON CONFLICT (id) DO UPDATE SET status = 'ACTIVE'
                """, uploaderId, listenerRoleId, fallbackEmail, DEFAULT_PASSWORD_HASH);

                jdbcTemplate.update("""
                    INSERT INTO user_profiles (user_id, username, display_name, bio, created_at, updated_at)
                    VALUES (?, ?, ?, 'Verified creator on MagiSound.', NOW(), NOW())
                    ON CONFLICT (user_id) DO NOTHING
                """, uploaderId, fallbackUsername, fallbackDisplayName);

                syncedCount++;
            }
        } catch (Exception ex) {
            log.warn("Secondary uploader check warning: {}", ex.getMessage());
        }

        // 4. Update the sequence app_users_id_seq to prevent future primary key collision
        try {
            jdbcTemplate.execute("""
                SELECT setval('app_users_id_seq', (SELECT COALESCE(MAX(id), 1) FROM app_users))
            """);
            log.info("app_users_id_seq sequence updated successfully.");
        } catch (Exception ex) {
            log.warn("Could not update app_users_id_seq: {}", ex.getMessage());
        }

        log.info("Creator accounts synchronization complete. Verified {} creator accounts & profiles.", syncedCount);
    }
}
