import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:primer_proyecto/provider/them_provider.dart';
import 'package:primer_proyecto/screens/list_post.dart';
import 'package:primer_proyecto/settings/styles_settings.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hola',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: ListPost(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((value) {
            setState(() {});
          });
        },
        label: const Text('Add post'),
        icon: const Icon(Icons.add_comment),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://static.vecteezy.com/system/resources/previews/004/749/962/non_2x/lynx-head-mascot-sport-logo-vector.jpg'),
                ),
                accountName: Text(
                  'Nora',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                accountEmail: Text('vazquez.nora.g@gmail.com',
                    style: Theme.of(context).textTheme.bodyLarge)),
            ListTile(
              onTap: () {},
              title: Text(
                'Practica 1',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: Text('Descripcion de la practica',
                  style: Theme.of(context).textTheme.bodyLarge),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
