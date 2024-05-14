import 'package:flutter/material.dart';
import 'package:flutter_tubes/_artikelMain.dart';
import 'package:flutter_tubes/_sidebar.dart';

List<String> Judul = [];
List<String> SubJudul = [];
TextEditingController JudulController = TextEditingController();
TextEditingController SubJudulController = TextEditingController();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      drawer: const Sidebar(selectedIndex: 1,),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: Judul.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Image.asset('images/Dashboard.png'),
                  title: Text(Judul[index]),
                  subtitle: Text(SubJudul[index]),
                  trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IsiArtikel(
                                judul: Judul[index],
                                subJudul: SubJudul[index],
                              ),
                            ));
                      },
                      child: Text('More')),
                ),
              );
            },
          )),
      floatingActionButton: ElevatedButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'Add Artikel',
                          style: TextStyle(fontSize: 32.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: JudulController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Judul'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: SubJudulController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Apa Yang Anda Pikirkan?'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: FloatingActionButton(
                              child: const Text('Post'),
                              onPressed: () {
                                setState(() {
                                  Judul.add(JudulController.text);
                                  SubJudul.add(SubJudulController.text);
                                });
                                JudulController.clear();
                                SubJudulController.clear();
                                Navigator.pop(context);
                              }),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
