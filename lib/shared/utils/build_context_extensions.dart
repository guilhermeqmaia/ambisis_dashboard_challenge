import 'package:ambisis_dashboard_challenge/l10n/dashboards_strings.dart';
import 'package:flutter/material.dart';

extension IntlStringsExtensions on BuildContext {
  DashboardStrings get strings => DashboardStrings.of(this)!;
}
