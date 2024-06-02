import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes/Model/Artikell.dart';
import 'package:flutter_tubes/_artikelMain.dart';
import 'package:flutter_tubes/_sidebar.dart';
import 'package:flutter_tubes/main.dart';

List<String> Judul = [];
List<String> SubJudul = [];
TextEditingController JudulController = TextEditingController();
TextEditingController SubJudulController = TextEditingController();



late Stream<List<Artikell>> artikelFuture;

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
  String? imagepath;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    artikelFuture = getArtikellStream();
  }

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
      drawer: const Sidebar(
        selectedIndex: 1,
      ),
      body: StreamBuilder<List<Artikell>>(
        stream: artikelFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              var article = articles[index];
              return Card(
                child: ListTile(
                  leading: Image.asset('images/Dashboard.png'),
                  title: Text(article.judul),
                  subtitle: Text(article.judul),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IsiArtikel(
                            judul: article.judul,
                            subJudul: article.judul,
                          ),
                        ),
                      );
                    },
                    child: Text('More'),
                  ),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi Delete'),
                          content: const Text('Apakah Anda yakin ingin hapus?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Tidak'),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteArtikel(articles[index]);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Ya',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
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
                      Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(color: Colors.black),
                                  image: imagepath != null
                                      ? DecorationImage(
                                          image: NetworkImage(imagepath!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: imagepath == null
                                    ? Center(
                                        child: Text('No image selected'),
                                      )
                                    : null,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            child: Text('SignInAnonyms'),
                            onPressed: () async {
                              // AuthServices;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            child: Text('UploadGambar'),
                            onPressed: () async {
                              File? file = await getImage();
                              imagepath = await uploadImage(file!);

                              setState(() {});
                            },
                          )),
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
                                insertArtikel('iqnas', JudulController.text,
                                    SubJudulController.text);
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
