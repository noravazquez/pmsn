import 'package:flutter/material.dart';
import 'package:primer_proyecto/models/post_model.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key, this.objPostModel});

  PostModel? objPostModel;

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

    return Container(
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
          iconRate
        ],
      ),
    );
  }
}
