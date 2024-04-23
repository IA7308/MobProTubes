import 'package:flutter/material.dart';
import 'package:flutter_tubes/_artikel.dart';
import 'package:flutter_tubes/_dashboard.dart';
import 'package:flutter_tubes/_menu_diet.dart';
import 'package:flutter_tubes/_page_awal.dart';
import 'package:flutter_tubes/_profile.dart';
import 'package:flutter_tubes/_timeline.dart';


class Sidebar extends StatefulWidget {
  final int selectedIndex;
  const Sidebar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  
  List<String> pageTitles = [
      'Dashboard',
      'Artikel',
      'Menu Diet',
      'Profile',
      'Timeline',
    ];
    
    List<Widget> pages = [
      const Dashboard(title: 'HealthSis'),
      const Artikel(title: 'HealthSis'),
      const MenuDiet(title: 'HealthSis'),
      const Profile(title: 'HealthSis'),
      const Timeline(title: 'HealthSis'),
    ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
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
            ListView.builder(
            shrinkWrap: true,
            itemCount: pageTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(pageTitles[index]),
                splashColor: Colors.red,
                selected: widget.selectedIndex == index,
                selectedColor: Colors.purple,
                selectedTileColor: Color.fromARGB(255, 255, 169, 154),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return pages[index];
                    }),
                  );
                },
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
