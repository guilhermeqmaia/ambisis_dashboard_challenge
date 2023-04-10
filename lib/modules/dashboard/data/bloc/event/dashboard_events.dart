abstract class IDashboardEvent {}

class FetchGoalsEvent extends IDashboardEvent {}

class FilterGoalsEvent extends IDashboardEvent {
  final DateTime start;
  final DateTime end;
  FilterGoalsEvent({
    required this.start,
    required this.end,
  });
}

class RemoveFiltersEvent extends IDashboardEvent {}
