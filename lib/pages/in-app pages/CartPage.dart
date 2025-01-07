import 'package:coffee/workingcomps/coffetile.dart';
import 'package:coffee/workingcomps/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../workingcomps/apicatcher.dart'; // Assuming this file has the API fetching function
import '../../workingcomps/cartfunc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<List<BeverageModel>>? _drinkListFuture;

  @override
  void initState() {
    super.initState();
    _drinkListFuture = getdrinkapi('https://unicode-flutter-lp-new-final.onrender.com/get_all_products');
  }

  void removeItem(BeverageModel drink) {
    Provider.of<Cartfunc>(context, listen: false).removeitem(drink);
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
                
                List<BeverageModel> cartItems = value.usercart;


                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Your Cart',
                        style: GoogleFonts.robotoSlab(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            var eachItem = cartItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: CoffeTile(
                                coffee: eachItem,
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => removeItem(eachItem),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
