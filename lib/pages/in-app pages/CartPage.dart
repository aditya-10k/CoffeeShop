import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/workingcomps/coffetile.dart';
import 'package:coffee/workingcomps/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../workingcomps/apicatcher.dart';
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

  Future<void> storeCartToFirestore(Map<BeverageModel, int> cartItems) async {
  try {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("User is not logged in.");
      return;
    }

    final timestamp = Timestamp.now();
    
    
    List<Map<String, dynamic>> itemsList = [];
    cartItems.forEach((key, value) {
      itemsList.add({
        'name': key.name,
        'quantity': value,
      });
    });

    
    await firestore
        .collection('Users')
        .doc(user.uid)
        .collection('cart_history') 
        .add({
          'items': itemsList,
          'timestamp': timestamp,
          'total_items': cartItems.length,
        });

    print("Cart items successfully stored in cart history for user: ${user.uid}");
  } catch (e) {
    print("Error storing cart items: $e");
  }
}

void storeCart() async {
  final cartItems = Provider.of<Cartfunc>(context, listen: false).userCart;

  try {
    await storeCartToFirestore(cartItems); // Store cart in Firestore

    // Clear the cart after successful storage
    Provider.of<Cartfunc>(context, listen: false).clearCart();

    // Show a Snackbar indicating the order has been placed
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Order placed successfully!',
          style: GoogleFonts.robotoSlab(fontSize: 16),
        ),
        backgroundColor: Color.fromARGB(255, 0, 112, 72),
      ),
    );
  } catch (e) {
    print("Error storing cart: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to place order, please try again.'),
        backgroundColor: Colors.red,
      ),
    );
  }
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
                final cartItems = value.userCart.entries.toList();


                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Your Cart',
                            style: GoogleFonts.robotoSlab(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                             
                            ),
                          ),
                        ),

                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(onPressed: storeCart, 
                          icon: Icon(Bootstrap.cart_check, color:Color.fromARGB(255, 0, 112, 72),
                          
                          ),
                          ),
                        ),
                      ],
                    ),
                    cartItems.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Text(
                                'Your cart is empty.',
                                style: GoogleFonts.robotoSlab(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ListView.builder(
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  var entry = cartItems[index];
                                  var drink = entry.key; // The BeverageModel
                                  var quantity = entry.value; // The quantity


                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: CoffeTile(
                                      coffee: drink,
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => removeItem(drink),
                                      quantity: quantity.toString(), // Pass the quantity
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
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


