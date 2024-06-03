import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_tubes/_menu_diet_data.dart';
import 'package:flutter_tubes/_sidebar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MENU DIET',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MenuDiet(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuDiet extends StatefulWidget {
  const MenuDiet({super.key, required this.title});

  final String title;

  @override
  State<MenuDiet> createState() => _MenuDiet();
}

class _MenuDiet extends State<MenuDiet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 169, 154),
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                // Handle your filter action here
              },
            ),
          ],
        ),
        drawer: const Sidebar(selectedIndex: 2,),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  const ListTile(
                    title: Text(
                      'Menu Diet',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 0.10,
                    ),
                    items: [
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        color: const Color.fromARGB(255, 255, 169, 154),
                        child: Center(
                          child: Image.asset( 
                            'images/Food_7.jpg', // Ganti dengan path gambar yang sesuai
                            width: 200, // Sesuaikan lebar gambar sesuai kebutuhan
                            height: 200, // Sesuaikan tinggi gambar sesuai kebutuhan
                            fit: BoxFit.cover, // Sesuaikan fit gambar sesuai kebutuhan
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.all(5.0),
                        color: const Color.fromARGB(255, 255, 169, 154),
                        child: Center(
                          child: Image.asset( 
                            'images/Food_6.jpg', // Ganti dengan path gambar yang sesuai
                            width: 200, // Sesuaikan lebar gambar sesuai kebutuhan
                            height: 200, // Sesuaikan tinggi gambar sesuai kebutuhan
                            fit: BoxFit.cover, // Sesuaikan fit gambar sesuai kebutuhan
                          ),
                        ),
                      ),

                       Container(
                        margin: const EdgeInsets.all(5.0),
                        color: const Color.fromARGB(255, 255, 169, 154),
                        child: Center(
                          child: Image.asset( 
                            'images/Food_5.jpg', // Ganti dengan path gambar yang sesuai
                            width: 200, // Sesuaikan lebar gambar sesuai kebutuhan
                            height: 200, // Sesuaikan tinggi gambar sesuai kebutuhan
                            fit: BoxFit.cover, // Sesuaikan fit gambar sesuai kebutuhan
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ])),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 10.0,
                  ),
                  delegate: SliverChildListDelegate([
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/Food_5.jpg'),
                          fit: BoxFit.cover,
                        )
                      ),
                      child: Card(
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ListView(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              child: Center(
                                child: Icon(Icons.food_bank),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Center(
                              child: Text(
                                'Special Healthy Rice',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman'),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Chef Codeblu',
                                style: TextStyle(
                                    fontSize: 11, fontStyle: FontStyle.italic),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IsiDataMenu(
                                judul: 'Special Healthy Rice',
                                subJudul: '',
                                penjelasan: 'Makanan diet yang terdiri dari salmon, sayuran, dan telur adalah pilihan yang baik untuk menjaga kesehatan dan membantu dalam proses penurunan berat badan',
                                chef: 'Chef Arnold',
                                kalori: 375,
                              ),
                            ));
                                  }, child: const Text('More')),
                            )
                          ],
                        ),
                        )
                      ),
                    ),

                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/Food_6.jpg'),
                          fit: BoxFit.cover,
                        )
                      ),
                      child: Card(
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ListView(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              child: Center(
                                child: Icon(Icons.food_bank),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Center(
                              child: Text(
                                'Healthy Vegetables Tuna',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman'),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Chef Codeblu',
                                style: TextStyle(
                                    fontSize: 11, fontStyle: FontStyle.italic),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IsiDataMenu(
                                judul: 'Healthy Vegetables Tuna',
                                subJudul: '',
                                penjelasan: 'Makanan diet yang terdiri dari salmon, sayuran, dan telur adalah pilihan yang baik untuk menjaga kesehatan dan membantu dalam proses penurunan berat badan',
                                chef: 'Chef Arnold',
                                kalori: 350,
                              ),
                            ));
                                  }, child: const Text('More')),
                            )
                          ],
                        ),
                        )
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/Food_7.jpg'),
                          fit: BoxFit.cover,
                        )
                      ),
                      child: Card(
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ListView(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              child: Center(
                                child: Icon(Icons.food_bank),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Center(
                              child: Text(
                                'Vegetables With Chicken Roast',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman'),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Chef Codeblu',
                                style: TextStyle(
                                    fontSize: 11, fontStyle: FontStyle.italic),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IsiDataMenu(
                                judul: 'Vegetables With Chicken Roast ',
                                subJudul: '',
                                penjelasan: 'Makanan diet yang terdiri dari salmon, sayuran, dan telur adalah pilihan yang baik untuk menjaga kesehatan dan membantu dalam proses penurunan berat badan',
                                chef: 'Chef Arnold',
                                kalori: 375,
                              ),
                            ));
                                  }, child: const Text('More')),
                            )
                          ],
                        ),
                        )
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/Food_9.jpg'),
                          fit: BoxFit.cover,
                        )
                      ),
                      child: Card(
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ListView(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              child: Center(
                                child: Icon(Icons.food_bank),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Center(
                              child: Text(
                                'Sweety Salmon',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman'),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Chef Codeblu',
                                style: TextStyle(
                                    fontSize: 11, fontStyle: FontStyle.italic),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IsiDataMenu(
                                judul: 'Sweety Salmon',
                                subJudul: '',
                                penjelasan: 'Makanan diet yang terdiri dari salmon, sayuran, dan telur adalah pilihan yang baik untuk menjaga kesehatan dan membantu dalam proses penurunan berat badan',
                                chef: 'Chef Arnold',
                                kalori: 400,
                              ),
                            ));
                                  }, child: const Text('More')),
                            )
                          ],
                        ),
                        )
                      ),
                    ),
                  ]),
                ),
              ],
            )));
  }
}
