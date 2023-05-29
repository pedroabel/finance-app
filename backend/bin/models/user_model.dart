class UserModel {
  final int id;
  final String name;
  final String email;
  final String balance;
  final bool isActived;
  final DateTime dtCriated;
  final DateTime dtUppdate;

  UserModel(
    this.id,
    this.name,
    this.email,
    this.balance,
    this.isActived,
    this.dtCriated,
    this.dtUppdate,
  );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
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
