class TransactionModel {
  final int? id;
  final String? type;
  final String? title;
  final String? value;
  final DateTime? dtCreated;
  final DateTime? dtUpdate;
  final int? userId;

  factory TransactionModel.fromJson(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      type: map['type'] as String? ?? '',
      title: map['title'] as String? ?? '',
      value: map['value'] as String? ?? '',
      dtCreated: map['dtCreated'] != null
          ? DateTime.parse(map['dtCreated'] as String)
          : null,
      dtUpdate: map['dtUpdate'] != null
          ? DateTime.parse(map['dtUpdate'] as String)
          : null,
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
