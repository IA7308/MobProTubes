import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tubes/Model/timelinee.dart';
import 'package:flutter_tubes/_sidebar.dart';
import 'package:flutter_tubes/main.dart';

TextEditingController JudulController = TextEditingController();
TextEditingController SubJudulController = TextEditingController();

late Stream<List<Timelinee>> _timelineFuture;

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
    _timelineFuture = getTimelineStream();
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
      body: StreamBuilder<List<Timelinee>>(
        stream: _timelineFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No timeline entries found.'));
          } else {
            final data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    // leading: const CircleAvatar(
                    //   child: Icon(Icons.person),
                    // ),
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CircleAvatar(
                            child: Icon(Icons.person),
                            radius: 15.0,
                          ),
                        ),
                        // Title in the middle
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              data[index].judul,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        // GestureDetector with Icon on the right
                        GestureDetector(
                          onTap: () async {
                            updateLikeStatus(data[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              data[index].like
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: data[index].like ? Colors.red : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 53.0, vertical: 5.0),
                      child: Text(data[index].isi),
                    ),
                    // trailing: GestureDetector(
                    //   onTap: () async {
                    //     updateLikeStatus(data[index]);
                    //   },
                    //   child: Icon(
                    //     data[index].like
                    //         ? Icons.favorite
                    //         : Icons.favorite_border,
                    //     color: data[index].like ? Colors.red : null,
                    //   ),
                    // ),
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
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Tidak'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    deleteTimeline(data[index]);
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
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey,
                    thickness: 1,
                  );
                },
              ),
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
                                insertTimeline('Iqnaz', JudulController.text,
                                    SubJudulController.text, false);

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
