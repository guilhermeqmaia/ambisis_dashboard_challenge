import 'package:ambisis_dashboard_challenge/modules/dashboard/view/helpers/chart_section_mixin.dart';
import 'package:ambisis_dashboard_challenge/shared/utils/build_context_extensions.dart';
import 'package:ambisis_dashboard_challenge/shared/widgets/content_section.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/bloc/dashboard_bloc.dart';
import '../../data/bloc/state/dashboard_state.dart';

class ChartSection extends StatelessWidget with ChartInfoMixin {
  final DashboardBloc bloc;

  const ChartSection({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentSection(
      content: Column(
        children: [
          const _SectionHeader(),
          const SizedBox(height: 5),
          _ChartInfoRow(bloc: bloc),
          const SizedBox(height: 15),
          _BarChart(bloc: bloc)
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    return Row(
      children: [
        const Icon(Icons.bar_chart, size: 28),
        const SizedBox(width: 5),
        Text(
          strings.chartSectionTitle,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          strings.chartSectionRegular,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        CircleAvatar(
          backgroundColor: Colors.green.shade900,
          radius: 5,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.green.shade200,
                    Colors.green.shade500,
                    Colors.green.shade800,
                  ],
                )),
          ),
        ),
      ],
    );
  }
}

class _ChartInfoRow extends StatelessWidget with ChartInfoMixin {
  final DashboardBloc bloc;
  const _ChartInfoRow({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.grey.shade400, height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ChartInfoContent(
              title: 'Crescimento',
              value: growthRate(bloc.state.goals),
            ),
            Container(
              height: 30,
              width: 1,
              color: Colors.grey.shade300,
            ),
            _ChartInfoContent(
              title: 'Total',
              value: total(bloc.state.goals),
            ),
            Container(
              height: 30,
              width: 1,
              color: Colors.grey.shade300,
            ),
            _ChartInfoContent(
              title: 'Média',
              value: average(bloc.state.goals),
            ),
            Container(
              height: 30,
              width: 1,
              color: Colors.grey.shade300,
            ),
            _ChartInfoContent(
              title: 'Concluídas',
              value: finished(bloc.state.goals),
            ),
          ],
        ),
        Divider(color: Colors.grey.shade400, height: 20),
      ],
    );
  }
}

class _ChartInfoContent extends StatelessWidget {
  final String title;
  final String value;
  const _ChartInfoContent({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _BarChart extends StatelessWidget with ChartInfoMixin {
  final DashboardBloc bloc;

  const _BarChart({
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final chartData = chartBarsData(bloc.state.goals);
    final isMonthChart = isMonthlyChart(bloc.state.goals);
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: leftTitlesInterval(bloc.state.goals),
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text('$value');
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 1,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  String text = '';
                  EdgeInsetsGeometry? padding;
                  if (isMonthChart) {
                    text = getMonth(value.toInt());
                  } else if (value.toInt() == chartData.length - 1) {
                    text = '${(bloc.state as DashboardState).newestDate.year}';
                    padding = const EdgeInsets.only(right: 22);
                  } else if (value.toInt() == 0) {
                    text = '${(bloc.state as DashboardState).oldestDate.year}';
                    padding = const EdgeInsets.only(left: 22);
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Padding(
                      padding: padding ?? EdgeInsets.zero,
                      child: Text(text),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: chartData,
        ),
      ),
    );
  }
}
