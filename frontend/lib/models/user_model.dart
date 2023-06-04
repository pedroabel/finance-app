class UserModel {
  int id;
  String name;
  String email;
  String password;
  String balance;
  bool isActived;
  DateTime dtCriated;
  DateTime dtUppdate;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.balance,
    required this.isActived,
    required this.dtCriated,
    required this.dtUppdate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['name'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      balance: json['balance'],
      isActived: json['isActived'],
      dtCriated: json['dtCriated'],
      dtUppdate: json['dtUppdate'],
    );
  }
}
