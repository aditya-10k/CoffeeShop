import 'dart:convert';
import 'package:coffee/workingcomps/model.dart';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


  List<BeverageModel> drinklist = []; 
  Future<List<BeverageModel>> getdrinkapi(String url) async {
  final response = await http.get(Uri.parse(url));
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