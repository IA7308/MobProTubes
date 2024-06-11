import 'package:cloud_firestore/cloud_firestore.dart';

class Menudiett {
  final String namaMenu;
  final String kalori;
  final String deskripsi;
  final String id;
  final String photo;
  final String namaPembuat;
  final String jenisMakanan;

  Menudiett({required this.namaMenu, required this.kalori, required this.deskripsi, required this.id, required this.photo, required this.namaPembuat, required this.jenisMakanan});

  factory Menudiett.fromDocument(DocumentSnapshot doc) {
    return Menudiett(
      id: doc.id,
      namaMenu: doc['namaMenu'],
      kalori: doc['kalori'],
      deskripsi: doc['deskripsi'],
      photo: doc['photo'],
      namaPembuat: doc['namaPembuat'],
      jenisMakanan: doc['jenisMakanan'],
    );
  }
}
