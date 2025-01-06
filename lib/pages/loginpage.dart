import 'dart:ui';

import 'package:coffee/pages/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = ''; // Error message to display
  final formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final pskController = TextEditingController();
  bool obscureText = true;

  // Firebase sign-in method
Future<void> signInWithEmailAndPassword() async {
  try {
    print('Attempting to sign in...');
    
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: mailController.text.trim(),
      password: pskController.text.trim(),
    );

    // Check if FirebaseAuth.instance.currentUser is set
    final currentUser = FirebaseAuth.instance.currentUser;
    print('currentUser UID: ${currentUser?.uid}');  // Log the UID immediately

    if (currentUser != null) {
      print('Logged in successfully with UID: ${currentUser.uid}');
      Navigator.pushNamed(context, '/homepage');
    } else {
      print('User authentication failed.');
      setState(() {
        errorMessage = 'Failed to authenticate user.';
      });
    }
  } on FirebaseAuthException catch (e) {
    setState(() {
      errorMessage = e.message;
    });
    print('FirebaseAuthException: ${e.message}');
  } catch (e) {
    print('Unexpected error: $e');
  }
}


// Helper function to clear cached user data
void clearUserData() {
  // Add logic to clear locally cached user information (if any)
  // For example, using SharedPreferences:
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.clear();
}



  @override
  void dispose() {
    mailController.dispose();
    pskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Designer (6).jpeg"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Scaffold(
          body: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 410,
                  width: 340,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.black38),
                    color: Colors.black38.withOpacity(0.6),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Login',
                          style: GoogleFonts.robotoSlab(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            fontSize: 50,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                          controller: mailController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.mail,
                              color: Colors.white70,
                            ),
                            hintText: 'Email',
                            hintStyle: GoogleFonts.robotoSlab(color: Colors.white38),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 3, 77, 188),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          validator: (mail) {
                            if (mail == null || mail.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(mail)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                          controller: pskController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.white70,
                            ),
                            hintText: 'Password',
                            hintStyle: GoogleFonts.robotoSlab(color: Colors.white38),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                obscureText ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 3, 77, 188),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          validator: (psk) {
                            if (psk == null || psk.length < 6) {
                              return "Password must be at least 6 characters long";
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/forgotpass');
                            },
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.robotoSlab(
                                fontSize: 10,
                                color: const Color.fromARGB(255, 141, 140, 221),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.robotoSlab(
                                fontSize: 15,
                                color: Colors.white70,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                ' Sign Up',
                                style: GoogleFonts.robotoSlab(
                                  fontSize: 15,
                                  color: const Color.fromARGB(255, 141, 140, 221),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        FilledButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await signInWithEmailAndPassword();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 0, 112, 72),
                            ),
                          ),
                          child: Text(
                            'Log In',
                            style: GoogleFonts.robotoSlab(
                              color: Colors.white70,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          errorMessage ?? '',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoSlab(
                            color: Colors.redAccent,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/homepage');
            },
          ),
        ),
      ),
    );
  }
}
