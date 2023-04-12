import 'package:ambisis_dashboard_challenge/core/services/dashboard_database.dart';
import 'package:ambisis_dashboard_challenge/core/services/fill_database_service.dart';
import 'package:ambisis_dashboard_challenge/core/services/helpers/db_insert_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DatabaseMock extends Mock implements IDashboardDatabase {}

void main() {
  late DbInsertModel insertModelMock;
  late IDashboardDatabase databaseMock;
  late FillDatabaseService sut;

  setUp(() {
    databaseMock = DatabaseMock();
    sut = FillDatabaseService(databaseMock);
  });

  setUpAll(() {
    insertModelMock = DbInsertModel(date: 10010101, isComplete: 0, type: 0);
    registerFallbackValue(insertModelMock);
  });

  When whenCallInsertGoals() => when(() => databaseMock.insertEsgGoal(any()));

  Future<void> mockResponse(Invocation _) async => await Future<void>.value();

  test('WHEN fillDatabse THEN ensure that insert was called 100 times', () async {
    whenCallInsertGoals().thenAnswer(mockResponse);

    await sut.fillDatabase();
    verify(() => databaseMock.insertEsgGoal(any())).called(100);
  });
}
