import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
      home: const MyHomePage(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('Iqnaz Diningrat'), // Ganti dengan nama pengguna
              accountEmail: Text('Diningratpride@email'), // Ganti dengan email pengguna
              currentAccountPicture: CircleAvatar(
                radius: 60, // Atur radius lingkaran foto profil
                backgroundImage: AssetImage(''),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Menu Diet'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Artikel'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Timeline'),
              onTap: () {},
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
