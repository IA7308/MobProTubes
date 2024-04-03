import 'package:flutter/material.dart';
import 'package:flutter_tubes/_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PROFILE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Profile(title: 'Edit Profile'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key, required this.title});

  final String title;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // Aksi saat tombol back ditekan
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      // Aksi saat tombol save ditekan
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage(''),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'No HP'),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Umur'),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Note'),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFC394E8),
          child: Column(
            children: [
              const UserAccountsDrawerHeader(
                accountName:
                    Text('Iqnaz Diningrat'), // Ganti dengan nama pengguna
                accountEmail:
                    Text('Diningratpride@email'), // Ganti dengan email pengguna
                currentAccountPicture: CircleAvatar(
                  radius: 60, // Atur radius lingkaran foto profil
                  backgroundImage: AssetImage(''),
                ),
              ),
              ListTile(
                title: const Text('NO HP'),
                onTap: () {
                  // Tambahkan aksi saat item dipilih
                },
              ),
              ListTile(
                title: const Text('Status'),
                onTap: () {
                  // Tambahkan aksi saat item dipilih
                },
              ),
              ListTile(
                title: const Text('Umur'),
                onTap: () {
                  // Tambahkan aksi saat item dipilih
                },
              ),
              ListTile(
                title: const Text('Note'),
                onTap: () {
                  // Tambahkan aksi saat item dipilih
                },
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(title: 'HealthSis'),));
                }, 
                child: Text('Home')
              )
            ],
          ),
        ),
      ),
    );
  }
}
