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
  List<BeverageModel> drinklist = [];

  Future<List<BeverageModel>> getdrinkapi() async {
  final response = await http.get(Uri.parse('https://unicode-flutter-lp.onrender.com/get_all_products'));
  var data = jsonDecode(response.body.toString());
  
  if (response.statusCode == 200) {
    drinklist.clear();
    for (Map<String, dynamic> i in List<Map<String, dynamic>>.from(data)) {
      drinklist.add(BeverageModel.fromJson(i));
    }
    return drinklist;
  } else {
    return drinklist;
  }
}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getdrinkapi(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 0, 112, 72),
            ),
          );
        } else {
          return Wrap(
            spacing: 10.0, 
            runSpacing: 10.0, 
            children: List.generate(drinklist.length, (index) {
              return Container(
                width: MediaQuery.of(context).size.width / 2 - 16, 
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    drinklist[index].image ?? 'https://via.placeholder.com/150',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            }),
          );
        }
      },
    );
  }
}
