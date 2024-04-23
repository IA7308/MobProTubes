import 'package:flutter/material.dart';
import 'package:flutter_tubes/_sidebar.dart';

class IsiArtikel extends StatelessWidget {
  final String judul;
  final String subJudul;

  const IsiArtikel({Key? key, required this.judul, required this.subJudul}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 169, 154),
        title: Text('$judul'),
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
              '$judul',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$subJudul',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
