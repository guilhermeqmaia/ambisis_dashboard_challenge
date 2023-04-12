import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/dashboard_bloc.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/state/dashboard_state.dart';
import 'package:ambisis_dashboard_challenge/shared/utils/build_context_extensions.dart';
import 'package:ambisis_dashboard_challenge/shared/widgets/content_section.dart';
import 'package:flutter/material.dart';

import '../helpers/development_section_mixin.dart';

class DevelopmentSection extends StatelessWidget {
  final DashboardBloc bloc;
  const DevelopmentSection({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Column(
      children: [
        _DevelopmentSingleSection(
          bloc: bloc,
          title: strings.developmentSectionEnvironmental,
          type: EsgGoalType.environmental,
          icon: Icons.forest,
        ),
        const SizedBox(height: 15),
        _DevelopmentSingleSection(
          bloc: bloc,
          title: strings.developmentSectionSocial,
          type: EsgGoalType.social,
          icon: Icons.nature_people,
        ),
        const SizedBox(height: 15),
        _DevelopmentSingleSection(
          bloc: bloc,
          title: strings.developmentSectionGovernance,
          type: EsgGoalType.governance,
          icon: Icons.location_city,
        ),
        const SizedBox(height: 15),
        bloc.state.goals.any((element) => element.type == EsgGoalType.other)
            ? _DevelopmentSingleSection(
                bloc: bloc,
                title: strings.developmentSectionOther,
                type: EsgGoalType.other,
                icon: Icons.description,
              )
            : const SizedBox(),
      ],
    );
  }
}

class _DevelopmentSingleSection extends StatelessWidget
    with DevelopmentSectionMixin {
  final DashboardBloc bloc;
  final String title;
  final IconData icon;
  final EsgGoalType type;
  const _DevelopmentSingleSection({
    required this.bloc,
    required this.title,
    required this.type,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final total = bloc.state.goals.where((goal) => goal.type == type).toList();
    final finished = total.where((goal) => goal.isComplete).toList();
    return ContentSection(
      content: Column(
        children: [
          _DevelopmentInfoRow(
            icon: icon,
            title: title,
            total: total.length.toString(),
            finished: finished.length.toString(),
          ),
          const SizedBox(height: 10),
          _DevelopmentProgressBar(
              value: getProgressValue(total.length, finished.length)),
        ],
      ),
    );
  }
}

class _DevelopmentProgressBar extends StatelessWidget {
  final double value;

  const _DevelopmentProgressBar({
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: LinearProgressIndicator(
        minHeight: 5,
        value: value,
        color: Colors.green.shade700,
        backgroundColor: Colors.grey.shade300,
      ),
    );
  }
}

class _DevelopmentInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String total;
  final String finished;

  const _DevelopmentInfoRow({
    required this.icon,
    required this.title,
    required this.total,
    required this.finished,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    return Row(
      children: [
        Icon(icon, size: 35),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  strings.developmentSectionTotal,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  total,
                  style: TextStyle(
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  strings.developmentSectionFinished,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  finished,
                  style: TextStyle(
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
