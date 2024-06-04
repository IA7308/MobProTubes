import 'package:flutter/material.dart';
import 'package:flutter_tubes/_sidebar.dart';

class IsiArtikel extends StatelessWidget {
  final String nama;
  final String judul;
  final String subJudul;
  final String imagepath;

  const IsiArtikel(
      {super.key,
      required this.nama,
      required this.judul,
      required this.subJudul,
      required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        selectedIndex: 1,
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
                'judul',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Text(nama, style: TextStyle(fontSize: 12),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                subJudul,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
