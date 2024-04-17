import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tubes/_menu_diet.dart';
import 'package:flutter_tubes/_page_awal.dart';
import 'package:flutter_tubes/_profile.dart';
import 'package:flutter_tubes/_artikel.dart';

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
                title: const Text('Profile'),
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
                title: const Text('Artikel'),
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
          child: ListView.builder(
            itemCount: Judul.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(),
                  title: Text('${Judul[index]}'),
                  subtitle: Text('${SubJudul[index]}'),
                  trailing: GestureDetector(
                    onTap: (){
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
          onPressed: (){
            showDialog(
              context: context, 
              builder: (context) {
                return Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Add Timeline', style: TextStyle(fontSize: 32.0),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                        controller: JudulController,
                        decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Judul'),
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                        controller: SubJudulController,
                        decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Apa Yang Anda Pikirkan?'),
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                        child: FloatingActionButton(
                          child: Text('Post'),
                          onPressed: (){
                            setState(() {
                              Judul.add(JudulController.text);
                              SubJudul.add(SubJudulController.text);
                              Likes.add(false);
                            });
                            JudulController.clear();
                            SubJudulController.clear();
                            Navigator.pop(context);
                          }
                        ),
                      ),
                      )
                    ],
                  ),
                );
              },

            );
          }
          ),);
  }
}
