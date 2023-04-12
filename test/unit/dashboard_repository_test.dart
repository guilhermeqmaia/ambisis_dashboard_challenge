import 'package:ambisis_dashboard_challenge/core/services/dashboard_database.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/repository/get_all_goals_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/data_factory.dart';

class DashboardDatabaseMock extends Mock implements IDashboardDatabase {}

void main() {
  late IDashboardDatabase databaseMock;
  late IGetAllGoalsRepository sut;

  setUp(() {
    databaseMock = DashboardDatabaseMock();
    sut = GetAllGoalsRepository(databaseMock);
  });

  When whenSelectEsgGoals() => when(() => databaseMock.selectEsgGoals());

  Future<List<Map<String, Object?>>> mockDbResponse(
          Invocation invocation) async =>
      await DataFactory.makeDatabaseSelectEsgGoalsMock();

  test('WHEN sut getAllGoals THEN ensure database mock was called', () async {
    whenSelectEsgGoals().thenAnswer(mockDbResponse);

    verifyNever(() => databaseMock.selectEsgGoals());
    await sut.getAllGoals();
    verify(() => databaseMock.selectEsgGoals()).called(1);
  });
}
