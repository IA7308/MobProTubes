import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes/_page_awal.dart';
import 'package:flutter_tubes/_timeline.dart';
import 'package:flutter_tubes/firebase_options.dart';
import 'package:flutter_tubes/Model/timelinee.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

void insertTimeline(String name, String judul, String isi, bool like) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Timeline');
  collReff.add({'name': name, 'judul': judul, 'isi': isi, 'like': like});
}

  void deleteTimeline(Timelinee entry)  {
    CollectionReference collReff = FirebaseFirestore.instance.collection('Timeline');
     collReff.doc(entry.id).delete();
  }

void updateLikeStatus(Timelinee entry)  {
    CollectionReference collReff = FirebaseFirestore.instance.collection('Timeline');
    if(entry.like == false){
       collReff.doc(entry.id).update({'like': true});
    }else{
       collReff.doc(entry.id).update({'like': false});
    }
  }

  void updateTimeline(String docId, String judul, String isi)  {
    CollectionReference collReff = FirebaseFirestore.instance.collection('Timeline');
     collReff.doc(docId).update({
      'judul': judul,
      'isi': isi,
    });
  }

Future<List<Timelinee>> getTimeline()async{
  CollectionReference collReff = FirebaseFirestore.instance.collection('Timeline');
  QuerySnapshot querySnapshot = await collReff.get();

  return querySnapshot.docs.map((doc) => Timelinee.fromDocument(doc)).toList();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthSis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PageAwal(),
      debugShowCheckedModeBanner: false,
    );
  }
}
