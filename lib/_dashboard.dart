import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tubes/_menudietajah.dart';
import 'package:flutter_tubes/_sidebar.dart';
import 'package:flutter_tubes/_menu_diet.dart';
import 'package:flutter_tubes/main.dart';
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

Future<String> getName() async{
  DocumentSnapshot<Map<String, dynamic>> snapshot =
                          await userDataFuture;

                       String username = snapshot.data()?['username'] ?? '';
                       return username;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 169, 154),
        title: FutureBuilder<String>(
        future: getName(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Text('Hello, ${snapshot.data}');
          } else {
            return Text('Hello');
          }
        },
      ),
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
                        Image.asset('images/Foto_1.png'),
                        Text('')
                      ],
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    color: Colors.blue,
                    child: Stack(
                      children: <Widget>[
                        Image.asset('images/Foto_2.png')
                      ], 
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    color: Colors.green,
                    child: Stack(
                      children: <Widget>[
                        Image.asset('images/Foto_3.png')
                      ], 
                    )
                  ),
                ]),
            const SizedBox(
              height: 40,
            ),
          Container(
            child: Text('Food Recommendation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            ) ,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Image.asset('images/Food_6.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  ),
                  title: Text('Vegan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                 subtitle: Text('For Vegetarian'),
                 trailing: ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const menudiet(title: 'Vegan')
                                          ));
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  ),
                  child: Text('View More'),
                 ),
                ),
              ),
            ),
          ),
          SizedBox(
             width: 10 ,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Image.asset('images/Food_5.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  ),
                  title: Text('Carnivor',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                 subtitle: Text('For Meat Loves'),
                 trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const menudiet(title: "Carnivor")
                                          ));
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  ),
                  child: Text('View More'),
                 ),
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
