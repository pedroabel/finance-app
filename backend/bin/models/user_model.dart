class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? balance;
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
      map['saldo'] ?? '',
      map['is_ativo'] == 1,
      map['dt_criacao'],
      map['dt_atualizacao'],
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, balance: $balance, isActived: $isActived, dtCriated: $dtCriated, dtUppdate: $dtUppdate)';
  }
}
