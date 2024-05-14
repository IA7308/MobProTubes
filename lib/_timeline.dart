import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tubes/Model/timelinee.dart';
import 'package:flutter_tubes/_sidebar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_tubes/main.dart';
import 'firebase_options.dart';

List<String> Judul = [];
List<String> SubJudul = [];
TextEditingController JudulController = TextEditingController();
TextEditingController SubJudulController = TextEditingController();
List<bool> Likes = [];

Future<List<Timelinee>> _timelineFuture = getTimeline();

void main() async {
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
  void initState() {
    super.initState();
    _timelineFuture = getTimeline();
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
        selectedIndex: 4,
      ),
      body: FutureBuilder<List<Timelinee>>(
        future: _timelineFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No timeline entries found.'));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(data[index].judul),
                    subtitle: Text(data[index].isi),
                    trailing: GestureDetector(
                      onTap: () async {
                        //  setState(() {
                        //    data[index].like = !data[index].like;
                        //  });
                        // Update the like status in Firestore
                        updateLikeStatus(data[index]);
                        _timelineFuture = getTimeline();
                      },
                      child: Icon(
                        data[index].like
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: data[index].like ? Colors.red : null,
                      ),
                    ),
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('konfirmasi Delete'),
                              content:
                                  const Text('Apakah anda yakin ingin hapus?'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    _timelineFuture = getTimeline();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Tidak'),
                                ),
                                TextButton(
                                  onPressed: ()async {
                                    deleteTimeline(data[index]);
                                    _timelineFuture = getTimeline();
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Ya',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
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
                              onPressed: () async {
                                setState(() {
                                  Judul.add(JudulController.text);
                                  SubJudul.add(SubJudulController.text);
                                  Likes.add(false);
                                });

                                insertTimeline('Iqnaz', JudulController.text,
                                    SubJudulController.text, false);

                                JudulController.clear();
                                SubJudulController.clear();

                                _timelineFuture = getTimeline();
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
