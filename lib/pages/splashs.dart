import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splashs extends StatefulWidget {
  const Splashs({super.key});

  @override
  State<Splashs> createState() => _SplashsState();
}

class _SplashsState extends State<Splashs> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode((SystemUiMode.immersive));
    Future.delayed(const Duration(milliseconds:600 ), (){
      Navigator.pushNamed(context, '/login');});
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                //Colors.white,
                Color.fromARGB(255, 0, 112, 72),
                Color.fromARGB(255, 0, 112, 72),
                //Colors.black
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              tileMode: TileMode.mirror,
              transform: GradientRotation(0.60428),
            ),
          ),
          child: Center(
            child: Container(
              height: 200-50,
              width: 200-50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  opacity: 0.8,
                  image: AssetImage('assets/download (2).png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}