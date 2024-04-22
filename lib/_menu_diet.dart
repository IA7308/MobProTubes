import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
          backgroundColor: Color.fromARGB(255, 255, 169, 154),
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
        drawer: const Sidebar(),
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
                      viewportFraction: 0.8,
                    ),
                    items: [
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        color: Color.fromARGB(255, 255, 169, 154),
                        child: const Center(
                          child: Text(
                            'Slide 1',
                            style:
                                TextStyle(fontSize: 24.0, color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            'Slide 2',
                            style:
                                TextStyle(fontSize: 24.0, color: Colors.white),
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
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/Food_1.jpg'),
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
                                'JUDUL',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman'),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Sub Judul',
                                style: TextStyle(
                                    fontSize: 11, fontStyle: FontStyle.italic),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: ElevatedButton(
                                  onPressed: () {}, child: const Text('More')),
                            )
                          ],
                        ),
                        )
                      ),
                    ),
                    Card(
                        color: Color.fromARGB(255, 255, 169, 154),
                        child: ListView(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              child: Center(
                                child: Icon(Icons.food_bank_outlined),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Center(
                              child: Text(
                                'JUDUL',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman'),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Sub Judul',
                                style: TextStyle(
                                    fontSize: 11, fontStyle: FontStyle.italic),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: ElevatedButton(
                                  onPressed: () {}, child: const Text('More')),
                            )
                          ],
                        )),
                    Card(
                        color: Colors.green,
                        child: ListView(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              child: Center(
                                child: Icon(Icons.food_bank_rounded),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Center(
                              child: Text(
                                'JUDUL',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman'),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Sub Judul',
                                style: TextStyle(
                                    fontSize: 11, fontStyle: FontStyle.italic),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: ElevatedButton(
                                  onPressed: () {}, child: const Text('More')),
                            )
                          ],
                        )),
                    Card(
                        color: Colors.yellow,
                        child: ListView(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              child: Center(
                                child: Icon(Icons.food_bank_sharp),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Center(
                              child: Text(
                                'JUDUL',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman'),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Sub Judul',
                                style: TextStyle(
                                    fontSize: 11, fontStyle: FontStyle.italic),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: ElevatedButton(
                                  onPressed: () {}, child: const Text('More')),
                            )
                          ],
                        )),
                  ]),
                ),
              ],
            )));
  }
}
