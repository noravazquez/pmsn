import 'package:flutter/material.dart';
import 'package:primer_proyecto/database/database_helper.dart';
import 'package:primer_proyecto/models/post_model.dart';
import 'package:primer_proyecto/provider/flags_provider.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  DatabaseHelper databaseHelper = DatabaseHelper();

  PostModel? objPostModel;

  @override
  Widget build(BuildContext context) {
    final txtContPost = TextEditingController();

    if (ModalRoute.of(context)!.settings.arguments != null) {
      objPostModel = ModalRoute.of(context)!.settings.arguments as PostModel;
      txtContPost.text = objPostModel!.dscPost!;
    }

    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          height: 350,
          decoration: BoxDecoration(
              color: Colors.black12, border: Border.all(color: Colors.black12)),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              objPostModel == null
                  ? Text(
                      "Add post",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  : Text(
                      "Update post",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyLarge,
                controller: txtContPost,
                maxLines: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (objPostModel == null) {
                      databaseHelper.INSERT('tblPost', {
                        'dscPost': txtContPost.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msg = value > 0
                            ? 'Registro insertado'
                            : 'Ocurrio un error';

                        var snackBar = SnackBar(content: Text(msg));

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    } else {
                      databaseHelper
                          .UPDATE(
                              'tblPost',
                              {
                                'idPost': objPostModel!.idPost,
                                'dscPost': txtContPost.text,
                                'datePost': DateTime.now().toString()
                              },
                              'idPost')
                          .then((value) {
                        var msg = value > 0
                            ? 'Registro actualizado'
                            : 'Ocurrio un error';

                        var snackBar = SnackBar(content: Text(msg));

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                    flag.setflagListPost();
                  },
                  child: Text('Save Post'))
            ],
          ),
        ),
      ),
    );
  }
}
