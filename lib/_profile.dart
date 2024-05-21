import 'package:flutter/material.dart';
import 'package:flutter_tubes/Model/healthsis.dart';
import 'package:flutter_tubes/_edit_profile.dart';
import 'package:flutter_tubes/_sidebar.dart';
import 'package:flutter_tubes/main.dart';

Future<List<HealthSis>> _userData = getHealthsis();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PROFILE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Profile(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key, required this.title});

  final String title;

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  void initState() {
    super.initState();
    _userData = getHealthsis();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 169, 154),
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<HealthSis>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No User entries found.'));
          } else {
            final data = snapshot.data!.first;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'Times New Roman',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return const EditProfile(title: 'HealthSis');
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    const Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('images/Default.jpg'),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text(data.username),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(data.phone.toString()),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.info),
                            title: Text(data.status),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.calendar_today),
                            title: Text(data.age),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.note),
                            title: Text(data.note),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      drawer: const Sidebar(selectedIndex: 3),
    );
  }
}
