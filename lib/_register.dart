import 'package:flutter/material.dart';
import 'package:flutter_tubes/_login.dart';
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

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void handleRegister() {
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
      insertHealthsis(
          firstnameController.text,
          lastnameController.text,
          usernameController.text,
          emailController.text,
          passwordController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil disimpan')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return const Login(title: 'HealthSis');
        }),
      );
    }
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
                              border: OutlineInputBorder(),
                              labelText: 'First Name',
                              errorText: firstnameError),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: lastnameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
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
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        errorText: usernameError),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          errorText: emailError),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          errorText: passwordError),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: TextField(
                      controller: rePasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Re-Password',
                          errorText: rePasswordError),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      handleRegister();
                    },
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
}
