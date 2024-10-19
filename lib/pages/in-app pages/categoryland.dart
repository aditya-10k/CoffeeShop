import 'package:coffee/workingcomps/apicatcher.dart';
import 'package:coffee/workingcomps/categorys.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          title: Text(widget.category.title,
          style: GoogleFonts.robotoSlab(
            fontWeight:  FontWeight.bold),),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[ FutureBuilder(
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
                                height: 300,
                                width: 200,
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }
                },
              ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}