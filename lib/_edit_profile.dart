import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EDIT PROFILE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EditProfile(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey untuk Form
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1945),
        lastDate: DateTime(2100));

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Assign GlobalKey ke Form
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
                      onPressed: () {
                        // Lakukan aksi save jika form valid
                        if (_formKey.currentState!.validate()) {
                          // Lakukan aksi save jika form valid
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Data berhasil disimpan')),
                          );
                        }
                      },
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
                                  // Tambahkan logika untuk memilih gambar dari folder di sini
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text('Ambil Gambar'),
                                onTap: () {
                                  Navigator.pop(context);
                                  // Tambahkan logika untuk mengambil gambar dari kamera di sini
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
                                  // Tambahkan logika untuk menghapus gambar di sini
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('images/Default.jpg'),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'No HP'),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ], // Hanya menerima input angka
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'No HP tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Status'),
                  validator: (value) {
                    // Validasi Status
                    if (value == null || value.isEmpty) {
                      return 'Status tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Umur',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate();
                  },
                  validator: (value) {
                    // Validasi Umur
                    if (value == null || value.isEmpty) {
                      return 'Umur tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Note'),
                  validator: (value) {
                    // Validasi Note
                    if (value == null || value.isEmpty) {
                      return 'Note tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
