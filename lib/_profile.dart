import 'package:flutter/material.dart';
import 'package:flutter_tubes/_artikel.dart';
import 'package:flutter_tubes/_edit_profile.dart';
import 'package:flutter_tubes/_menu_diet.dart';
import 'package:flutter_tubes/_dashboard.dart';
import 'package:flutter_tubes/_page_awal.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 169, 154),
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return const Dashboard(title: 'HealthSis');
                }),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                  backgroundImage: AssetImage(''),
                ),
              ),
              const SizedBox(height: 20.0),
              ListView(
                shrinkWrap: true,
                children: const [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Username'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('No HP'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text('Status'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading:
                          Icon(Icons.calendar_today),
                      title: Text('Umur'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.note),
                      title: Text('Note'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
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
              title: const Text('Dashboard'),
              splashColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Dashboard(title: 'HealthSis');
                  }),
                );
              },
            ),
              ListTile(
                title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold),),
                tileColor: Color.fromARGB(
                    255, 255, 169, 154),
                splashColor: Colors.red,
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
                splashColor: Colors.red,
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
                splashColor: Colors.red,
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
                splashColor: Colors.red,
                onTap: () {},
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
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(title: 'HealthSis'),));
                }, 
                child: Text('Home')
              )
            ],
          ),
        ),
      ),
    );
  }
}
