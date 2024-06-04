import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tubes/_profile.dart';
import 'package:flutter_tubes/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.title});

  final String title;

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  late String uid;
  late Future<DocumentSnapshot<Map<String, dynamic>>> userDataFuture;
  String? usernameError;
  String? phoneError;
  String? statusError;
  String? noteError;
  String? dateError;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      userDataFuture = getUserData(uid);
      userDataFuture.then((snapshot) {
        if (snapshot.data() != null) {
          Map<String, dynamic> userData = snapshot.data()!;
          _usernameController.text = userData['username'] ?? '';
          _phoneController.text = userData['phone'] ?? '';
          _statusController.text = userData['status'] ?? '';
          _noteController.text = userData['note'] ?? '';
          _dateController.text = userData['birthday'] ?? '';
        }
      });
    }
  }

  void _saveData() async {
    String username = _usernameController.text;
    String phone = _phoneController.text;
    String status = _statusController.text;
    String note = _noteController.text;
    DateTime? date = parseDate(_dateController.text);

    setState(() {
      usernameError = username.isEmpty ? "Username tidak boleh kosong" : null;
      phoneError = phone.isEmpty ? "No HP tidak boleh kosong" : null;
      statusError = status.isEmpty ? "Status tidak boleh kosong" : null;
      noteError = note.isEmpty ? "Note tidak boleh kosong" : null;
      dateError = date == null ? "Tanggal tidak boleh kosong" : null;
    });

    if (usernameError == null &&
        phoneError == null &&
        statusError == null &&
        noteError == null &&
        dateError == null) {
      String? imageUrl;
      if (_imageFile != null) {
        imageUrl = await uploadsImage(_imageFile!);
      } else {
        DocumentSnapshot<Map<String, dynamic>> userDataSnapshot =
            await userDataFuture;
        Map<String, dynamic>? userData = userDataSnapshot.data();
        if (userData != null) {
          imageUrl = userData['photo'];
        }
      }

      updateUserData(uid, username, phone, status, date!, note, imageUrl ?? '');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil disimpan')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return const Profile(title: 'HealthSis');
        }),
      );
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

  DateTime? parseDate(String dateString) {
    try {
      return DateFormat('dd MMMM yyyy').parse(dateString);
    } catch (e) {
      print('Error parsing date: $e');
      return null;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.hasData && snapshot.data != null) {
                Map<String, dynamic> userData = snapshot.data!.data()!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Spacer(),
                          const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.save),
                            onPressed: _saveData,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(Icons.folder),
                                        title: const Text('Pilih dari Folder'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _pickImage(ImageSource.gallery);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.camera_alt),
                                        title: const Text('Ambil Gambar'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _pickImage(ImageSource.camera);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        title: const Text(
                                          'Hapus Gambar',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          DeletePhotos(uid);
                                          
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: _imageFile != null
                                  ? FileImage(_imageFile!)
                                  : userData['photo'] != null
                                      ? NetworkImage(userData['photo'])
                                      : const NetworkImage(
                                              'https://firebasestorage.googleapis.com/v0/b/mobprotubes-1a30b.appspot.com/o/Default.jpg?alt=media&token=766800c7-998d-48a9-84de-58f07b65d9b8')
                                          as ImageProvider<Object>?,
                            ),
                          )),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          errorText: usernameError,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'No HP',
                          errorText: phoneError,
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: _statusController,
                        decoration: InputDecoration(
                          labelText: 'Status',
                          errorText: statusError,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Lahir',
                          errorText: dateError,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () {
                              _selectDate();
                            },
                          ),
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          labelText: 'Catatan',
                          errorText: noteError,
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }
          },
        ),
      ),
    );
  }
}
