import 'dart:math';

import 'package:ambisis_dashboard_challenge/core/services/dashboard_database.dart';
import 'package:ambisis_dashboard_challenge/core/services/helpers/db_insert_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_x/random_x.dart';

final fillDatabaseServiceProvider = Provider<LocalFillDatabaseService>(
    (ref) => LocalFillDatabaseService(ref.read(databaseProvider)));

class LocalFillDatabaseService {
  final IDashboardDatabase _database;

  const LocalFillDatabaseService(this._database);

  Future<void> fillDatabase() async {
    List<DbInsertModel> models = _generateInsertModels();
    for (DbInsertModel model in models) {
      await _database.insertEsgGoal(model);
    }
  }

  List<DbInsertModel> _generateInsertModels() {
    return List<DbInsertModel>.generate(
      100,
      (index) => DbInsertModel(
        date:  RndX.randomPastDate(start: DateTime(2000), end: DateTime(2023)).millisecondsSinceEpoch,
        isComplete: Random().nextInt(2),
        type: Random().nextInt(3),
      ),
    );
  }
}
