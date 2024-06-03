import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes/_edit_profile.dart';
import 'package:flutter_tubes/_sidebar.dart';
import 'package:flutter_tubes/main.dart'; // Import file main.dart untuk menggunakan getUserData

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
  late Future<DocumentSnapshot<Map<String, dynamic>>> userDataFuture;
  late String uid; // Variabel untuk menyimpan UID pengguna yang login

  @override
  void initState() {
    super.initState();
    // Dapatkan UID pengguna yang login dari Firebase Auth
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      userDataFuture = getUserData(uid); // Panggil fungsi untuk mendapatkan data pengguna
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 169, 154),
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.hasData && snapshot.data != null) {
                Map<String, dynamic> userData = snapshot.data!.data()!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return EditProfile(title: 'HealthSis');
                                }),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(userData['photo']),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ListView(
                        shrinkWrap: true,
                        children: [
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text('${userData['username']}'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.phone),
                              title: Text('${userData['phone']}'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.info),
                              title: Text('${userData['status']}'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.calendar_today),
                              title: Text('${userData['age']}'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.note),
                              title: Text('${userData['note']}'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Text('Data not found.');
              }
            }
          },
        ),
      ),
      drawer: const Sidebar(selectedIndex: 3,),
    );
  }
}
