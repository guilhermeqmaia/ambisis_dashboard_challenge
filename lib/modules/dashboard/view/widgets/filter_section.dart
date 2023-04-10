import 'package:flutter/material.dart';

import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/dashboard_bloc.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/event/dashboard_events.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/state/dashboard_state.dart';
import 'package:intl/intl.dart';

import '../../../../shared/widgets/content_section.dart';

class FilterSection extends StatefulWidget {
  final DashboardBloc bloc;

  const FilterSection({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  @override
  Widget build(BuildContext context) {
    final filterYears = (widget.bloc.state as DashboardState).filterYears;
    return ContentSection(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filtros',
            style: TextStyle(
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
                return _FilterSectionButton(
                  isSelected: true,
                  title: '$year Anos',
                  onPressed: () {
                    widget.bloc.add(
                      FilterGoalsEvent(
                        start: DateTime(DateTime.now().year - year),
                      ),
                    );
                  },
                );
              }).toList(),


              
              _FilterSelectionDatePicker(
                isSelected: true,
                firstDate: DateTime(
                  DateTime.now().year - filterYears.last,
                ),
                onDateSelected: (start, end) {
                  final firstDate = DateTime(
                    DateTime.now().year - filterYears.last,
                  );
                  widget.bloc.add(
                    FilterGoalsEvent(
                      start: start ?? firstDate,
                      end: end,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('dd/MM/yyyy').format((widget.bloc.state as DashboardState).oldestDate)),
                      Container(
                        height: 15,
                        width: 2,
                        color: Colors.grey.shade300,
                      ),
                      Text(DateFormat('dd/MM/yyyy').format((widget.bloc.state as DashboardState).newestDate)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  widget.bloc.add(RemoveFiltersEvent());
                },
              ),
            ],
          ),
        ],
      ),
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
    return Material(
      color: isSelected ? Colors.green.shade800 : Colors.grey.shade300,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        splashColor: Colors.grey.shade600,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: isSelected ? Colors.white : Colors.black,
            ),
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
    return _FilterSectionButton(
        isSelected: isSelected,
        title: 'Por Data',
        onPressed: () async {
          onDateSelected(
            await showDatePicker(
              context: context,
              initialDate: firstDate,
              firstDate: firstDate,
              lastDate: DateTime.now(),
              helpText: 'Selecione a Data Inicial',
              confirmText: 'Confirmar',
              cancelText: 'Cancelar',
            ),
            await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: firstDate,
              lastDate: DateTime.now(),
              helpText: 'Selecione a Data Final',
              confirmText: 'Confirmar',
              cancelText: 'Cancelar',
            ),
          );
        });
  }
}
