import 'package:flutter/material.dart';
import 'package:flutter_tubes/_sidebar.dart';

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
        drawer: const Sidebar(),
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
