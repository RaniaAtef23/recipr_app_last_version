import 'package:flutter/material.dart';
import 'package:meal_app/features/home/data/model/meal.dart';
import 'package:meal_app/features/home/data/model/meal_details.dart';
import 'package:meal_app/features/home/presentation/widgets/Recipe_tile.dart';
import 'package:meal_app/features/my_recipes/data/models/recipe.dart';
import 'package:meal_app/features/my_recipes/presentation/widgets/recipe_notifier.dart';


class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<List<Recipe>>(
        valueListenable: FavoriteRecipeNotifier.favoriteRecipeNotifier,
        builder: (context, favoriteRecipes, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'My Recipes', // The text you wanted to display
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF832EE5), // Same color as the divider
                  ),
                ),
              ),
              Expanded(
                child: favoriteRecipes.isEmpty
                    ? const Center(child: Text('No favorites added.'))
                    : ListView.builder(
                  itemCount: favoriteRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = favoriteRecipes[index];
                    return Column(
                      children: [
                        RecipeTile(recipe: recipe),
                        Divider(color: Color(0xFF832EE5)),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
