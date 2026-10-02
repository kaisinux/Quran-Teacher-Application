import 'package:flutter/material.dart';

/// Functional colors (spec §18): used sparingly, always with an icon + text.
@immutable
class StatusColors extends ThemeExtension<StatusColors> {
  const StatusColors({
    required this.success,
    required this.info,
    required this.warning,
    required this.danger,
    required this.onStatus,
  });

  /// Validated, complete, upload succeeded.
  final Color success;

  /// Information, synchronized, normal state.
  final Color info;

  /// Incomplete, missing value, to check.
  final Color warning;

  /// Error, discipline issue, upload failed, to correct.
  final Color danger;

  final Color onStatus;

  static const light = StatusColors(
    success: Color(0xFF1B7F3B),
    info: Color(0xFF1F5FAD),
    warning: Color(0xFFB45F06),
    danger: Color(0xFFB3261E),
    onStatus: Colors.white,
  );

  static const dark = StatusColors(
    success: Color(0xFF6FD08C),
    info: Color(0xFF8AB4F8),
    warning: Color(0xFFF6B26B),
    danger: Color(0xFFF2B8B5),
    onStatus: Colors.black,
  );

  @override
  StatusColors copyWith({
    Color? success,
    Color? info,
    Color? warning,
    Color? danger,
    Color? onStatus,
  }) =>
      StatusColors(
        success: success ?? this.success,
        info: info ?? this.info,
        warning: warning ?? this.warning,
        danger: danger ?? this.danger,
        onStatus: onStatus ?? this.onStatus,
      );

  @override
  StatusColors lerp(StatusColors? other, double t) {
    if (other == null) return this;
    return StatusColors(
      success: Color.lerp(success, other.success, t)!,
      info: Color.lerp(info, other.info, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      onStatus: Color.lerp(onStatus, other.onStatus, t)!,
    );
  }
}

extension StatusColorsX on BuildContext {
  StatusColors get statusColors => Theme.of(this).extension<StatusColors>()!;
}

abstract final class AppTheme {
  /// Sober green, close to the school's identity.
  static const _seed = Color(0xFF2E6B4F);

  static ThemeData light() => _build(
        ColorScheme.fromSeed(seedColor: _seed),
        StatusColors.light,
      );

  static ThemeData dark() => _build(
        ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark),
        StatusColors.dark,
      );

  static ThemeData _build(ColorScheme scheme, StatusColors status) => ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
        extensions: [status],
        visualDensity: VisualDensity.standard,
        // Large touch targets: used during class, often one-handed.
        materialTapTargetSize: MaterialTapTargetSize.padded,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(minimumSize: const Size(64, 52)),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(minimumSize: const Size(64, 52)),
        ),
      );
}
