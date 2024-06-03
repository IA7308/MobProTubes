import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes/Model/Artikell.dart';
import 'package:flutter_tubes/_page_awal.dart';
import 'package:flutter_tubes/firebase_options.dart';
import 'package:flutter_tubes/Model/timelinee.dart';
import 'package:image_picker/image_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

//PROFILE, REGISTER, LOGIN;

void insertUser(String uid, String firstname, String lastname, String username,
    String email) {
  CollectionReference users =
      FirebaseFirestore.instance.collection('HealthSis');
  users.doc(uid).set({
    'firstname': firstname,
    'lastname': lastname,
    'username': username,
    'email': email,
    'status': '',
    'phone': '',
    'age': '',
    'birthday': '',
    'note': '',
    'photo': 'images/Default.jpg',
  });
}

Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) async {
  DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await FirebaseFirestore.instance.collection('HealthSis').doc(uid).get();
  return userSnapshot;
}

void updateUserData(String uid, String username, String status, String phone,
    DateTime birthday, String note, String photo) {
  CollectionReference users =
      FirebaseFirestore.instance.collection('HealthSis');

  // Hitung umur berdasarkan tanggal lahir
  int age = DateTime.now().year - birthday.year;
  if (DateTime.now().month < birthday.month ||
      (DateTime.now().month == birthday.month &&
          DateTime.now().day < birthday.day)) {
    age--;
  }

  // Format tanggal lahir menjadi string dengan format 'dd MMMM yyyy'
  String formattedBirthday = DateFormat('dd MMMM yyyy').format(birthday);

  users.doc(uid).update({
    'username': username,
    'status': status,
    'phone': phone,
    'age': age.toString(), // Simpan umur sebagai string
    'birthday':
        formattedBirthday, // Simpan tanggal lahir dalam format yang diinginkan
    'note': note,
    'photo': photo,
  });
}

Future<String> uploadImage(File imageFile) async {
  String filename = basename(imageFile.path);

  Reference ref = FirebaseStorage.instance.ref().child(filename);
  UploadTask task = ref.putFile(imageFile);
  TaskSnapshot snapshot = await task.whenComplete(() => {});

  return await snapshot.ref.getDownloadURL();
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

Stream<List<Timelinee>> getTimelineStream() {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Timeline');
  return collReff.snapshots().map((QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((doc) => Timelinee.fromDocument(doc))
        .toList();
  });
}

//Upload Gambar
Future<String> uploadsImage(File imageName) async {
  String filename = basename(imageName.path);

  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child(filename);
  UploadTask uploadTask = ref.putFile(imageName);
  TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

  return await snapshot.ref.getDownloadURL();
}

//Get Image
Future<File?> getImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    return null;
  }
}

//ARTIKEL CRUD

void insertArtikel(String name, String judul, String isi) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Artikel');
  collReff.add({
    'name': name,
    'judul': judul,
    'isi': isi,
  });
}

void deleteArtikel(Artikell entry) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Artikel');
  collReff.doc(entry.id).delete();
}

void updateArtikel(String docId, String judul, String isi) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Artikel');
  collReff.doc(docId).update({
    'judul': judul,
    'isi': isi,
  });
}

Stream<List<Artikell>> getArtikellStream() {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Artikel');
  return collReff.snapshots().map((QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) => Artikell.fromDocument(doc)).toList();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
