import 'package:coffee/workingcomps/apicatcher.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SearchUser extends SearchDelegate{

  final String categorylink;
  SearchUser(this.categorylink);

  @override
  List<Widget>? buildActions(BuildContext context) {
   return[
    IconButton(
      onPressed: (){
        query = "";
      },
      icon: Icon(AntDesign.close_circle_outline),
      color: Colors.black,
      )
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){Navigator.pop(context);}, 
      icon: Icon(AntDesign.arrow_left_outline),
      color: Colors.black,);
  }

@override
Widget buildResults(BuildContext context) {
  List filteredDrinks = drinklist
      .where((drink) =>
          drink.name!.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 30),
        child: FutureBuilder(
          future: getdrinkapi(categorylink), // Still fetching the API data
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 0, 112, 72),
                ),
              );
            } else {
              return filteredDrinks.isEmpty
                  ? Center(child: Text('No Results Found'))
                  : Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10.0,
                        runSpacing: 20.0,
                        children: List.generate(filteredDrinks.length, (index) {
                          return Container(
                            width: MediaQuery.of(context).size.width / 2 - 16,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    filteredDrinks[index].image ??
                                        'https://via.placeholder.com/150',
                                    fit: BoxFit.cover,
                                    height: 300,
                                    width: 200,
                                  ),
                                ),
                                Text(
                                  filteredDrinks[index].name ?? 'No data',
                                   maxLines: 1,  
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    );
            }
          },
        ),
      ),
    ),
  );
}


  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('Search your mind'));
  }

  
}