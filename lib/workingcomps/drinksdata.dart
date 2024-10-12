import 'dart:convert';

import 'package:coffee/workingcomps/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Drinksdata extends StatefulWidget {
   Drinksdata({super.key});

  @override
  State<Drinksdata> createState() => _DrinksdataState();
}

class _DrinksdataState extends State<Drinksdata> {
  List<BeverageModel> drinklist=[]; 

  Future<List<BeverageModel>> getdrinkapi () async {

    final response = await http.get(Uri.parse('https://api.sampleapis.com/coffee/hot'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200)
    {
      drinklist.clear();
      for(Map i in data)
      {
        drinklist.add(BeverageModel.fromJson(i));
      }
      return drinklist;
    }
    else{
      return drinklist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 450,
          child: FutureBuilder(
          future: getdrinkapi(), 
          builder: (context , snapshot)
          {
            if(!snapshot.hasData)
            {
              return Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 0, 112, 72), ));
            }
            else
            {
              return Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, 
    childAspectRatio: 0.68, 
  ),
               
              itemCount: drinklist.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8.0), 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          drinklist[index].image ?? 'https://via.placeholder.com/150',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          
                        ),
                      ),
                      
                      
                    ],
                  ),
                );
              },
            ),
              );
            }
          }),
        ),
      ],
    ) ;
  }
}