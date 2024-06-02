import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes/_dashboard.dart';
import 'package:flutter_tubes/_register.dart';
import 'package:flutter_tubes/firebase_auth_services.dart';

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
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  bool passwordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            errorText: emailError,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextField(
                          controller: passwordController,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            errorText: passwordError,
                            suffixIcon: IconButton(
                              icon: Icon(
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                          ),
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
                                    onPressed: _signIn,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white),
                                    child: const Text('Login')),
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

  void _signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    setState(() {
      emailError = email.isEmpty ? "Email tidak boleh kosong" : null;
      passwordError = password.isEmpty ? "Password tidak boleh kosong" : null;
    });

    if (emailError == null && passwordError == null) {
      User? user = await _auth.Login(email, password);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil masuk')),
        );

        print("Berhasil");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return const Dashboard(title: 'HealthSis');
          }),
        );
      }
    }
  }
}
