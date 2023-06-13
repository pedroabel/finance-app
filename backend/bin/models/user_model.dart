class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  double? balance;
  bool? isActived;
  DateTime? dtCriated;
  DateTime? dtUppdate;

  UserModel();

  UserModel.create(
    this.id,
    this.name,
    this.email,
    this.balance,
    this.isActived,
    this.dtCriated,
    this.dtUppdate,
  );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.create(
      map['id']?.toInt() ?? 0,
      map['nome'] ?? '',
      map['email'] ?? '',
      map['saldo'],
      map['is_ativo'] == 1,
      map['dt_criacao'],
      map['dt_atualizacao'],
    );
  }

  factory UserModel.fromEmail(Map map) {
    return UserModel()
      ..id = map['id']
      ..email = map['email']
      ..password = map['senha'];
  }

  factory UserModel.fromRequest(Map map) {
    return UserModel()
      ..id = map['id']
      ..name = map['name']
      ..email = map['email']
      ..password = map['password']
      ..balance = map['balance'];
  }

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'balance': balance,
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, balance: $balance, isActived: $isActived, dtCriated: $dtCriated, dtUppdate: $dtUppdate)';
  }
}
