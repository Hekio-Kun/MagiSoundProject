package group03.magisound.catalog.util;

import java.text.Normalizer;
import java.util.regex.Pattern;

/**
 * Utility helper for normalizing text and removing Vietnamese diacritical marks
 * to enable accent-insensitive and slug-compatible catalog search queries.
 */
public final class SearchNormalizeUtil {

    private static final Pattern DIACRITICS_PATTERN = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
    private static final Pattern NON_ALPHANUMERIC = Pattern.compile("[^a-z0-9]+");

    private SearchNormalizeUtil() {}

    /**
     * Removes Vietnamese diacritical marks (chữ có dấu -> chữ không dấu).
     */
    public static String removeAccents(String input) {
        if (input == null || input.isBlank()) {
            return "";
        }
        String normalized = Normalizer.normalize(input, Normalizer.Form.NFD);
        normalized = normalized.replace('đ', 'd').replace('Đ', 'D').replace('ð', 'd');
        return DIACRITICS_PATTERN.matcher(normalized).replaceAll("").trim();
    }

    /**
     * Converts a search keyword into a clean lowercase hyphenated slug form.
     */
    public static String toSlug(String input) {
        if (input == null || input.isBlank()) {
            return "";
        }
        String withoutAccents = removeAccents(input).toLowerCase();
        String slug = NON_ALPHANUMERIC.matcher(withoutAccents).replaceAll("-");
        return slug.replaceAll("^-+|-+$", "");
    }

    /**
     * Converts a search keyword into a clean lowercase space-separated unaccented string.
     */
    public static String toUnaccented(String input) {
        if (input == null || input.isBlank()) {
            return "";
        }
        String withoutAccents = removeAccents(input).toLowerCase();
        return withoutAccents.replaceAll("\\s+", " ").trim();
    }
}
