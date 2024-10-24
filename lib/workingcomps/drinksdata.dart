import 'dart:convert';

import 'package:coffee/workingcomps/model.dart';
import 'package:coffee/workingcomps/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';

class Drinksdata extends StatefulWidget {
  Drinksdata({super.key});
  


  @override
  State<Drinksdata> createState() => _DrinksdataState();
}

class _DrinksdataState extends State<Drinksdata> {
  List<BeverageModel> drinklist = [];
  final String lynk ='https://unicode-flutter-lp.onrender.com/get_all_products';

  Future<List<BeverageModel>> getdrinkapi() async {
  final response = await http.get(Uri.parse(lynk));
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
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('ALL PRODUCTS',
          style: GoogleFonts.robotoSlab(
            fontWeight:  FontWeight.bold),),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: (){ 
                showSearch(context: context, delegate: SearchUser(lynk));
              }, 
              icon: Icon(AntDesign.search_outline))
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: FutureBuilder(
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(                             
                            borderRadius: BorderRadius.circular(20),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    drinklist[index].image ?? 'https://via.placeholder.com/150',
                                    fit: BoxFit.cover,
                                          height: 300,
                                          width: 200,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    drinklist[index].name??'no data',
                                     maxLines: 1,  
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ),
                                  SizedBox(height: 3,)
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
