// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionModel {
  int? id;
  String? type;
  String? title;
  double? value;
  DateTime? dtCreated;
  DateTime? dtUpdate;
  int? userId;

  TransactionModel();

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel()
      ..id = map['id']
      ..type = map['tipo']
      ..title = map['titulo']
      ..value = map['valor']
      ..dtCreated = map['dt_criacao']
      ..dtUpdate = map['dt_atualizacao']
      ..userId = map['id_usuario']?.toInt();
  }

  factory TransactionModel.fromRequest(Map map) {
    return TransactionModel()
      ..id = map['id']
      ..type = map['type']
      ..title = map['title']
      ..value = map['value']
      ..userId = map['userId']?.toInt();
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'type': type,
      'userId': userId
    };
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, type: $type, title: $title, value: $value, dtCreated: $dtCreated, dtUpdate: $dtUpdate, userId: $userId)';
  }
}
