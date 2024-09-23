import 'package:flutter/foundation.dart';
import 'package:meal_app/features/home/data/model/meal.dart';
import 'package:meal_app/features/home/data/model/meal_details.dart';
import 'package:meal_app/features/my_recipes/data/models/recipe.dart';


class FavoriteRecipeNotifier {
  static ValueNotifier<List<Recipe>> favoriteRecipeNotifier = ValueNotifier([]);

  static void addFavorite(Recipe recipe) {
    if (!favoriteRecipeNotifier.value.contains(recipe)) {
      favoriteRecipeNotifier.value = [...favoriteRecipeNotifier.value,recipe ];
    }
  }

  static void removeFavorite(Recipe recipe) {
    favoriteRecipeNotifier.value =
        favoriteRecipeNotifier.value.where((p) => p != recipe).toList();
  }
}