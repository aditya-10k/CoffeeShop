import 'package:coffee/workingcomps/forlinks.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';


class Getintouch extends StatefulWidget {
  const Getintouch({super.key});

  @override
  State<Getintouch> createState() => _GetintouchState();
}

class _GetintouchState extends State<Getintouch> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),


      child: Column(
        children: [
          
           SizedBox(height: 30,),

          Text('Get in touch!',
          style: GoogleFonts.robotoSlab(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),),

          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i = 0; i< Socials.length ; i++)
              InkWell(
                onTap: () { },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                          
                  child : Socials[i]["icon"]
                ),
              ),
              

              InkWell(
                onTap: () {         

        
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                          
                  child : Icon(Icons.mail_outline,
                  color: Colors.black,)
                ),
              )
              
            ],
          ),
           SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text('Created with ❣️ using ',
          style:GoogleFonts.robotoSlab(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),),
            Icon(BoxIcons.bxl_flutter,
            size: 17,
            color: Colors.grey[800],)
            ],
          )
        ],
      ),
    );
  }
}