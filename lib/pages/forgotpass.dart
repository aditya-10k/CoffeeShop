import 'dart:ui';

import 'package:coffee/pages/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {

   String? errorMessage='';
  final formKey = GlobalKey<FormState>();
  var mail = TextEditingController();

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await Auth().sendPasswordResetEmail(
        mail : mail.text
      );
      Navigator.pushNamed(context, '/login');
    } on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/Designer (2).jpeg"),
              fit: BoxFit.fitHeight
              ),   
            ),

            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
              ),
            body: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    height: 250,
                    width: 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1,color: Colors.black38),
                    color: Colors.black38.withOpacity(0.6),
                    ),

                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10,),
                          Text(
                            'Forgot Password',
                            style: GoogleFonts.robotoSlab(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            fontSize: 50
                            ),
                          ),
                           SizedBox(height: 10+10,),
                      
                           
                      
                           TextFormField(
                                        style: TextStyle(
                        color: Colors.white70,
                      fontSize: 16
                                        ),
                                        controller: mail,
                                        decoration: InputDecoration(
                      prefixIcon: Icon(
                          Icons.mail,
                        color: Colors.white70,
                      ),
                        hintText:'Email' ,
                        hintStyle: TextStyle(color: Colors.white38),
                      //focusColor: Colors.cyan,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 2,
                          color: const Color.fromARGB(255, 3, 77, 188),
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.white70,
                        )
                      ),
                                        ),
                                        validator: (mail){
                      if(mail!.isEmpty ||!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(mail)){
                        return'Enter valid E-mail';}
                        else
                          return null;
                      }
                                      ),
                                      SizedBox(height: 10,),
FilledButton(onPressed: () async {
                        
                        if(formKey.currentState!.validate()){
                          ScaffoldMessenger.of(context).showSnackBar(snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 1) ),
        SnackBar(
          backgroundColor: Colors.transparent ,
          content: Text(
            textAlign: TextAlign.center,
            
            'Password change link send to email successfully!',
            style: TextStyle(
              color: Colors.white70
            ),)),
      );
                        await sendPasswordResetEmail(mail.text);
                        
                        }
                        },
                      
                        child: Text(
                          'Sign-up',
                          style: TextStyle(
                          color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.brown[900]),
                        ),
                      ),

                                      ]
                                      )
                    )
                  )
                )
              )
            ),
            backgroundColor: Colors.transparent,
            )
            
          )
          
    );
  }
}