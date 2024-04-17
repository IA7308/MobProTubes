import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_tubes/_artikel.dart';
import 'package:flutter_tubes/_menu_diet.dart';
import 'package:flutter_tubes/_page_awal.dart';
import 'package:flutter_tubes/_profile.dart';
import 'package:flutter_tubes/_timeline.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DASHBOARD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Dashboard(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.title});

  final String title;

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 169, 154),
        title: Text(widget.title),
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
                          child: const Text('Yes', style: TextStyle(color: Colors.red),),
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
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListView(
          children: <Widget>[
            CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        'Slide 1',
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'Slide 2',
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        'Slide 3',
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                    ),
                  ),
                ]),
            const SizedBox(
              height: 100.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 70.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Hi Sis,',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Selamat Datang di HealthSis',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
