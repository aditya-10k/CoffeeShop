import 'package:coffee/workingcomps/coffeelist.dart';
import 'package:coffee/workingcomps/coffetile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../workingcomps/cartfunc.dart';

class cartpage extends StatefulWidget {
  const cartpage({super.key});

  @override
  State<cartpage> createState() => _cartpageState();
}

class _cartpageState extends State<cartpage> {

void removeitem(Coffeelist coffee)
  {
    Provider.of<Cartfunc>(context,listen: false).removeitem(coffee);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cartfunc>(
      builder : (context,value , child) => SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Text('Your Cart',
            style: GoogleFonts.robotoSlab(
              color:Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 40 
            ),),
      
            Expanded(child: ListView.builder(
              itemCount: value.usercart.length,
              itemBuilder: (context,index){
              Coffeelist eachitem = value.usercart[index];

              return Coffetile(coffee: eachitem, onPressed:() => removeitem(eachitem), icon: Icon(Icons.delete));
            })),

            Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Total Cost: ₹${value.totalCost.toStringAsFixed(2)}', // Formats the total cost to 2 decimal places
                    style: GoogleFonts.robotoSlab(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:  Colors.black,
                    )
                  )
                ),
                SizedBox(height: 10,)
          ],
          
        ),
      ),
      )
    );
  }
}