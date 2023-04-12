import 'package:ambisis_dashboard_challenge/modules/dashboard/data/models/get_all_goals_query_response.dart';

class DataFactory {
  static Future<List<Map<String, dynamic>>>
      makeDatabaseSelectEsgGoalsMock() async {
    return [
      {
        'id': 0,
        'date': 01010101,
        'isComplete': 0,
        'type': 1,
      },
      {
        'id': 1,
        'date': 01010101,
        'isComplete': 1,
        'type': 0,
      }
    ];
  }

  static Future<GetAllGoalsQueryResponse> makeRepositoryResponse() async {
    return const GetAllGoalsQueryResponse([]);
  }
}
