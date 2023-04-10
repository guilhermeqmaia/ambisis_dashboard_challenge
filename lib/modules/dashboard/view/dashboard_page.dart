import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/dashboard_database.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: const Text(
          'Dashboard ESG',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: const Icon(
          Icons.arrow_back_ios,
          size: 21,
          color: Colors.black,
        ),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: const [
          Icon(Icons.cloud_outlined),
          SizedBox(width: 12),
          Icon(Icons.comment_outlined),
          SizedBox(width: 12),
          Icon(Icons.clear_all_outlined),
          SizedBox(width: 12),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: FutureBuilder(
          future: ref.read(databaseProvider).selectEsgGoals(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (_, __) {
                final value = snapshot.data?[__];
                return Text(value?['id']?.toString() ?? "");
              },
            );
          },
        ),
      ),
    );
  }
}
