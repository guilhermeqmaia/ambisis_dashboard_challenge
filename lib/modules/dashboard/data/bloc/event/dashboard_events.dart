import '../state/dashboard_state.dart';

abstract class IDashboardEvent {}

class FetchGoalsEvent extends IDashboardEvent {}

class FilterGoalsEvent extends IDashboardEvent {
  final DateTime start;
  final DateTime end;
  final FilterType filterType;
  FilterGoalsEvent({
    required this.start,
    required this.filterType,
    DateTime? end,
  }) : end = end ?? DateTime.now();
}

class RemoveFiltersEvent extends IDashboardEvent {
  final FilterType? filterType;

  RemoveFiltersEvent({this.filterType});
}
