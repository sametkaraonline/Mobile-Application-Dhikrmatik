import 'package:flutter/material.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:  Text("AYARLAR",
          style: TextStyle(
              fontFamily: "Pacifico",
              color: Colors.cyan
          ),),
        centerTitle: true,
      ),

    );
  }
}
