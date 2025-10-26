package com.medicalportal.medicalportal.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordUtil {
    private static final PasswordEncoder ENCODER = new BCryptPasswordEncoder(10);

    public static String hash(String raw) {
        if (raw == null) return null;
        return ENCODER.encode(raw);
    }

    public static boolean matches(String raw, String encoded) {
        if (raw == null || encoded == null) return false;
        // If stored is plaintext (legacy), allow direct compare as fallback
        if (!encoded.startsWith("$2a$") && !encoded.startsWith("$2b$") && !encoded.startsWith("$2y$")) {
            return raw.equals(encoded);
        }
        return ENCODER.matches(raw, encoded);
    }

    public static boolean isHashed(String value) {
        if (value == null) return false;
        return value.startsWith("$2a$") || value.startsWith("$2b$") || value.startsWith("$2y$");
    }
}
