import 'package:flutter/material.dart';
import 'package:primer_proyecto/database/database_helper.dart';
import 'package:primer_proyecto/models/post_model.dart';
import 'package:primer_proyecto/provider/flags_provider.dart';
import 'package:provider/provider.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key, this.objPostModel});

  PostModel? objPostModel;

  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      backgroundImage: AssetImage("assets/perfil_default.png"),
    );

    final txtUser = Text("Nora Vazquez");

    final datePost = Text("08/03/2023");

    final imgPost = Image(
      image: AssetImage("assets/onboarding2.png"),
      height: 100,
    );

    final txtDesc = Text("Aqui va el contenido del post");

    final iconRate = Icon(Icons.rate_review);

    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Container(
      margin: const EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [avatar, txtUser, datePost],
          ),
          Row(
            children: [imgPost, txtDesc],
          ),
          Row(
            children: [
              iconRate,
              Expanded(child: Container()), //espacio vacio que se adapta
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Confirmar borrado'),
                              content: Text('Deseas borrar el post?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      databaseHelper
                                          .DELETE(
                                              'tblPost', objPostModel!.idPost!)
                                          .then((value) =>
                                              flag.setflagListPost());
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok')),
                                TextButton(
                                  onPressed: () {},
                                  child: Text('No'),
                                )
                              ],
                            ));
                  },
                  icon: Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
