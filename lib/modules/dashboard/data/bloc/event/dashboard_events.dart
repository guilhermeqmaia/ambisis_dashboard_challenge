abstract class IDashboardEvent {}

class FetchGoalsEvent extends IDashboardEvent {}

class FilterGoalsEvent extends IDashboardEvent {
  final DateTime start;
  final DateTime end;
  FilterGoalsEvent({
    required this.start,
    DateTime? end,
  }) : end = end ?? DateTime.now();
}

class RemoveFiltersEvent extends IDashboardEvent {}
