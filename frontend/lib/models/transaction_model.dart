class TransactionModel {
  final int id;
  final String type;
  final String title;
  final String value;
  final DateTime dtCreated;
  final DateTime dtUpdate;
  final int userId;

  factory TransactionModel.fromJson(Map map) {
    return TransactionModel(
      id: map['id'],
      type: map['type'],
      title: map['title'],
      value: map['value'],
      dtCreated: DateTime.parse(map['dtCreated']),
      dtUpdate: DateTime.parse(map['dtUpdate']),
      userId: map['userId']?.toInt(),
    );
  }

  TransactionModel({
    required this.id,
    required this.type,
    required this.title,
    required this.value,
    required this.dtCreated,
    required this.dtUpdate,
    required this.userId,
  });
}
