package com.mindet.util;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Locale;

public class DateUtil {
    private static final ZoneId JAKARTA_ZONE = ZoneId.of("Asia/Jakarta");
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm", Locale.ENGLISH);

    public static String formatJakarta(Timestamp timestamp) {
        if (timestamp == null) return "";
        ZonedDateTime zdt = timestamp.toInstant().atZone(JAKARTA_ZONE);
        return FORMATTER.format(zdt);
    }

    public static String diffForHumans(Timestamp timestamp) {
        if (timestamp == null) return "";
        Instant now = Instant.now();
        Instant then = timestamp.toInstant();

        long seconds = ChronoUnit.SECONDS.between(then, now);
        if (seconds < 0) seconds = 0;

        if (seconds < 60) {
            return seconds <= 10 ? "just now" : seconds + " seconds ago";
        }
        long minutes = seconds / 60;
        if (minutes < 60) {
            return minutes == 1 ? "1 minute ago" : minutes + " minutes ago";
        }
        long hours = minutes / 60;
        if (hours < 24) {
            return hours == 1 ? "1 hour ago" : hours + " hours ago";
        }
        long days = hours / 24;
        if (days < 30) {
            return days == 1 ? "1 day ago" : days + " days ago";
        }
        long months = days / 30;
        if (months < 12) {
            return months == 1 ? "1 month ago" : months + " months ago";
        }
        long years = months / 12;
        return years == 1 ? "1 year ago" : years + " years ago";
    }
}
