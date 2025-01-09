import 'package:coffee/workingcomps/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CoffeTile extends StatelessWidget {
  final BeverageModel coffee;
  final Widget icon;
  final void Function()? onPressed;
  final String? quantity;


  CoffeTile({
    super.key,
    required this.coffee,
    required this.onPressed,
    required this.icon,
    this.quantity,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 112, 72),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      //padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
      width: MediaQuery.of(context).size.width / 2 - 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
            child: Image.network(
              coffee.image ?? 'https://via.placeholder.com/150',
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity, // Match parent width
            ),
          ),
          const SizedBox(height: 10),
          Text(
            coffee.name ?? 'No data',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.robotoSlab(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          if (quantity != null) // Display quantity if provided
            Text(
              'Quantity: $quantity', // Label for clarity
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.robotoSlab(
                color: Colors.grey.shade200,
                fontSize: 14,
              ),
            ),
          IconButton(
            onPressed: onPressed,
            icon: icon,
            color: Colors.white,
            highlightColor: Colors.lightGreenAccent[400],
          ),
        ],
      ),
    );
  }
}


