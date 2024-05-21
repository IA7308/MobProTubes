import 'dart:ffi';
import 'package:crypt/crypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes/_page_awal.dart';
import 'package:flutter_tubes/_timeline.dart';
import 'package:flutter_tubes/firebase_options.dart';
import 'package:flutter_tubes/Model/timelinee.dart';
import 'package:flutter_tubes/Model/healthsis.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

void insertHealthsis(String firstname, String lastname, String username,
    String email, String password) {
  String hashedPassword = Crypt.sha256(password).toString();
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('HealthSis');
  collReff.add({
    'firstname': firstname,
    'lastname': lastname,
    'username': username,
    'email': email,
    'password': hashedPassword,
    'status': null,
    'phone': null,
    'age': null,
    'birthday': null,
    'note': null,
    'photo': 'images/Default.jpg'
  });
}

void deleteHealthsis(HealthSis entry) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('HealthSis');
  collReff.doc(entry.id).delete();
}

void updateProfile(String docId, String username, String status, String phone,
    String age, String birthday, String note, String photo) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('HealthSis');
  collReff.doc(docId).update({
    'username': username,
    'status': status,
    'phone': phone,
    'age': age,
    'birthday': birthday,
    'note': note,
    'photo': photo,
  });
}

Future<List<HealthSis>> getHealthsis() async {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('HealthSis');
  QuerySnapshot querySnapshot = await collReff.get();

  return querySnapshot.docs.map((doc) => HealthSis.fromDocument(doc)).toList();
}

void insertTimeline(String name, String judul, String isi, bool like) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Timeline');
  collReff.add({'name': name, 'judul': judul, 'isi': isi, 'like': like});
}

void deleteTimeline(Timelinee entry) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Timeline');
  collReff.doc(entry.id).delete();
}

void updateLikeStatus(Timelinee entry) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Timeline');
  if (entry.like == false) {
    collReff.doc(entry.id).update({'like': true});
  } else {
    collReff.doc(entry.id).update({'like': false});
  }
}

void updateTimeline(String docId, String judul, String isi) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Timeline');
  collReff.doc(docId).update({
    'judul': judul,
    'isi': isi,
  });
}

Future<List<Timelinee>> getTimeline() async {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Timeline');
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
