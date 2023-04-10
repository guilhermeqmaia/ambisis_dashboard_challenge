import 'package:ambisis_dashboard_challenge/core/services/local_fill_database_service.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/view/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ref.read(fillDatabaseServiceProvider).fillDatabase();
    });
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
    );
  }
}
