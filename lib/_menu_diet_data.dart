import 'package:flutter/material.dart';
import 'package:flutter_tubes/_sidebar.dart';

class IsiDataMenu extends StatelessWidget {
  final String judul;
  final String subJudul;
  final String penjelasan;
  final String chef;
  final int kalori;

  const IsiDataMenu({Key? key, required this.judul, required this.subJudul, required this.penjelasan, required this.chef, required this.kalori}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 169, 154),
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
            Text(
              '$penjelasan',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$chef',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$kalori',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
