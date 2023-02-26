import 'package:flutter/material.dart';

class SelectScreen {
  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blueGrey,
                    ),
                    title: Text('Camera'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.image,
                      color: Colors.blueGrey,
                    ),
                    title: Text('Image'),
                  )
                ],
              ),
            ),
          );
        });
  }
}
