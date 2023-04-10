class DbInsertModel {
  final int? id;
  final int date;
  final int isComplete;
  final int type;

  DbInsertModel({
    this.id,
    required this.date,
    required this.isComplete,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date,
      "isComplete": isComplete,
      "type": type,
    };
  }
}
