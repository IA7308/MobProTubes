import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tubes/_sidebar.dart';

late List<String> Judul = [];
late List<String> SubJudul = [];
late TextEditingController JudulController = TextEditingController();
late TextEditingController SubJudulController = TextEditingController();
late List<bool> Likes = [];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timeline',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Timeline(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Timeline extends StatefulWidget {
  const Timeline({super.key, required this.title});

  final String title;

  @override
  State<Timeline> createState() => _Timeline();
}

class _Timeline extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 169, 154),
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
      drawer: const Sidebar(selectedIndex: 4,),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: Judul.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text('${Judul[index]}'),
                subtitle: Text('${SubJudul[index]}'),
                trailing: GestureDetector(
                  onTap: () {
                    setState(() {
                      Likes[index] = !Likes[index];
                    });
                  },
                  child: Icon(
                    Likes[index] ? Icons.favorite : Icons.favorite_border,
                    color: Likes[index] ? Colors.red : null,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
                          'Add Timeline',
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
                                  Likes.add(false);
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
