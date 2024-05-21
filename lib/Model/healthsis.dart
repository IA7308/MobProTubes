import 'package:cloud_firestore/cloud_firestore.dart';

class HealthSis{
  final String id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String password;
  final String phone;
  final String status;
  final String age;
  final String birthday;
  final String note;
  final String photo;


  HealthSis({required this.id, required this.firstname, required this.lastname, required this.username, required this.email, required this.password, required this.status, 
  required this.phone, required this.age, required this.birthday, required this.note, required this.photo});

  factory HealthSis.fromDocument(DocumentSnapshot doc) {
    return HealthSis(
      id: doc.id,
      firstname: doc['firstname'],
      lastname: doc['lastname'],
      username: doc['username'],
      email: doc['email'],
      password: doc['password'],
      phone: doc['phone'],
      status: doc['status'],
      age: doc['age'],
      birthday: doc['birthday'],
      note: doc['note'],
      photo: doc['photo']
    );
  }
}