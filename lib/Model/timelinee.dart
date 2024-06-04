import 'package:cloud_firestore/cloud_firestore.dart';

class Timelinee {
  final String id;
  final String nama;
  final String judul;
  final String isi;
  final String photo;
  final bool like;

  Timelinee({required this.id, required this.nama, required this.judul, required this.isi, required this.like, required this.photo});

  factory Timelinee.fromDocument(DocumentSnapshot doc) {
    return Timelinee(
      id: doc.id,
      nama: doc['name'],
      judul: doc['judul'],
      isi: doc['isi'],
      like: doc['like'],
      photo: doc['photo'],
    );
  }
}
