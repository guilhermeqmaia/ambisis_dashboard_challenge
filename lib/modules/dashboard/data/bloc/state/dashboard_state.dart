import '../../../view/helpers/filter_selection_mixin.dart';

abstract class IDashboardState {
  final bool isLoading;
  final List<DashboardGoalState> goals;
  final FilterType? filterType;

  const IDashboardState({this.goals = const [], this.isLoading = false, this.filterType});

  copyWith({
    List<DashboardGoalState>? goals,
    bool? isLoading,
    FilterType? filterType,
  });
}

class DashboardInitialState extends IDashboardState {
  const DashboardInitialState({
    bool isLoading = false,
  }) : super(isLoading: isLoading);

  @override
  copyWith({List<DashboardGoalState>? goals, bool? isLoading, FilterType? filterType}) {
    return DashboardInitialState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class DashboardState extends IDashboardState with FilterSelectionMixin {
  final List<int> filterYears;

  DashboardState({
    List<DashboardGoalState> goals = const [],
    bool isLoading = false,
    FilterType? filterType,
    this.filterYears = const [],
  }) : super(goals: goals, filterType: filterType, isLoading: isLoading);

  DateTime get oldestDate {
    DateTime oldestGoalDate = goals.isNotEmpty ? goals.first.date : DateTime(DateTime.now().year);

    for (var goal in goals) {
      if (goal.date.millisecondsSinceEpoch <
          oldestGoalDate.millisecondsSinceEpoch) {
        oldestGoalDate = goal.date;
      }
    }

    return oldestGoalDate;
  }

  DateTime get newestDate {
    DateTime newestGoalDate = goals.isNotEmpty ? goals.first.date : DateTime(DateTime.now().year);

    for (var goal in goals) {
      if (goal.date.millisecondsSinceEpoch >
          newestGoalDate.millisecondsSinceEpoch) {
        newestGoalDate = goal.date;
      }
    }

    return newestGoalDate;
  }

  @override
  copyWith({
    List<DashboardGoalState>? goals,
    bool? isLoading,
    List<int>? filterYears,
    FilterType? filterType,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      goals: goals ?? this.goals,
      filterYears: filterYears ?? this.filterYears,
      filterType: filterType,
    );
  }
}

class DashboardGoalState {
  final int id;
  final DateTime date;
  final bool isComplete;
  final EsgGoalType type;

  const DashboardGoalState({
    required this.id,
    required this.date,
    required this.isComplete,
    required this.type,
  });
}

enum EsgGoalType { environmental, social, governance, other }

enum FilterType { short, medium, long, custom }
