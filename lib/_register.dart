import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tubes/_login.dart';
import 'package:flutter_tubes/firebase_auth_services.dart';
import 'package:flutter_tubes/main.dart';

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
      home: const Register(title: 'HealthSis'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Register extends StatefulWidget {
  const Register({super.key, required this.title});

  final String title;

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  String? firstnameError;
  String? lastnameError;
  String? usernameError;
  String? emailError;
  String? passwordError;
  String? rePasswordError;
  bool passwordVisible = false;
  bool rePasswordVisible = false;

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 169, 154),
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
                    horizontal: 30.0, vertical: 20.0),
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
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: firstnameController,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'First Name',
                              errorText: firstnameError),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: lastnameController,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Last Name',
                              errorText: lastnameError),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Username',
                        errorText: usernameError),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Email',
                          errorText: emailError),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
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
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: TextField(
                      controller: rePasswordController,
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Re-Password',
                        errorText: rePasswordError,
                        suffixIcon: IconButton(
                          icon: Icon(
                            rePasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              rePasswordVisible = !rePasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    child: const Text('Daftar'),
                  ),
                  ListTile(
                    title: const Center(
                      child: Text(
                        'Sudah Mempunyai Akun',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const Login(title: 'HealthSis');
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String firstname = firstnameController.text;
    String lastname = lastnameController.text;
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    setState(() {
      firstnameError = firstnameController.text.isEmpty
          ? "First name tidak boleh kosong"
          : null;
      lastnameError = lastnameController.text.isEmpty
          ? "Last name tidak boleh kosong"
          : null;
      usernameError = usernameController.text.isEmpty
          ? "Username tidak boleh kosong"
          : null;
      emailError =
          emailController.text.isEmpty ? "Email tidak boleh kosong" : null;
      passwordError = passwordController.text.isEmpty
          ? "Password tidak boleh kosong"
          : null;
      rePasswordError = rePasswordController.text.isEmpty
          ? "Re-password tidak boleh kosong"
          : null;
    });

    if (passwordController.text != rePasswordController.text) {
      setState(() {
        rePasswordError = "Password dan Re-password tidak sama";
      });
      return;
    }

    if (firstnameError == null &&
        lastnameError == null &&
        usernameError == null &&
        emailError == null &&
        passwordError == null &&
        rePasswordError == null) {
      User? user = await _auth.signUp(email, password);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil disimpan')),
        );

        print("User berhasil dibuat");

        insertUser(user.uid, firstname, lastname, username, email);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return const Login(title: 'HealthSis');
          }),
        );
      } else {
        print("Gagal");
      }
    }
  }
}
