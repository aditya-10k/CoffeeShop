import 'dart:ui';

import 'package:coffee/pages/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {



  String? errorMessage='';
  final formKey = GlobalKey<FormState>();
  var mail = TextEditingController();
  var name = TextEditingController();
  var psk = TextEditingController();
  bool obscuretext = true;

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        mail : mail.text , psk: psk.text
      );
      Navigator.pushNamed(context, '/splash');
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
            body: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    height: 420,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10,),
                          Text(
                            'Signup',
                            style: GoogleFonts.robotoSlab(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            fontSize: 50
                            ),
                          ),
                           SizedBox(height: 10+10,),
                      
                          TextFormField(
                      controller: name,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16
                      ),
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.white38),
                        prefixIcon: Icon(
                            Icons.person_2_outlined,
                        color: Colors.white70,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 3, 77, 188),
                            width: 2
                          )
                        ),
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.white70,
                          ),
                          borderRadius:BorderRadius.circular(20),
                      
                        )
                      ),
                                        ),
                                        SizedBox(height:20-10 ,),
                      
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
                                      TextFormField(
                                        style: TextStyle(
                      color: Colors.white38,
                      fontSize: 16,
                                        ),
                                        controller: psk,
                                        obscureText: obscuretext,
                                        decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                            color: Colors.white70,
                      ),
                                         hintText:'Password' ,
                                         hintStyle: TextStyle(color: Colors.white38),
                      suffixIcon: IconButton(
                         onPressed: () { setState(() {
                           obscuretext = !obscuretext;
                         });
                            },
                       icon:  Icon(
                      
                           obscuretext ? Icons.remove_red_eye :Icons.visibility_off),
                      ),
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
                        )
                                        ),
                                        validator: (psk){
                                          if(psk!.length < 5)
                                          {return "Password should be more than 6 characters" ;}
                                          else
                                          return null ;
                                        },
                                      ),
                      
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                      Text(
                        'Already have an account  ,',
                        style: TextStyle(
                                fontSize: 20-5,
                                color: Colors.white70,
                      
                              ),
                      ),
                      TextButton(
                            onPressed: () { Navigator.pushNamed(context, '/login' );  },
                            child: Text(
                                'login',
                              style: TextStyle(
                                fontSize: 20-5,
                               
                                
                      
                                color: const Color.fromARGB(255, 141, 140, 221),
                              ),
                            ),
                      ),
                                        ],
                                      ),
                                      FilledButton(onPressed: () async {
                        String mail_ = mail.text;
                        String psk_ = psk.text;
                        print('name $mail_ - password $psk_');
                        if(formKey.currentState!.validate()){
                          ScaffoldMessenger.of(context).showSnackBar(snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 1) ),
        SnackBar(
          backgroundColor: Colors.transparent ,
          content: Text(
            textAlign: TextAlign.center,
            
            'Sign-up Successful!',
            style: TextStyle(
              color: Colors.white70
            ),)),
      );
                        await createUserWithEmailAndPassword();
                        
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
             backgroundColor: Colors.transparent,
            ), 
          
           ),
    );
  }
}