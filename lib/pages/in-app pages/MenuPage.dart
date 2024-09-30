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
          body: Stack(
            children: [
             Padding(
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
                ]
              )
             ),
                  if(value.totalCost !=0)
                  Positioned(
                    bottom: 0,
                    left: MediaQuery.of(context).size.width/2-100,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 0, 85, 55).withOpacity(0.9)
                        ),
                        child: Text(
                          'Total Cost: ₹${value.totalCost.toStringAsFixed(2)}',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )
                        ),
                      )
                    ),
                  )
                   
            
                ],
              ),
            ),
          )
        )

    ;
  }
}