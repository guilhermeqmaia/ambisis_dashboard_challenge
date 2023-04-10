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

class DashboardState extends IDashboardState {
  const DashboardState({
    List<DashboardGoalState> goals = const [],
    bool isLoading = false,
  }) : super(goals: goals);

  @override
  copyWith({List<DashboardGoalState>? goals, bool? isLoading}) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      goals: goals ?? this.goals,
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
