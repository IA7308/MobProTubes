import 'package:flutter/material.dart';
import 'package:flutter_tubes/_dashboard.dart';
import 'package:flutter_tubes/_menu_diet.dart';
import 'package:flutter_tubes/_page_awal.dart';
import 'package:flutter_tubes/_profile.dart';
import 'package:flutter_tubes/_timeline.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARTIKEL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Artikel(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Artikel extends StatefulWidget {
  const Artikel({super.key, required this.title});

  final String title;

  @override
  State<Artikel> createState() => _Artikel();
}

class _Artikel extends State<Artikel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 169, 154),
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                // Handle your filter action here
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text('Iqnaz Diningrat',
                    style: TextStyle(
                        color: Colors.black)),
                accountEmail: Text('Diningratpride@email',
                    style: TextStyle(
                        color: Colors.black)),
                currentAccountPicture: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(''),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                      255, 255, 169, 154),
                ),
              ),
              ListTile(
              title: const Text('Dashboard'),
              splashColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Dashboard(title: 'HealthSis');
                  }),
                );
              },
            ),
              ListTile(
                title: const Text('Profile'),
                splashColor: Colors.red,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const Profile(title: 'HealthSis');
                    }),
                  );
                },
              ),
              ListTile(
                title: const Text('Menu Diet'),
                splashColor: Colors.red,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const MenuDiet(title: 'HealthSis');
                    }),
                  );
                },
              ),
              ListTile(
                title: const Text('Artikel', style: TextStyle(fontWeight: FontWeight.bold),),
                tileColor: Color.fromARGB(
                    255, 255, 169, 154),
                splashColor: Colors.red,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const Artikel(title: 'HealthSis');
                    }),
                  );
                },
              ),
              ListTile(
                title: const Text('Timeline'),
                splashColor: Colors.red,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const Timeline(title: 'HealthSis');
                    }),
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                splashColor: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text('Logout Confirmation'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return PageAwal();
                                }),
                              );
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              const Text(
                'Artikel',
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Card(
                color: Colors.blue,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('Judul'),
                      subtitle: Text('Sub Judul'),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        ElevatedButton(
                          child: const Text('Selengkapnya'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Card(
                color: Color.fromARGB(255, 255, 169, 154),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('C'),
                      subtitle: Text('Sub Judul'),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        ElevatedButton(
                          child: const Text('Selengkapnya'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Card(
                color: Colors.yellow,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('O'),
                      subtitle: Text('Sub Judul'),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        ElevatedButton(
                          child: const Text('Selengkapnya'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Card(
                color: Colors.green,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('Judul'),
                      subtitle: Text('Sub Judul'),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        ElevatedButton(
                          child: const Text('Selengkapnya'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ));
  }
}
