import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes/_artikel.dart';
import 'package:flutter_tubes/_dashboard.dart';
import 'package:flutter_tubes/_menu_diet.dart';
import 'package:flutter_tubes/_page_awal.dart';
import 'package:flutter_tubes/_profile.dart';
import 'package:flutter_tubes/_timeline.dart';
import 'package:flutter_tubes/main.dart';

class Sidebar extends StatefulWidget {
  final int selectedIndex;
  const Sidebar({super.key, required this.selectedIndex});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> userDataFuture;
  late String uid;

  List<String> pageTitles = [
    'Dashboard',
    'Artikel',
    'Menu Diet',
    'Profile',
    'Timeline',
  ];

  List<Widget> pages = [
    const Dashboard(title: 'HealthSis'),
    const Artikel(title: 'HealthSis'),
    const MenuDiet(title: 'HealthSis'),
    const Profile(title: 'HealthSis'),
    const Timeline(title: 'HealthSis'),
  ];

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
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: userDataFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.exists) {
                  var userData = snapshot.data!.data()!;
                  return UserAccountsDrawerHeader(
                    accountName: Text('${userData['username']}',
                        style: TextStyle(color: Colors.black)),
                    accountEmail: Text('${userData['email']}',
                        style: TextStyle(color: Colors.black)),
                    currentAccountPicture: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage('${userData['photo']}'),
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 169, 154),
                    ),
                  );
                } else {
                  return Text('Guest');
                }
              },
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: pageTitles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(pageTitles[index]),
                    splashColor: Colors.red,
                    selected: widget.selectedIndex == index,
                    selectedColor: Colors.purple,
                    selectedTileColor: const Color.fromARGB(255, 255, 169, 154),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return pages[index];
                        }),
                      );
                    },
                  );
                },
              ),
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
              splashColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: const Text('konfirmasi Logout'),
                      content: const Text('Apakah anda yakin ingin logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                          child: const Text('Tidak'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return PageAwal();
                                },
                              ),
                            );
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
          ],
        ),
      ),
    );
  }
}
