import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/bloc/state/dashboard_state.dart';

mixin ChartInfoMixin {
  String growthRate(List<DashboardGoalState> goals) {
    DateTime oldestDate = _getOldestDate(goals);
    DateTime newestDate = _getNewestDate(goals);

    final goalsInOldestDateYear =
        goals.where((goal) => goal.date.year == oldestDate.year).length;
    final goalsInNewestDateYear =
        goals.where((goal) => goal.date.year == newestDate.year).length;
    try {
      return "${((goalsInNewestDateYear / goalsInOldestDateYear) * 100).floor()}%";
    } catch (e) {
      return '0%';
    }
  }

  String total(List<DashboardGoalState> goals) {
    return "${goals.length}";
  }

  String average(List<DashboardGoalState> goals) {
    DateTime oldestDate = _getOldestDate(goals);
    DateTime newestDate = _getNewestDate(goals);
    int yearsRange = newestDate.year - oldestDate.year;
    yearsRange = yearsRange == 0 ? 1 : yearsRange;
    return '${(goals.length / yearsRange).floorToDouble()}';
  }

  String finished(List<DashboardGoalState> goals) {
    return '${goals.where((goal) => goal.isComplete).length}';
  }

  List<BarChartGroupData> chartBarsData(List<DashboardGoalState> goals) {
    DateTime oldestDate = _getOldestDate(goals);
    DateTime newestDate = _getNewestDate(goals);

    int yearsRange = newestDate.year - oldestDate.year;
    yearsRange = yearsRange == 0 ? 1 : yearsRange;

    List<int> concludedGoalsList =
        _getConcludedGoals(yearsRange, goals, oldestDate.year);

    List<BarChartGroupData> barDataList = [];
    for (int index = 0; index < concludedGoalsList.length; index++) {
      final concludedGoal = concludedGoalsList[index];
      barDataList.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: concludedGoal.toDouble(),
              width: 10,
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade900,
                  Colors.green.shade800,
                  Colors.green.shade700,
                  Colors.green.shade600,
                ],
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      );
    }

    return barDataList;
  }

  double leftTitlesInterval(List<DashboardGoalState> goals) {
    DateTime oldestDate = _getOldestDate(goals);
    DateTime newestDate = _getNewestDate(goals);

    int yearsRange = newestDate.year - oldestDate.year;
    yearsRange = yearsRange == 0 ? 1 : yearsRange;

    final concludedGoals =
        _getConcludedGoals(yearsRange, goals, oldestDate.year);

    int biggestAmmountOfConcludedGoals = 0;
    for (int goals in concludedGoals) {
      biggestAmmountOfConcludedGoals = biggestAmmountOfConcludedGoals < goals
          ? goals
          : biggestAmmountOfConcludedGoals;
    }

    if (biggestAmmountOfConcludedGoals >= 10) {
      return 2.5;
    } else if (biggestAmmountOfConcludedGoals >= 8) {
      return 2;
    } else if (biggestAmmountOfConcludedGoals >= 6) {
      return 1.5;
    } else if (biggestAmmountOfConcludedGoals >= 4) {
      return 1;
    } else {
      return 0.5;
    }
  }

  bool isMonthlyChart(List<DashboardGoalState> goals) {
    final oldestDate = _getOldestDate(goals);
    final newestDate = _getNewestDate(goals);

    final range = newestDate.year - oldestDate.year;

    return range == 0;
  }

  String getMonth(int month) {
    switch (month) {
      case 0:
        return 'J';
      case 1:
        return 'F';
      case 2:
        return 'M';
      case 3:
        return 'A';
      case 4:
        return 'M';
      case 5:
        return 'J';
      case 6:
        return 'J';
      case 7:
        return 'A';
      case 8:
        return 'S';
      case 9:
        return 'O';
      case 10:
        return 'N';
      case 11:
        return 'D';
    }
    return '';
  }

  List<int> _getConcludedGoals(
      int yearsRange, List<DashboardGoalState> goals, int oldestYear) {
    List<int> concludedGoalsList = [];

    if (yearsRange == 1) {
      final goalsList =
          goals.where((goal) => goal.date.year == oldestYear).toList();
      final concludedGoals = goalsList.where((g) => g.isComplete).toList();

      for (int month = 1; month <= 12; month++) {
        final concludedGoalsInMonth =
            concludedGoals.where((goal) => goal.date.month == month).length;
        concludedGoalsList.add(concludedGoalsInMonth);
      }
    } else {
      for (int i = 1; i <= yearsRange; i++) {
        final goalsInTheYear =
            goals.where((goal) => goal.date.year == oldestYear + i).toList();

        final concludedGoals =
            goalsInTheYear.where((g) => g.isComplete).toList().length;

        concludedGoalsList.add(concludedGoals);
      }
    }
    return concludedGoalsList;
  }

  DateTime _getOldestDate(List<DashboardGoalState> goals) {
    DateTime oldestDate =
        goals.isNotEmpty ? goals.first.date : DateTime(DateTime.now().year);
    for (var goal in goals) {
      if (goal.date.millisecondsSinceEpoch <
          oldestDate.millisecondsSinceEpoch) {
        oldestDate = goal.date;
      }
    }
    return oldestDate;
  }

  DateTime _getNewestDate(List<DashboardGoalState> goals) {
    DateTime newestDate =
        goals.isNotEmpty ? goals.first.date : DateTime(DateTime.now().year);
    for (var goal in goals) {
      if (goal.date.millisecondsSinceEpoch >
          newestDate.millisecondsSinceEpoch) {
        newestDate = goal.date;
      }
    }
    return newestDate;
  }
}
