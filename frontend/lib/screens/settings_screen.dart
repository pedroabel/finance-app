import 'package:finance/services/api.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Future<UserModel?> futureUserData;
  ApiService api = ApiService();

  @override
  void initState() {
    super.initState();
    futureUserData = fetchUserData();
  }

  Future<UserModel?> fetchUserData() async {
    try {
      return await api.getUserData();
    } catch (error) {
      // Handle the error as needed
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xffffffff), //you can paste your custom code color, but this one is for demo purpose,
      body: FutureBuilder<UserModel?>(
        future: futureUserData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: const EdgeInsets.all(12),
              physics: const BouncingScrollPhysics(),
              children: [
                Container(height: 35),
                userTile(snapshot.data!),
                divider(),
                colorTiles(),
                divider(),
                bwTiles(),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // bottomNavigationBar: bottomNavigationBar(),
      // floatingActionButton: fab(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget userTile(UserModel user) {
    return ListTile(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        user.name ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(user.email ?? ''),
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget colorTiles() {
    return Column(
      children: [
        colorTile(Icons.person_outline, Colors.deepPurple, "Seus dados"),
        colorTile(Icons.settings_outlined, Colors.blue, "Configurações"),
        colorTile(Icons.credit_card, Colors.pink, "Integração com banco"),
        colorTile(Icons.favorite_border, Colors.orange, "Apoie"),
      ],
    );
  }

  Widget bwTiles() {
    return Column(
      children: [
        bwTile(Icons.info_outline, "SAQ"),
        bwTile(Icons.border_color_outlined, "Manual"),
        bwTile(Icons.textsms_outlined, "Comunidade"),
      ],
    );
  }

  Widget bwTile(IconData icon, String text) {
    return colorTile(icon, Colors.black, text, blackAndWhite: true);
  }

  Widget colorTile(IconData icon, Color color, String text,
      {bool blackAndWhite = false}) {
    Color pickedColor = Color(0xfff3f4fe);
    return ListTile(
      leading: Container(
        child: Icon(icon, color: color),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: blackAndWhite ? pickedColor : color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      title: Text(
        "$text",
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
      onTap: () {},
    );
  }
}
