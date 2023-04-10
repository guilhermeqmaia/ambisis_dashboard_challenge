import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/state/dashboard_state.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/mapper/get_all_goals_mapper.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/repository/get_all_goals_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllGoalsUsecaseProvider = Provider<IGetAllGoalsUsecase>(
    (ref) => GetAllGoalsUsecase(ref.read(getAllGoalsRepositoryProvider)));

abstract class IGetAllGoalsUsecase {
  Future<DashboardState> getAllGoals();
}

class GetAllGoalsUsecase implements IGetAllGoalsUsecase {
  final IGetAllGoalsRepository _repository;

  GetAllGoalsUsecase(this._repository);

  @override
  Future<DashboardState> getAllGoals() async {
    final response = await _repository.getAllGoals();
    return response.toState();
  }
}
