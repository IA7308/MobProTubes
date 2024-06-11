import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tubes/_menu_diet_data.dart';
import 'package:flutter_tubes/_menudietajah.dart';
import 'package:flutter_tubes/_sidebar.dart';
import 'package:flutter_tubes/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MENU DIET',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MenuDiet(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuDiet extends StatefulWidget {
  const MenuDiet({super.key, required this.title});

  final String title;

  @override
  State<MenuDiet> createState() => _MenuDiet();
}

class _MenuDiet extends State<MenuDiet> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> userDataFuture;
  late String uid;
  String? imagepath;
  List<String> jenisItems = ['Vegan', 'Carnivor'];
  String? selectedItems;
  TextEditingController namaController = TextEditingController();
  TextEditingController kaloriController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

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
        selectedIndex: 2,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate([
                const ListTile(
                  title: Text(
                    'Menu Diet',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.5,
                  ),
                  items: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      color: const Color.fromARGB(255, 255, 169, 154),
                      child: Center(
                        child: Image.asset(
                          'images/Food_7.jpg', // Ganti dengan path gambar yang sesuai
                          width: 200, // Sesuaikan lebar gambar sesuai kebutuhan
                          height:
                              200, // Sesuaikan tinggi gambar sesuai kebutuhan
                          fit: BoxFit
                              .cover, // Sesuaikan fit gambar sesuai kebutuhan
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      color: const Color.fromARGB(255, 255, 169, 154),
                      child: Center(
                        child: Image.asset(
                          'images/Food_6.jpg', // Ganti dengan path gambar yang sesuai
                          width: 200, // Sesuaikan lebar gambar sesuai kebutuhan
                          height:
                              200, // Sesuaikan tinggi gambar sesuai kebutuhan
                          fit: BoxFit
                              .cover, // Sesuaikan fit gambar sesuai kebutuhan
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      color: const Color.fromARGB(255, 255, 169, 154),
                      child: Center(
                        child: Image.asset(
                          'images/Food_5.jpg', // Ganti dengan path gambar yang sesuai
                          width: 200, // Sesuaikan lebar gambar sesuai kebutuhan
                          height:
                              200, // Sesuaikan tinggi gambar sesuai kebutuhan
                          fit: BoxFit
                              .cover, // Sesuaikan fit gambar sesuai kebutuhan
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                )
              ])),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 10.0,
                ),
                delegate: SliverChildListDelegate([
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('images/Food_5.jpg'),
                      fit: BoxFit.cover,
                    )),
                    child: Card(
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ListView(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                child: Center(
                                  child: Icon(Icons.food_bank),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              const Center(
                                child: Text(
                                  'Carnivor',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Times New Roman'),
                                ),
                              ),
                              const Center(
                                child: Text(
                                  'For Meat Loves',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const menudiet(title: "Carnivor")
                                          ));
                                    },
                                    child: const Text('More')),
                              )
                            ],
                          ),
                        )),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('images/Food_6.jpg'),
                      fit: BoxFit.cover,
                    )),
                    child: Card(
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ListView(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                child: Center(
                                  child: Icon(Icons.food_bank),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              const Center(
                                child: Text(
                                  'Vegan',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Times New Roman'),
                                ),
                              ),
                              const Center(
                                child: Text(
                                  'For Vegetarian',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const menudiet(title: 'Vegan')
                                          ));
                                    },
                                    child: const Text('More')),
                              )
                            ],
                          ),
                        )),
                  ),
                ]),
              ),
            ],
          )),
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            'Add Menu Diet',
                            style: TextStyle(
                                fontSize: 32.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(color: Colors.black),
                                    image: imagepath != null
                                        ? DecorationImage(
                                            image: NetworkImage(imagepath!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: imagepath == null
                                      ? const Center(
                                          child: Text('No image selected'),
                                        )
                                      : null,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            child: const Text('Upload Gambar'),
                            onPressed: () async {
                              File? file = await getImage();
                              imagepath = await uploadsImage(file!);
                              setState(() {});
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: namaController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Nama Makanan')),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: kaloriController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Kalori')),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: deskripsiController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Deskripsi')),
                            maxLines: null,
                          ),
                        ),
                        DropdownButton(
                          value: selectedItems,
                          hint: Text('Pilih Tipe Makanan'),
                          items: jenisItems.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedItems = newValue!;
                            });
                          },
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              DocumentSnapshot<Map<String, dynamic>> snapshot =
                                  await userDataFuture;

                              String username =
                                  snapshot.data()?['username'] ?? '';
                              insertMenuDiet(
                                  username,
                                  namaController.text,
                                  kaloriController.text,
                                  deskripsiController.text,
                                  selectedItems!,
                                  imagepath!);
                              namaController.clear();
                              kaloriController.clear();
                              deskripsiController.clear();
                              selectedItems = null;
                              imagepath = null;
                              Navigator.pop(context);
                            },
                            child: Text('Post'))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
