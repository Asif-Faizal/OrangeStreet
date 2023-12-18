import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/homepage.dart';
import 'package:shop/signup.dart';
import 'package:shop/widgets/button.dart';
import 'package:shop/widgets/textfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void _login() async {
    final auth = FirebaseAuth.instance;

    try {
      await auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      User? user = auth.currentUser;
      if (user != null) {
        showSnackBar('Logged in', Colors.green);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        showSnackBar('User does not exist. Please sign up first.', Colors.red);
      }
    } catch (e) {
      showSnackBar('Login failed. Please check your credentials.', Colors.red);
      print(e.toString());
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_email', _emailController.text);
  }

  void showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        content: Text(message),
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Simple email validation
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    // Minimum password length validation
    return password.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              prefixIcon: Icons.mail,
              hintText: "Email",
              controller: _emailController,
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
              prefixIcon: Icons.lock_person,
              hintText: "Password",
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Button(
                onPressed: _login,
                child: Row(
                  children: [
                    Spacer(),
                    Text('Login'),
                    Spacer(),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not an User?  ',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: Text('Signup',
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
