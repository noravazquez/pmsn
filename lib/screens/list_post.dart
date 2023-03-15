import 'package:flutter/material.dart';
import 'package:primer_proyecto/database/database_helper.dart';
import 'package:primer_proyecto/models/post_model.dart';
import 'package:primer_proyecto/provider/flags_provider.dart';
import 'package:primer_proyecto/widgets/item_post_widget.dart';
import 'package:provider/provider.dart';

class ListPost extends StatefulWidget {
  const ListPost({super.key});

  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  DatabaseHelper? databaseHelper;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return FutureBuilder(
      future: flag.getflagListPost() == true
          ? databaseHelper!.GETALLPOST()
          : databaseHelper!.GETALLPOST(),
      builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objPostModel = snapshot.data![index];
              return ItemPostWidget(objPostModel: objPostModel);
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Ocurrio un error'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
