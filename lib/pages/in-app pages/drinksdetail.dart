import 'package:coffee/workingcomps/cartfunc.dart';
import 'package:coffee/workingcomps/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DrinkDetailsPage extends StatelessWidget {
  final BeverageModel drink;

  DrinkDetailsPage({super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
            onPressed: () {
              Provider.of<Cartfunc>(context, listen: false)
                  .additem(context, drink);
            },
            child: const Text('Add to Cart'),
            style: ButtonStyle(
              backgroundColor:  WidgetStateProperty.all(
                const Color.fromARGB(255, 0, 112, 72),
              ),
            ),
          ),
        ),],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0,12,12,0),
              child: Hero(
                tag: drink.sId ?? 'defaultTag',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    drink.image ?? 'https://via.placeholder.com/150',
                    fit: BoxFit.cover,
                    height: 500,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 112, 72), 
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      drink.name ?? 'No name available',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${drink.description ?? 'No description available.'}',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Instructions:',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    ...?drink.recipeInstructions?.map(
                      (instruction) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          '- ${instruction.text ?? 'No instructions available.'}',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Ingredients:',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    ...?drink.recipeIngredient?.map(
                      (ingredient) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          '- $ingredient',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
