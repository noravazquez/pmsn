import 'package:flutter/material.dart';
import 'package:primer_proyecto/firebase/facebook_auth.dart';
import 'package:primer_proyecto/models/user_model.dart';
import 'package:primer_proyecto/screens/list_post.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FacebookAuthentication facebookAuthentication = FacebookAuthentication();
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hola'.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Stack(
        children: [
          ListPost(),
          Positioned(
              left: 20.0,
              bottom: 18.0,
              child: ElevatedButton(
                child: Text(
                  'Mis eventos',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/events');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    minimumSize: Size(130, 47),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((value) {
            setState(() {});
          });
        },
        label: Text(
          'Add post',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        icon: Icon(Icons.add_comment, color: Theme.of(context).iconTheme.color),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(userModel!.photoURL.toString()),
                ),
                accountName: Text(
                  userModel!.name.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                accountEmail: Text(userModel!.email.toString(),
                    style: Theme.of(context).textTheme.bodyLarge)),
            ListTile(
              onTap: () {},
              title: Text(
                'Practica 1',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: Text('Descripcion de la practica',
                  style: Theme.of(context).textTheme.bodyLarge),
              leading: Icon(Icons.settings,
                  color: Theme.of(context).iconTheme.color),
              trailing: Icon(Icons.chevron_right,
                  color: Theme.of(context).iconTheme.color),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, '/popular'),
              title: Text(
                'API videos',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              leading:
                  Icon(Icons.movie, color: Theme.of(context).iconTheme.color),
              trailing: Icon(Icons.chevron_right,
                  color: Theme.of(context).iconTheme.color),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, '/categoryBooks'),
              title: Text(
                'API libros',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              leading:
                  Icon(Icons.book, color: Theme.of(context).iconTheme.color),
              trailing: Icon(Icons.chevron_right,
                  color: Theme.of(context).iconTheme.color),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
