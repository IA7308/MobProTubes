import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes/Model/Artikell.dart';
import 'package:flutter_tubes/_artikelMain.dart';
import 'package:flutter_tubes/_sidebar.dart';
import 'package:flutter_tubes/main.dart';

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
  late Future<DocumentSnapshot<Map<String, dynamic>>> userDataFuture;
  late String uid;
  String? imagepath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      userDataFuture =
          getUserData(uid); // Panggil fungsi untuk mendapatkan data pengguna
    }
    artikelFuture = getArtikellStream();
  }

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
      drawer: const Sidebar(
        selectedIndex: 1,
      ),
      body: StreamBuilder<List<Artikell>>(
        stream: artikelFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(articles[index].photo),
                  ),
                  title: Text(articles[index].judul),
                  subtitle: Text(articles[index].judul),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IsiArtikel(
                            nama: articles[index].nama,
                            judul: articles[index].judul,
                            subJudul: articles[index].isi,
                            imagepath: articles[index].photo,
                          ),
                        ),
                      );
                    },
                    child: const Text('More'),
                  ),
                  onTap: () async {
                    DocumentSnapshot<Map<String, dynamic>> snapshot =
                        await userDataFuture;

                    String username = snapshot.data()?['username'] ?? '';

                    if (articles[index].nama == username) {
                      JudulController.text = articles[index].judul;
                      SubJudulController.text = articles[index].isi;
                      imagepath = articles[index].photo;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Text(
                                        'Edit Artikel',
                                        style: TextStyle(fontSize: 32.0),
                                      ),
                                    ),
                                    Container(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 200,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    color: Colors.black),
                                                image: imagepath != null
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                            imagepath!),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : null,
                                              ),
                                              child: imagepath == null
                                                  ? const Center(
                                                      child: Text(
                                                          'No image selected'),
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
                                        child: const Text('Upload Gambar'),
                                        onPressed: () async {
                                          File? file = await getImage();
                                          imagepath = await uploadsImage(file!);
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextField(
                                        controller: JudulController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Judul',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextField(
                                        controller: SubJudulController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Apa Yang Anda Pikirkan?',
                                        ),
                                        maxLines:
                                            null, // Makes the TextField multiline
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Center(
                                        child: ElevatedButton(
                                          child: const Text('Update'),
                                          onPressed: () async {
                                            // Replace 'articles[index].id' with the actual ID
                                            updateArtikel(
                                                articles[index].id,
                                                JudulController.text,
                                                SubJudulController.text,
                                                imagepath!);
                                            JudulController.clear();
                                            SubJudulController.clear();
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  onLongPress: () async {
                    DocumentSnapshot<Map<String, dynamic>> snapshot =
                        await userDataFuture;

                    String username = snapshot.data()?['username'] ?? '';

                    if (articles[index].nama == username) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Konfirmasi Delete'),
                            content: const Text(
                                'Apakah Anda yakin ingin hapus konten ini?'),
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
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: ElevatedButton(
          child: const Icon(Icons.add),
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
                                    ? const Center(
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
                            child: const Text('UploadGambar'),
                            onPressed: () async {
                              File? file = await getImage();
                              imagepath = await uploadsImage(file!);
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
                              onPressed: () async {
                                DocumentSnapshot<Map<String, dynamic>>
                                    snapshot = await userDataFuture;
                                String username =
                                    snapshot.data()?['username'] ?? '';

                                insertArtikel(username, JudulController.text,
                                    SubJudulController.text, imagepath!);
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
