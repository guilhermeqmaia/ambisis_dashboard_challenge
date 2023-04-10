import 'package:ambisis_dashboard_challenge/modules/dashboard/data/models/goal_query_response.dart';

class GetAllGoalsQueryResponse {
  final List<GoalQueryResponse> goals;

  const GetAllGoalsQueryResponse(this.goals);

  factory GetAllGoalsQueryResponse.fromMap(List<Map<String, dynamic>> map) {
    return GetAllGoalsQueryResponse(
      List.from(
        map.map(
          (e) => GoalQueryResponse.fromMap(e),
        ),
      ),
    );
  }
}
