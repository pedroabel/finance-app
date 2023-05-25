// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionModel {
  final int? id;
  final String type;
  final double value;
  final DateTime date;
  final String description;

  factory TransactionModel.fromJson(Map map) {
    return TransactionModel(
      map['id'] ?? '',
      map['type'],
      map['value'],
      DateTime.fromMicrosecondsSinceEpoch(map['date']),
      map['description'],
    );
  }

  Map toJson() {
    return {
      "id": id,
      "type": type,
      "value": value,
      "description": description,
    };
  }

  TransactionModel(
    this.id,
    this.type,
    this.value,
    this.date,
    this.description,
  );

  @override
  String toString() {
    return 'TransactionModel(id: $id, type: $type, value: $value, date: $date, description: $description)';
  }
}
