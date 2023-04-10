import 'package:ambisis_dashboard_challenge/modules/dashboard/data/models/get_all_goals_query_response.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/models/goal_query_response.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/state/dashboard_state.dart';

extension GetAllGoalsMapper on GetAllGoalsQueryResponse {
  DashboardState toState() {
    return DashboardState(
      goals: List.from(goals.map((goal) => _responseToState(goal))),
    );
  }

  DashboardGoalState _responseToState(
      GoalQueryResponse goal) {
    return DashboardGoalState(
      id: goal.id,
      date: DateTime.fromMillisecondsSinceEpoch(goal.date),
      isComplete: goal.isComplete == 1,
      type: _getEsgGoalType(goal.type),
    );
  }

  EsgGoalType _getEsgGoalType(int type) {
    switch(type) {
      case 0: return EsgGoalType.environmental;
      case 1: return EsgGoalType.social;
      case 2: return EsgGoalType.governance;
      default: return EsgGoalType.other;
    }
  }
}
