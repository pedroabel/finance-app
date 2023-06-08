import 'package:finance/services/api.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ApiService api = ApiService();

  void initState() {
    super.initState();
    api.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xffffffff), //you can paste your custom code color, but this one is for demo purpose,
      body: ListView(
        padding: const EdgeInsets.all(12),
        physics:
            const BouncingScrollPhysics(), //use this for a bouncing experience
        children: [
          Container(height: 35),
          userTile(),
          divider(),
          colorTiles(),
          divider(),
          bwTiles(),
        ],
      ),
      // bottomNavigationBar: bottomNavigationBar(),
      // floatingActionButton: fab(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget userTile() {
    //I use pixabay.com & unsplash.com for most of the time.
    return const ListTile(
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage(Urls.avatar1),
      // ),
      title: Text(
        "Usuario ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text("Profissao"),
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
    // Color color = Colors.blueGrey.shade800; not satisfied, so let us pick it
    return Column(
      children: [
        bwTile(Icons.info_outline, "SAQ"),
        bwTile(Icons.border_color_outlined, "Manual"),
        bwTile(Icons.textsms_outlined, "Comunidade"),
      ],
    );
  }

//only for ease of understanding, other wise you can use colorTile Directly,
// in my preference, i split the widgets into as many chunks as possible

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

  // Widget fab(){
  //   //this is not satisfying for
  //   // return FloatingActionButton(
  //   //   mini: true,
  //   //   child: Icon(Icons.add,
  //   //   color: Colors.white),
  //   //   onPressed: () {},
  //   // );
  // }
}
