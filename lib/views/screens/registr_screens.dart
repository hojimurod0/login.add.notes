import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:full_app/services/registr_service.dart';
import 'package:full_app/views/screens/main_page.dart';

import '../widgets/bottom_icons.dart';
import 'login_screen.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  String? email, password, password2;
  bool isLoading = false;
  bool obscureTextChange = true;
  bool obscureTextChange2 = true;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (_passwordController.text != _password2Controller.text) {
      return "Passwords are not the same";
    }
    return null;
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      //? Register
      setState(() {
        isLoading = true;
      });
      try {
        await _authHttpServices.register(email!, password!);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return const HomePage();
            },
          ),
        );
      } catch (e) {
        String message = e.toString();
        if (e.toString().contains("EMAIL_EXISTS")) {
          message = "Email mavjud";
        }
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Xatolik"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _changeObscureText() {
    setState(() {
      obscureTextChange = !obscureTextChange;
    });
  }

  void _changeObscureText2() {
    setState(() {
      obscureTextChange2 = !obscureTextChange2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w800,
                        fontSize: 26),
                  ),
                  const Text(
                    "Create an account so you can explore all the existing jobs",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 65,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: _validateEmail,
                    onSaved: (value) => email = value,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0XFFF1F4FF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xff1F41BB),
                        ),
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: obscureTextChange,
                    onSaved: (value) => password = value,
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _changeObscureText,
                        icon: obscureTextChange
                            ? const Icon(CupertinoIcons.eye_slash)
                            : const Icon(CupertinoIcons.eye),
                      ),
                      filled: true,
                      fillColor: const Color(0XFFF1F4FF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.teal,
                        ),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _password2Controller,
                    onSaved: (value) => password2 = value,
                    obscureText: obscureTextChange2,
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0XFFF1F4FF),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Color(0xff1F41BB))),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade900,
                      ),
                      suffixIcon: IconButton(
                        onPressed: _changeObscureText2,
                        icon: obscureTextChange2
                            ? const Icon(CupertinoIcons.eye_slash)
                            : const Icon(CupertinoIcons.eye),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: submit,
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.teal,
                      ),
                      child: const Center(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: const Text(
                      "Already have an account",
                      style: TextStyle(
                          color: Color(0XFF494949),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const BottomIcons()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
