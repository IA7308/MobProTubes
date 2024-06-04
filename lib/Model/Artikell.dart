import 'package:cloud_firestore/cloud_firestore.dart';

class Artikell {
  final String id;
  final String nama;
  final String judul;
  final String isi;
  final String photo;

  Artikell({required this.id, required this.nama, required this.judul, required this.isi, required this.photo});

  factory Artikell.fromDocument(DocumentSnapshot doc) {
    return Artikell(
      id: doc.id,
      nama: doc['name'],
      judul: doc['judul'],
      isi: doc['isi'],
      photo: doc['photo'],
    );
  }
}
