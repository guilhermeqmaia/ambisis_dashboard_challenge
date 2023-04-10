import '../../../view/helpers/filter_selection_mixin.dart';

abstract class IDashboardState {
  final bool isLoading;
  final List<DashboardGoalState> goals;

  const IDashboardState({this.goals = const [], this.isLoading = false});

  copyWith({
    List<DashboardGoalState>? goals,
    bool? isLoading,
  });
}

class DashboardInitialState extends IDashboardState {
  const DashboardInitialState({
    bool isLoading = false,
  }) : super(isLoading: isLoading);

  @override
  copyWith({List<DashboardGoalState>? goals, bool? isLoading}) {
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
    this.filterYears = const [],
  }) : super(goals: goals);

  DateTime get oldestDate {
    DateTime oldestGoalDate = goals.first.date;

    for (var goal in goals) {
      if (goal.date.millisecondsSinceEpoch <
          oldestGoalDate.millisecondsSinceEpoch) {
        oldestGoalDate = goal.date;
      }
    }

    return oldestGoalDate;
  }

  DateTime get newestDate {
    DateTime newestGoalDate = goals.first.date;

    for (var goal in goals) {
      if (goal.date.millisecondsSinceEpoch >
          newestGoalDate.millisecondsSinceEpoch) {
        newestGoalDate = goal.date;
      }
    }

    return newestGoalDate;
  }

  @override
  copyWith(
      {List<DashboardGoalState>? goals,
      bool? isLoading,
      List<int>? filterYears}) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      goals: goals ?? this.goals,
      filterYears: filterYears ?? this.filterYears,
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
