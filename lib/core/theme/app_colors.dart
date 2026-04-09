import 'package:flutter/material.dart';

/// Centralized color palette for the entire app.
/// All colors are defined here to ensure consistency.
class AppColors {
  AppColors._();

  // ── Primary brand colors ──────────────────────────────────────────────────
  static const kColorPrimary = Color(0xFF6C63FF);
  static const kColorPrimaryLight = Color(0xFF8B85FF);
  static const kColorPrimaryDark = Color(0xFF4A42D4);
  static const kColorSecondary = Color(0xFF00D4AA);
  static const kColorAccent = Color(0xFFFF6B9D);

  // ── Background layers ─────────────────────────────────────────────────────
  static const kColorBg = Color(0xFF0A0D1A);
  static const kColorBgSurface = Color(0xFF111420);
  static const kColorCard = Color(0xFF161B2E);
  static const kColorCardElevated = Color(0xFF1C2236);

  // ── Text hierarchy ────────────────────────────────────────────────────────
  static const kColorText = Color(0xFFF0F0FF);
  static const kColorTextSecondary = Color(0xFFB0B3C8);
  static const kColorTextMuted = Color(0xFF6B6F8A);
  static const kColorTextDisabled = Color(0xFF3D4160);

  // ── Borders ───────────────────────────────────────────────────────────────
  static const kColorBorder = Color(0xFF252A42);
  static const kColorBorderFocused = Color(0xFF6C63FF);

  // ── Status colors ─────────────────────────────────────────────────────────
  static const kColorSuccess = Color(0xFF00D4AA);
  static const kColorError = Color(0xFFFF4E6A);
  static const kColorWarning = Color(0xFFFFB347);
  static const kColorInfo = Color(0xFF4FC3F7);

  // ── Gradient sets ─────────────────────────────────────────────────────────
  static const gradientPrimary = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF9B59B6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientSuccess = LinearGradient(
    colors: [Color(0xFF00D4AA), Color(0xFF00B4D8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientCard = LinearGradient(
    colors: [Color(0xFF161B2E), Color(0xFF1C2236)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientError = LinearGradient(
    colors: [Color(0xFFFF4E6A), Color(0xFFFF8E53)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Questionnaire card accent colors ──────────────────────────────────────
  static const List<Color> cardAccents = [
    Color(0xFF6C63FF), // Purple
    Color(0xFF00D4AA), // Teal
    Color(0xFFFFB347), // Orange
    Color(0xFFFF6B9D), // Pink
    Color(0xFF4FC3F7), // Blue
  ];

  // ── Transparent ───────────────────────────────────────────────────────────
  static const kColorTransparent = Colors.transparent;
}
