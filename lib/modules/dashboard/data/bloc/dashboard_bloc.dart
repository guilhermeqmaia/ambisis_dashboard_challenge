import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/event/dashboard_events.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/bloc/state/dashboard_state.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/data/usecase/get_all_goals_usecase.dart';
import 'package:ambisis_dashboard_challenge/modules/dashboard/view/helpers/filter_selection_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardBlocProvider = Provider<DashboardBloc>(
    (ref) => DashboardBloc(ref.read(getAllGoalsUsecaseProvider)));

class DashboardBloc extends Bloc<IDashboardEvent, IDashboardState>
    with FilterSelectionMixin {
  final IGetAllGoalsUsecase _usecase;

  List<DashboardGoalState>? _fetchedGoals;

  DashboardBloc(this._usecase) : super(const DashboardInitialState()) {
    on<FetchGoalsEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final fetchState = await _usecase.getAllGoals();
        _fetchedGoals = fetchState.goals;
        emit(fetchState.copyWith(
          isLoading: false,
          filterYears: getFilterSelectionValues(_fetchedGoals!),
        ));
      },
    );

    on<FilterGoalsEvent>(
      (event, emit) {
        final filterTimeStart = event.start.millisecondsSinceEpoch;
        final filterTimeEnd = event.end.millisecondsSinceEpoch;

        List<DashboardGoalState>? filteredGoals = _fetchedGoals?.where((value) {
          final valueDate = value.date.millisecondsSinceEpoch;
          return valueDate >= filterTimeStart && valueDate <= filterTimeEnd;
        }).toList();

        emit(state.copyWith(goals: filteredGoals));
      },
    );

    on<RemoveFiltersEvent>(
      (event, emit) {
        emit(state.copyWith(goals: _fetchedGoals));
      },
    );
  }
}
