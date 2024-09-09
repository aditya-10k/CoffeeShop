import 'package:coffee/workingcomps/coffeelist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Coffetile extends StatelessWidget {
  final Coffeelist coffee;
  final Widget icon ;
  void Function()? onPressed;
   Coffetile({super.key, required this.coffee, required this.onPressed,required this.icon});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 63, 45, 45),
        borderRadius: BorderRadius.circular(10)
      ),
      margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
      padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
      child: ListTile(
        title: Text(coffee.name,
        style: GoogleFonts.robotoSlab(
          color: Colors.white70,
          fontWeight: FontWeight.bold
        ),
        ),
        subtitle: Text('₹${coffee.price}',
        style: GoogleFonts.robotoSlab(
          color: Colors.white70,
          fontWeight: FontWeight.bold
        ),
        ),
        leading: Image.asset(coffee.imgadd , height: 100,),
        trailing: IconButton.outlined(onPressed: onPressed, icon: icon,
        color: Color.fromARGB(255, 208, 184, 168),
        highlightColor: Colors.lightGreenAccent[400],),
      ),
    );
  }
}