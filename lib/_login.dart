import 'package:flutter/material.dart';
import 'package:flutter_tubes/_dashboard.dart';
import 'package:flutter_tubes/_register.dart';
import 'package:flutter_tubes/main.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOGIN',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Login(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 169, 154),
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
                        horizontal: 30.0, vertical: 200.0),
                    children: <Widget>[
                      const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 50.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times New Roman'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Email'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                     Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                          return const Dashboard(
                                              title: 'HealthSis');
                                        }),
                                      );
                                    // Memanggil LoginHandler.login untuk memeriksa kredensial pengguna
                                    // bool success = await login(
                                    //     emailController.text,
                                    //     passwordController.text);

                                    // if (success) {
                                    //   // Jika autentikasi berhasil, pindah ke halaman dashboard
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (BuildContext context) {
                                    //       return const Dashboard(
                                    //           title: 'HealthSis');
                                    //     }),
                                    //   );
                                    // } else {
                                    //   // Jika autentikasi gagal, tampilkan pesan kesalahan
                                    //   showDialog(
                                    //     context: context,
                                    //     builder: (context) => AlertDialog(
                                    //       title: Text('Login Failed'),
                                    //       content: Text(
                                    //           'Invalid email or password. Please try again.'),
                                    //       actions: [
                                    //         TextButton(
                                    //           onPressed: () {
                                    //             Navigator.pop(context);
                                    //           },
                                    //           child: Text('OK'),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   );
                                    // }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Login'),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return const Register(
                                            title: 'HealthSis');
                                      }),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white),
                                  child: const Text('Daftar')),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
