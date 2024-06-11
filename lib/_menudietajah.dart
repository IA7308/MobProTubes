import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes/Model/menudiett.dart';
import 'package:flutter_tubes/_menu_diet.dart';
import 'package:flutter_tubes/_menu_diet_data.dart';
import 'package:flutter_tubes/_sidebar.dart';
import 'package:flutter_tubes/main.dart';

TextEditingController namaController = TextEditingController();
TextEditingController kaloriController = TextEditingController();
TextEditingController deskripsiController = TextEditingController();

late Stream<List<Menudiett>> menuDietFuture;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const menudiet(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class menudiet extends StatefulWidget {
  const menudiet({super.key, required this.title});

  final String title;

  @override
  State<menudiet> createState() => _menudietajah();
}

class _menudietajah extends State<menudiet> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> userDataFuture;
  late String uid;
  String? imagepath;
  List<String> jenisItems = ['Vegan', 'Carnivor'];
  String? selectedItems;

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
    menuDietFuture = getMDStream();
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
        selectedIndex: 1,
      ),
      body: StreamBuilder<List<Menudiett>>(
        stream: menuDietFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var menudiets = snapshot.data!;
          return ListView.builder(
            itemCount: menudiets.length,
            itemBuilder: (context, index) {
              if (menudiets[index].jenisMakanan == widget.title) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(menudiets[index].photo),
                    ),
                    title: Text(menudiets[index].namaMenu),
                    subtitle: Text(menudiets[index].deskripsi),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IsiDataMenu(
                                judul: menudiets[index].namaMenu,
                                kalori: menudiets[index].kalori,
                                penjelasan: menudiets[index].deskripsi,
                                subJudul: menudiets[index].jenisMakanan,
                                chef: menudiets[index].namaPembuat,
                                imagepath: menudiets[index].photo,
                                // jenis: menudiets[index].jenisMakanan
                                ),
                          ),
                        );
                      },
                      child: const Text('More'),
                    ),
                    onTap: () async {
                      DocumentSnapshot<Map<String, dynamic>> snapshot =
                          await userDataFuture;

                      String username = snapshot.data()?['username'] ?? '';

                      if (menudiets[index].namaPembuat == username) {
                        namaController.text = menudiets[index].namaMenu;
                        kaloriController.text = menudiets[index].kalori;
                        deskripsiController.text = menudiets[index].deskripsi;
                        imagepath = menudiets[index].photo;
                        selectedItems = menudiets[index].jenisMakanan;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text(
                                          'Edit Menu',
                                          style: TextStyle(fontSize: 32.0),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 200,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  image: imagepath != null
                                                      ? DecorationImage(
                                                          image: NetworkImage(
                                                              imagepath!),
                                                          fit: BoxFit.cover,
                                                        )
                                                      : null,
                                                ),
                                                child: imagepath == null
                                                    ? const Center(
                                                        child: Text(
                                                            'No image selected'),
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
                                            imagepath =
                                                await uploadsImage(file!);
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextField(
                                          controller: namaController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Menu Diet',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextField(
                                          controller: kaloriController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Masukkan Total Kalori',
                                          ),
                                          maxLines:
                                              null, // Makes the TextField multiline
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextField(
                                          controller: deskripsiController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Masukkan Deskripsi',
                                          ),
                                          maxLines:
                                              null, // Makes the TextField multiline
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
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Center(
                                          child: ElevatedButton(
                                            child: const Text('Update'),
                                            onPressed: () async {
                                              // Replace 'menudiets[index].id' with the actual ID
                                              updateMenuDiet(
                                                  menudiets[index].id,
                                                  namaController.text,
                                                  kaloriController.text,
                                                  deskripsiController.text,
                                                  selectedItems!,
                                                  imagepath!);
                                              namaController.clear();
                                              kaloriController.clear();
                                              deskripsiController.clear();
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    onLongPress: () async {
                      DocumentSnapshot<Map<String, dynamic>> snapshot =
                          await userDataFuture;

                      String username = snapshot.data()?['username'] ?? '';

                      if (menudiets[index].namaPembuat == username) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Konfirmasi Delete'),
                              content: const Text(
                                  'Apakah Anda yakin ingin hapus konten ini?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Tidak'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteMenuDiet(menudiets[index]);
                                    Navigator.pop(context);
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
                      }
                    },
                  ),
                );
              }else{
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}
