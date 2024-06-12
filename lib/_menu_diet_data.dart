import 'package:flutter/material.dart';
import 'package:flutter_tubes/_sidebar.dart';

class IsiDataMenu extends StatelessWidget {
  final String judul;
  final String subJudul;
  final String penjelasan;
  final String chef;
  final String kalori;
  final String? imagepath;

  const IsiDataMenu({super.key, required this.judul, required this.subJudul, required this.penjelasan, required this.chef, required this.kalori, required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 169, 154),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 169, 154),
        title: Text(judul),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 500,
              height: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.black),
                  image: DecorationImage(
                    image: NetworkImage(imagepath!),
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                judul, // Nama Makanan
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Text(
              chef, //Nama Pembuat 
              style: TextStyle(fontSize: 12),
            ),
            Text(
              subJudul, //Jenis Makanan 
              style: TextStyle(fontSize: 12),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                penjelasan, //Deskripsi
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
