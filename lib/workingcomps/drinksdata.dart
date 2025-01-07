import 'dart:convert';

import 'package:coffee/workingcomps/cartfunc.dart';
import 'package:coffee/workingcomps/model.dart';
import 'package:coffee/workingcomps/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class Drinksdata extends StatefulWidget {
  Drinksdata({super.key});
  


  @override
  State<Drinksdata> createState() => _DrinksdataState();
}

class _DrinksdataState extends State<Drinksdata> {

  List<BeverageModel> drinklist = [];
  final String lynk ='https://unicode-flutter-lp-new-final.onrender.com/get_all_products';

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
        toolbarHeight: 70,
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
                      alignment: WrapAlignment.center,
                      spacing: 10.0, 
                      runSpacing: 20.0, 
                      children: List.generate(drinklist.length, (index) {
                        return Container(
                          decoration: BoxDecoration(
                            color:  Color.fromARGB(255, 0, 112, 72),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          width: MediaQuery.of(context).size.width / 2 - 16, 
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                  child: Image.network(
                                    drinklist[index].image ?? 'https://via.placeholder.com/150',
                                    fit: BoxFit.cover,
                                    height: 300,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Text(
                                  drinklist[index].name??'no data',
                                   maxLines: 1,  
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                              ),

                                //SizedBox(height: 3,),

                                  FilledButton(
                                  onPressed: () {  Provider.of<Cartfunc>(context, listen: false)
                                        .additem(drinklist[index]); },
                                  child: Icon(Icons.add) ,
                                  style: ButtonStyle(
                                    backgroundColor:  WidgetStateProperty.all(Color.fromARGB(255, 0, 112, 72)),
                                  )
                                  )
                            ],
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
