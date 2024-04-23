import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_tubes/_sidebar.dart';


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
        backgroundColor: const Color.fromARGB(255, 255, 169, 154),
        title: Text(widget.title),
      ),
      drawer: const Sidebar(selectedIndex: 0,),
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
                    child: Stack(
                      children: <Widget>[
                        Image.asset('images/HealthPeople.jpg'),
                      ],
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    color: Colors.blue,
                    child: Stack(
                      children: <Widget>[
                        Image.asset('images/Dashboard.png')
                      ], 
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    color: Colors.green,
                    child: Stack(
                      children: <Widget>[
                        Image.asset('images/HealthSIs.jpg')
                      ], 
                    )
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
