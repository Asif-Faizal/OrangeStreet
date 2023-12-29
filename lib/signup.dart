import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/homepage.dart';
import 'package:shop/introscreen.dart';
import 'package:shop/login.dart';
import 'package:shop/models/user.dart';
import 'package:shop/widgets/button.dart';
import 'package:shop/widgets/textfield.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  User? _user;
  bool _agreeToTerms = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  Future<void> _signup() async {
    final auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: _emailController.text, password: _confirmpassController.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', _usernameController.text);
    prefs.setString('user_email', _emailController.text);
    prefs.setString('user_pass', _passwordController.text);
    final DatabaseReference database = FirebaseDatabase.instance
        .refFromURL('https://orange-street-default-rtdb.firebaseio.com/');
    final model = Users(
      name: _usernameController.text,
      email: _emailController.text,
      passWord: _passwordController.text,
    );
    database.child("Users").push().set(model.toJson());
    if (_agreeToTerms) {
      String username = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmpassController.text.trim();
      if (!_isValidEmail(username)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text('Please enter a valid email address.'),
          ),
        );
        return;
      }

      if (!_isValidPassword(password)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text('Password must be at least 6 characters.'),
          ),
        );
        return;
      }

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text('Password and Confirm Password must match.'),
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Text('Signed in Successfully'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IntroScreen()),
      );
    } else {
      // Show error message if terms are not agreed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text('Please agree to the terms and conditions.'),
        ),
      );
    }
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
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmpassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_user != null) {
      return HomePage();
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                prefixIcon: Icons.account_box,
                hintText: "User Name",
                controller: _usernameController,
              ),
              SizedBox(
                height: 25,
              ),
              CustomTextField(
                prefixIcon: Icons.mail,
                hintText: "Email",
                controller: _emailController,
              ),
              SizedBox(
                height: 25,
              ),
              CustomTextField(
                prefixIcon: Icons.lock_person,
                hintText: "Password",
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(
                height: 25,
              ),
              CustomTextField(
                prefixIcon: Icons.lock_person,
                hintText: "Confirm Password",
                controller: _confirmpassController,
                obscureText: true,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    shape: CircleBorder(),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.transparent;
                        }
                        return Colors.transparent;
                      },
                    ),
                    checkColor: Colors.deepOrange,
                    focusColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.transparent;
                        }
                        return Colors.transparent;
                      },
                    ),
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                      });
                    },
                  ),
                  Row(
                    children: [
                      const Text(
                        'I agree to the  ',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                        },
                        child: const Text(
                          'Terms and Conditions',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.deepOrange,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Button(
                  onPressed: _signup,
                  child: Row(
                    children: [Spacer(), Text('Signup'), Spacer()],
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a User?  ',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 14,
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

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'Terms and Conditions',
        style: TextStyle(fontSize: 16),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "What terms? no terms here",
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
      ],
    );
  }
}
