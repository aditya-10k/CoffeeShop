import 'package:coffee/pages/in-app%20pages/drinksdetail.dart';
import 'package:coffee/workingcomps/apicatcher.dart';
import 'package:coffee/workingcomps/cartfunc.dart';
import 'package:coffee/workingcomps/categorys.dart';
import 'package:coffee/workingcomps/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class Categoryland extends StatefulWidget {
  const Categoryland({super.key, required this.category});

  final Category category;

  @override
  State<Categoryland> createState() => _CategorylandState();
}

class _CategorylandState extends State<Categoryland> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.category.title,
            style: GoogleFonts.robotoSlab(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchUser(widget.category.link));
              },
              icon: Icon(AntDesign.search_outline),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 30),
            child: FutureBuilder(
              future: getdrinkapi(widget.category.link),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 0, 112, 72),
                    ),
                  );
                } else {
                  return Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10.0, // Horizontal space between items
                      runSpacing: 20.0, // Vertical space between items
                      children: List.generate(drinklist.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to DrinkDetailsPage on tap
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DrinkDetailsPage(drink: drinklist[index]),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 112, 72),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: MediaQuery.of(context).size.width / 2 - 16,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Hero(
                                    tag: drinklist[index].sId ?? 'defaultTag',
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                      child: Image.network(
                                        drinklist[index].image ?? 'https://via.placeholder.com/150',
                                        fit: BoxFit.cover,
                                        height: 300,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                                  child: Text(
                                    drinklist[index].name ?? 'no data',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    Provider.of<Cartfunc>(context, listen: false).additem(
                                      context,
                                      drinklist[index],
                                    );
                                  },
                                  child: Icon(Icons.add),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 0, 112, 72),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
