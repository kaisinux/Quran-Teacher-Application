import 'package:flutter/widgets.dart';

/// Phone: compact list. Tablet: wide multi-column table.
abstract final class Breakpoints {
  static const double tablet = 600;
  static const double wideTable = 900;
}

extension LayoutX on BuildContext {
  bool get isTablet =>
      MediaQuery.sizeOf(this).shortestSide >= Breakpoints.tablet;
}
