class TransactionModel {
  final int id;
  final String type;
  final String title;
  final String value;
  final DateTime dtCreated;
  final DateTime dtUpdate;
  final int userId;

  factory TransactionModel.fromJson(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      type: map['tipo'],
      title: map['titulo'],
      value: map['valor'],
      dtCreated: map['dt_criacao'],
      dtUpdate: map['dt_atualizacao'],
      userId: map['id_usuario'],
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
