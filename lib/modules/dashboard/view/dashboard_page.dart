import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/event/dashboard_events.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/view/widgets/development_section.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/view/widgets/filter_section.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/view/widgets/chart_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/bloc/dashboard_bloc.dart';
import '../data/bloc/state/dashboard_state.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  late final DashboardBloc bloc;

  @override
  void initState() {
    bloc = ref.read(dashboardBlocProvider);
    bloc.add(FetchGoalsEvent());
    super.initState();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: BlocBuilder<DashboardBloc, IDashboardState>(
          bloc: bloc,
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DashboardState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    FilterSection(bloc: bloc),
                    const SizedBox(height: 15),
                    ChartSection(bloc: bloc),
                    const SizedBox(height: 15),
                    DevelopmentSection(bloc: bloc),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
