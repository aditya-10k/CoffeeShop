import 'package:coffee/workingcomps/cartfunc.dart';
import 'package:coffee/workingcomps/coffeelist.dart';
import 'package:coffee/workingcomps/coffetile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class Menupage extends StatefulWidget {
  const Menupage({super.key});

  @override
  State<Menupage> createState() => _MenupageState();
}

class _MenupageState extends State<Menupage> {

  void additem(Coffeelist coffee)
  {
    Provider.of<Cartfunc>(context,listen: false).additem(coffee);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Cartfunc>(
      builder : (context,value , child) => SafeArea(
        child: Scaffold(
          backgroundColor:Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: Text("Bold Brews & Sweet Treats",
                  style: GoogleFonts.robotoSlab(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  
                  ),),
                ),
                SizedBox(height: 10,),

                Expanded(
                  child: ListView.builder(
                    itemCount: value.items.length,
                    itemBuilder: (context , index)
                    {
                    var eachitem = value.items[index];

                    return Coffetile(
                      coffee: eachitem,
                      icon: Icon(Icons.add),
                      onPressed:() => additem(eachitem),);
                  })
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Total Cost: ₹${value.totalCost.toStringAsFixed(2)}', // Formats the total cost to 2 decimal places
                    style: GoogleFonts.robotoSlab(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                  )
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}