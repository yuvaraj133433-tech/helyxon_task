import 'package:flutter/material.dart';

class PopuMenu extends StatefulWidget {
  const PopuMenu({super.key});

  @override
  State<PopuMenu> createState() => _PopuMenuState();
}

class _PopuMenuState extends State<PopuMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton(
            onSelected: (value) {},
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: "InFo", child: Text("Profile")),
                PopupMenuItem(value: "About ", child: Text("About")),
                PopupMenuItem(value: "Area", child: Text("Settings")),
                PopupMenuItem(value: "ContactUs", child: Text("Contact")),
              ];
            },
          ),
        ],
      ),
    );
  }
}
