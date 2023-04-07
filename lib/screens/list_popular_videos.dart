import 'package:flutter/material.dart';
import 'package:primer_proyecto/models/popular_model.dart';
import 'package:primer_proyecto/network/api_popular.dart';
import 'package:primer_proyecto/screens/movie_details_screen.dart';
import 'package:primer_proyecto/widgets/item_popular.dart';

class ListPopularVideo extends StatefulWidget {
  const ListPopularVideo({super.key});

  @override
  State<ListPopularVideo> createState() => _ListPopularVideoState();
}

class _ListPopularVideoState extends State<ListPopularVideo> {
  ApiPopular? apiPopular;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Movies'.toUpperCase(),
        style: Theme.of(context).textTheme.titleLarge,
      )),
      body: FutureBuilder(
          future: apiPopular!.getAllPopular(),
          builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Hero(
                        tag: snapshot.data![index],
                        child:
                            ItemPopular(popularModel: snapshot.data![index])),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetails(
                                popularModel: snapshot.data![index]),
                          ));
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Ocurrio un error'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            Navigator.pushNamed(context, '/moviesFavs');
          });
        },
        label: const Text(''),
        icon: Icon(Icons.favorite, color: Theme.of(context).iconTheme.color),
      ),
    );
  }
}
