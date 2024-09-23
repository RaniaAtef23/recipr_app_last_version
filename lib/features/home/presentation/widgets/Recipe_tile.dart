import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/features/home/data/model/meal.dart';
import 'package:meal_app/features/home/data/model/meal_details.dart';
import 'package:meal_app/features/my_recipes/data/models/recipe.dart';


class RecipeTile extends StatelessWidget {
  final Recipe recipe;

  const RecipeTile({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:recipe.image != null
          ? Image.memory(
        recipe.image!,
        width: 50.w,  // Use screen utility for width
        height: 50.h, // Use screen utility for height
        fit: BoxFit.cover,
      )
          : Icon(Icons.image_not_supported, size: 50.w), // Placeholder if no image
      title: Column(
        children: [
          Text(
            'Ingredients', // The text you wanted to display
            style: TextStyle(
              fontSize:18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF832EE5), // Same color as the divider
            ),
          ),
          Text(recipe.ingredients ?? 'Product Title'),
          Text(
            'Recipe', // The text you wanted to display
            style: TextStyle(
              fontSize:18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF832EE5), // Same color as the divider
            ),
          ),
          Text(recipe.recipe ?? 'Product Title'),
        ],
      ),

    );
  }
}