import 'package:ambisis_dashboard_challenge/modules/dashboard/data/models/get_all_goals_query_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/dashboard_database.dart';

final getAllGoalsRepositoryProvider = Provider<IGetAllGoalsRepository>(
  (ref) => GetAllGoalsRepository(
    ref.read(databaseProvider),
  ),
);

abstract class IGetAllGoalsRepository {
  Future<GetAllGoalsQueryResponse> getAllGoals();
}

class GetAllGoalsRepository implements IGetAllGoalsRepository {
  final IDashboardDatabase _database;

  GetAllGoalsRepository(this._database);

  @override
  Future<GetAllGoalsQueryResponse> getAllGoals() async {
    final queryResponse = await _database.selectEsgGoals();
    return GetAllGoalsQueryResponse.fromMap(queryResponse);
  }
}
