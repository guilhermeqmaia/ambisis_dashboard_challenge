import 'package:ambisis_dashboard_challenge/core/services/fill_database_service.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/view/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'l10n/dashboards_strings.dart';

void main() {
  runApp(const ProviderScope(child: AppWidget(fillTable: true,)));
}

class AppWidget extends ConsumerStatefulWidget {
  const AppWidget({super.key, this.fillTable = false});

  final bool fillTable;

  @override
  ConsumerState<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends ConsumerState<AppWidget> {
  @override
  void initState() {
    if (widget.fillTable) {
      Future.delayed(Duration.zero, () async {
        await ref.read(fillDatabaseServiceProvider).fillDatabase();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/dashboard': (context) => const DashboardPage(),
      },
      initialRoute: '/dashboard',
      localizationsDelegates: DashboardStrings.localizationsDelegates,
      supportedLocales: DashboardStrings.supportedLocales,
    );
  }
}
