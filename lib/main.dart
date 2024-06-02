import 'dart:ffi';
import 'dart:io';
import 'package:crypt/crypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes/Model/Artikell.dart';
import 'package:flutter_tubes/_page_awal.dart';
import 'package:flutter_tubes/_timeline.dart';
import 'package:flutter_tubes/firebase_options.dart';
import 'package:flutter_tubes/Model/timelinee.dart';
import 'package:flutter_tubes/Model/healthsis.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

//PROFILE, REGISTER, LOGIN;

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
    'password': password,
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


Future<bool> login(String email, String password) async {
  try {
    // Ambil data pengguna berdasarkan email dari Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('HealthSis')
        .where('email', isEqualTo: email)
        .get();

    // Jika tidak ada pengguna dengan email yang cocok, kembalikan false
    if (querySnapshot.size == 0) {
      return false;
    }

    // Validasi password
    String hashedPasswordFromDB = querySnapshot.docs.first.get('password');
    // String passwrodDB = decrypt.sha256(hashedPasswordFromDB).toString();
    String hashedPasswordInput = Crypt.sha256(password).toString();

    print(hashedPasswordInput + " dan \t"+ hashedPasswordFromDB );

    // Jika password tidak sesuai, kembalikan false
    if (hashedPasswordFromDB != hashedPasswordInput) {
      return false;
    }

    // Jika email dan password cocok, kembalikan true
    return true;
  } catch (e) {
    // Tangani kesalahan jika terjadi
    print('Error during login: $e');
    return false;
  }
}

//TIMELINE CRUD

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
  CollectionReference collReff = FirebaseFirestore.instance.collection('Timeline');
  return collReff.snapshots().map((QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) => Timelinee.fromDocument(doc)).toList();
  });
}


//Upload Gambar
  Future<String> uploadImage(File imageName) async {
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
  collReff.add({'name': name, 'judul': judul, 'isi': isi,});
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
  CollectionReference collReff = FirebaseFirestore.instance.collection('Artikel');
  return collReff.snapshots().map((QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) => Artikell.fromDocument(doc)).toList();
  });
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
