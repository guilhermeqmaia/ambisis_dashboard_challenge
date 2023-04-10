import '../../data/bloc/state/dashboard_state.dart';

mixin FilterSelectionMixin {
  List<int> getFilterSelectionValues(List<DashboardGoalState> goals) {
    int lowerYear = goals.first.date.year;
    int higherYear = 0;
    int middleYear = 0;
    for (DashboardGoalState goal in goals) {
      final goalYear = goal.date.year;
      if (lowerYear > goalYear) lowerYear = goalYear;
      if (higherYear < goalYear) higherYear = goalYear;
    }
    middleYear = ((lowerYear + higherYear) / 2).floor();
    int currentYear = DateTime.now().year;
    return [
      (currentYear - higherYear),
      (currentYear - middleYear),
      (currentYear - lowerYear),
    ];
  }
}
