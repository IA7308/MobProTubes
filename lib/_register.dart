import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REGISTER',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void pressButtonLogin() {
    print('Saya di Klik Login');
  }

  void pressButtonDaftar() {
    print('Saya di Klik Daftar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(widget.title),
        ),
        body: Padding(
            padding: const EdgeInsets.all(0),
            child: Center(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 75.0),
                    children: <Widget>[
                      const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 50.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times New Roman'),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'First Name'),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Last Name'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username'),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Email'),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password'),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                          onPressed: pressButtonDaftar,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white),
                          child: const Text('Daftar')),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Center(
                        child: Text(
                          'Sudah Mempunyai Akun',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
