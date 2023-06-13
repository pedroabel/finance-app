class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  double? balance;
  bool? isActived;
  DateTime? dtCreated;
  DateTime? dtUpdated;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.balance,
    this.isActived,
    this.dtCreated,
    this.dtUpdated,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      password: json['password'],
      balance: json['balance']?.toDouble(),
      isActived: json['isActived'],
      dtCreated:
          json['dtCreated'] != null ? DateTime.parse(json['dtCreated']) : null,
      dtUpdated:
          json['dtUppdate'] != null ? DateTime.parse(json['dtUppdate']) : null,
    );
  }
}
