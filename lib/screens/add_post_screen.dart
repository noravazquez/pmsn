import 'package:flutter/material.dart';
import 'package:primer_proyecto/database/database_helper.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final txtContPost = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          height: 350,
          decoration: BoxDecoration(
              color: Colors.black12, border: Border.all(color: Colors.black12)),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add post",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextFormField(
                controller: txtContPost,
                maxLines: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    databaseHelper.INSERT('tblPost', {
                      'dscPost': txtContPost.text,
                      'datePost': DateTime.now().toString()
                    }).then((value) {
                      var msg =
                          value > 0 ? 'Registro insertado' : 'Ocurrio un error';

                      var snackBar = SnackBar(content: Text(msg));

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  },
                  child: Text('Save Post'))
            ],
          ),
        ),
      ),
    );
  }
}
