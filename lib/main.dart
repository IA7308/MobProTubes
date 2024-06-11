import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes/Model/Artikell.dart';
import 'package:flutter_tubes/_page_awal.dart';
import 'package:flutter_tubes/firebase_options.dart';
import 'package:flutter_tubes/Model/timelinee.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

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
    'photo': 'https://firebasestorage.googleapis.com/v0/b/mobprotubes-1a30b.appspot.com/o/Default.jpg?alt=media&token=766800c7-998d-48a9-84de-58f07b65d9b8',
  });
}

Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) async {
  DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await FirebaseFirestore.instance.collection('HealthSis').doc(uid).get();
  return userSnapshot;
}

void updateUserData(String uid, String username, String phone, String status, DateTime birthday, String note, String photo) {
  CollectionReference users = FirebaseFirestore.instance.collection('HealthSis');

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
    'age': '$age tahun', // Simpan umur sebagai string
    'birthday': formattedBirthday, // Simpan tanggal lahir dalam format yang diinginkan
    'note': note,
    'photo': photo,
  });
}

void DeletePhotos(String uid) {
  CollectionReference users = FirebaseFirestore.instance.collection('HealthSis');

  users.doc(uid).update({
    'photo': 'https://firebasestorage.googleapis.com/v0/b/mobprotubes-1a30b.appspot.com/o/Default.jpg?alt=media&token=766800c7-998d-48a9-84de-58f07b65d9b8',
  });
}

Future<File> defaultImage(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final directory = await getTemporaryDirectory();
      final filePath = path.join(directory.path, path.basename(url));
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to download image');
    }
  }


void insertTimeline(String name, String judul, String isi, bool like, String photo) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Timeline');
  collReff.add({'name': name, 'judul': judul, 'isi': isi, 'like': like, 'photo' : photo});
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

void updateTimeline(String docId, String judul, String isi, String photo) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Timeline');
  collReff.doc(docId).update({
    'judul': judul,
    'isi': isi,
    'photo': photo,
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
  String filename = path.basename(imageName.path);

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

void insertArtikel(String name, String judul, String isi, String photo) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Artikel');
  collReff.add({
    'name': name,
    'judul': judul,
    'isi': isi,
    'photo': photo,
  });
}

void deleteArtikel(Artikell entry) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Artikel');
  collReff.doc(entry.id).delete();
}

void updateArtikel(String docId, String judul, String isi, String photo) {
  CollectionReference collReff =
      FirebaseFirestore.instance.collection('Artikel');
  collReff.doc(docId).update({
    'judul': judul,
    'isi': isi,
    'photo': photo,
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
