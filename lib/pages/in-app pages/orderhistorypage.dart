import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
       backgroundColor: Colors.white,
       centerTitle: true,
       toolbarHeight: 70,
        title: Text(
          'Order History',
          style: GoogleFonts.robotoSlab(
            color: Colors.black
            ,
            
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart_history')
            .orderBy('timestamp', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF00704A),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No order history found.",
                style: GoogleFonts.robotoSlab(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            );
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final items = List<dynamic>.from(order['items']); 
              final timestamp = order['timestamp'] as Timestamp;

              return Card(
                margin: const EdgeInsets.only(bottom: 10.0),
                color: const Color(0xFF00704A), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order: ${timestamp.toDate()}",
                        style: GoogleFonts.robotoSlab(
                          color: Colors.grey.shade200,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Items:",
                        style: GoogleFonts.robotoSlab(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ...items.map((item) {
                        if (item is Map<String, dynamic>) {
                          // Handle Map items
                          return Text(
                            "- ${item['name']}:  ${item['quantity']}",
                            style: GoogleFonts.robotoSlab(
                              color: Colors.grey.shade200,
                              fontSize: 14,
                            ),
                          );
                        }  else {
                          return const SizedBox.shrink();
                        }
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
