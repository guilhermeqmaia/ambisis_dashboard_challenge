class GoalQueryResponse {
  final int id;
  final int date;
  final int isComplete;
  final int type;

  GoalQueryResponse({
    required this.id,
    required this.date,
    required int isComplete,
    required int type,
  })  : type = _verifyGoalTypeValid(type),
        isComplete = _verifyIsCompleteValid(isComplete);

  factory GoalQueryResponse.fromMap(Map<String, dynamic> map) {
    return GoalQueryResponse(
      id: map["id"],
      date: map["date"],
      isComplete: map["isComplete"],
      type: map['type'],
    );
  }

  /// Do not allow an error to happen and cause isComplete to come with a value other than 0 or 1
  static int _verifyIsCompleteValid(int isComplete) {
    if (isComplete == 0 || isComplete == 1) return isComplete;

    return 0;
  }

  /// Check if the value matches between the 3 possible types, otherwise it will be considered in an "Other" category and will have the value 99
  static int _verifyGoalTypeValid(int goalType) {
    int environmental = 0;
    int social = 1;
    int governance = 2;
    if (goalType == environmental ||
        goalType == social ||
        goalType == governance) return goalType;
    return 99;
  }
}
