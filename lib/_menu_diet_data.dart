import 'package:flutter/material.dart';
import 'package:flutter_tubes/_sidebar.dart';

class IsiDataMenu extends StatelessWidget {
  final String judul;
  final String subJudul;
  final String penjelasan;
  final String chef;
  final int kalori;

  const IsiDataMenu({super.key, required this.judul, required this.subJudul, required this.penjelasan, required this.chef, required this.kalori});

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
      drawer: const Sidebar(selectedIndex: 1,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              judul,
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              subJudul,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              penjelasan,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              chef,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              '$kalori',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
