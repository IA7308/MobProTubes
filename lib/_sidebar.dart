import 'package:flutter/material.dart';
import 'package:flutter_tubes/_artikel.dart';
import 'package:flutter_tubes/_dashboard.dart';
import 'package:flutter_tubes/_menu_diet.dart';
import 'package:flutter_tubes/_page_awal.dart';
import 'package:flutter_tubes/_profile.dart';
import 'package:flutter_tubes/_timeline.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Iqnaz Diningrat', style: TextStyle(color: Colors.black)),
              accountEmail: Text('Diningratpride@email', style: TextStyle(color: Colors.black)),
              currentAccountPicture: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(''),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 169, 154),
              ),
            ),
            ListTile(
              title: const Text('Dashboard'),
              splashColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Dashboard(title: 'HealthSis');
                  }),
                );
              },
            ),
            ListTile(
              title: const Text('Profile'),
              splashColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Profile(title: 'HealthSis');
                  }),
                );
              },
            ),
            ListTile(
              title: const Text('Menu Diet'),
              splashColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const MenuDiet(title: 'HealthSis');
                  }),
                );
              },
            ),
            ListTile(
              title: const Text('Artikel'),
              splashColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Artikel(title: 'HealthSis');
                  }),
                );
              },
            ),
            ListTile(
              title: const Text('Timeline'),
              splashColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Timeline(title: 'HealthSis');
                  }),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              splashColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: const Text('konfirmasi Logout'),
                      content: const Text('Apakah anda yakin ingin logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                          child: const Text('Tidak'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return PageAwal();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Ya',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
