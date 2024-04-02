import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
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
                accountName:
                    Text('Iqnaz Diningrat'), // Ganti dengan nama pengguna
                accountEmail:
                    Text('Diningratpride@email'), // Ganti dengan email pengguna
                currentAccountPicture: CircleAvatar(
                  radius: 60, // Atur radius lingkaran foto profil
                  backgroundImage: AssetImage(''),
                ),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Menu Diet'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Artikel'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Timeline'),
                onTap: () {},
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
                      title: Text('BA'),
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
                color: Colors.red,
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
                      title: Text('T'),
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
