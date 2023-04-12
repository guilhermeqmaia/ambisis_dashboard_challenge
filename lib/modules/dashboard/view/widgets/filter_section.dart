import 'package:ambisis_dashboard_challenge/modules/dashboard/view/helpers/filter_selection_mixin.dart';
import 'package:ambisis_dashboard_challenge/shared/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';

import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/dashboard_bloc.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/event/dashboard_events.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/state/dashboard_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../shared/widgets/content_section.dart';

class FilterSection extends StatelessWidget with FilterSelectionMixin {
  final DashboardBloc bloc;
  const FilterSection({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterYears = (bloc.state as DashboardState).filterYears;
    final strings = context.strings;
    return ContentSection(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.filterSectionTitle,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ...filterYears.map((year) {
                final filterType = getFilterType(filterYears, year);
                return _FilterSectionButton(
                  isSelected: bloc.state.filterType == filterType,
                  title: '$year ${strings.filterSectionButtonYears}',
                  onPressed: () {
                    bloc.add(
                      FilterGoalsEvent(
                        start: DateTime(DateTime.now().year - year),
                        filterType: filterType,
                      ),
                    );
                  },
                );
              }).toList(),
              _FilterSelectionDatePicker(
                isSelected: bloc.state.filterType == FilterType.custom,
                firstDate: DateTime(
                  DateTime.now().year - filterYears.last,
                ),
                onDateSelected: (start, end) {
                  final firstDate = DateTime(
                    DateTime.now().year - filterYears.last,
                  );
                  bloc.add(
                    FilterGoalsEvent(
                      start: start ?? firstDate,
                      end: end,
                      filterType: FilterType.custom,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          _BottomDateRangeIndicator(bloc),
        ],
      ),
    );
  }
}

class _BottomDateRangeIndicator extends ConsumerWidget {
  final DashboardBloc bloc;

  const _BottomDateRangeIndicator(this.bloc);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return Row(
      children: [
        const Icon(Icons.calendar_today_outlined, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateFormat
                    .format((bloc.state as DashboardState).oldestDate)),
                Container(
                  height: 15,
                  width: 2,
                  color: Colors.grey.shade300,
                ),
                Text(dateFormat
                    .format((bloc.state as DashboardState).newestDate)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            bloc.add(RemoveFiltersEvent());
          },
        ),
      ],
    );
  }
}

class _FilterSectionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isSelected;

  const _FilterSectionButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: isSelected
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green.shade300,
                  Colors.green.shade500,
                  Colors.green.shade800,
                ],
              )
            : null,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class _FilterSelectionDatePicker extends StatelessWidget {
  final DateTime firstDate;
  final bool isSelected;
  final void Function(DateTime? start, DateTime? end) onDateSelected;

  const _FilterSelectionDatePicker({
    Key? key,
    required this.firstDate,
    required this.onDateSelected,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    return _FilterSectionButton(
        isSelected: isSelected,
        title: strings.filterSectionDatePickerButton,
        onPressed: () async {
          onDateSelected(
            await showDatePicker(
              context: context,
              initialDate: firstDate,
              firstDate: firstDate,
              lastDate: DateTime.now(),
              helpText: strings.filterSectionDatePickerInitialDate,
              confirmText: strings.filterSectionDatePickerInitialConfirmation,
              cancelText: strings.filterSectionDatePickerInitialCancel,
            ),
            await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: firstDate,
              lastDate: DateTime.now(),
              helpText: strings.filterSectionDatePickerFinalDate,
              confirmText: strings.filterSectionDatePickerFinalConfirmation,
              cancelText: strings.filterSectionDatePickerFinalCancel,
            ),
          );
        });
  }
}
