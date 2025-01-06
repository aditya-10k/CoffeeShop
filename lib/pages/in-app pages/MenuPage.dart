import 'package:coffee/workingcomps/apicatcher.dart';
import 'package:coffee/workingcomps/cartfunc.dart';
import 'package:coffee/workingcomps/coffetile.dart';
import 'package:coffee/workingcomps/model.dart'; // Update to import BeverageModel
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Future<List<BeverageModel>>? _drinkListFuture;

  @override
  void initState() {
    super.initState();
    // Fetch data once when the page loads
    _drinkListFuture = getdrinkapi('https://unicode-flutter-lp.onrender.com/get_all_products');
  }

  void addItem(BeverageModel coffee) {
    Provider.of<Cartfunc>(context, listen: false).additem(coffee);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cartfunc>(
      builder: (context, value, child) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder<List<BeverageModel>>(
            future: _drinkListFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 0, 112, 72),
                  ),
                );
              } else {
                List<BeverageModel> drinkList = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Bold Brews & Sweet Treats",
                          style: GoogleFonts.robotoSlab(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: drinkList.length,
                          itemBuilder: (context, index) {
                            var eachItem = drinkList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: CoffeTile(
                                coffee: eachItem,
                                icon: const Icon(Icons.add),
                                onPressed: () => addItem(eachItem),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
