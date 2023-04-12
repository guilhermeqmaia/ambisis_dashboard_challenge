import 'package:ambisis_dashboard_challenge/modules/dashboard/data/models/get_all_goals_query_response.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/repository/get_all_goals_repository.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/usecase/get_all_goals_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/data_factory.dart';

class GetAllGoalsRepositoryMock extends Mock
    implements IGetAllGoalsRepository {}

void main() {
  late IGetAllGoalsRepository repositoryMock;
  late IGetAllGoalsUsecase sut;

  setUp(() {
    repositoryMock = GetAllGoalsRepositoryMock();
    sut = GetAllGoalsUsecase(repositoryMock);
  });

  When whenGetAllGoals() => when(() => repositoryMock.getAllGoals());

  Future<GetAllGoalsQueryResponse> mockResponse(Invocation _) async =>
      await DataFactory.makeRepositoryResponse();

  test('WHEN call GetAllGoals THEN ensure method was called', () async {
    whenGetAllGoals().thenAnswer(mockResponse);

    verifyNever(() => repositoryMock.getAllGoals());
    await sut.getAllGoals();
    verify(() => repositoryMock.getAllGoals()).called(1);
  });
}
