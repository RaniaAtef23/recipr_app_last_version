import 'package:flutter/foundation.dart';
import 'package:meal_app/features/home/data/model/meal.dart';
import 'package:meal_app/features/home/data/model/meal_details.dart';

class FavoriteProductNotifier {
  static ValueNotifier<List<MealDetails>> favoriteProductsNotifier = ValueNotifier([]);

  static void addFavorite(MealDetails meal) {
    if (!favoriteProductsNotifier.value.contains(meal)) {
      favoriteProductsNotifier.value = [...favoriteProductsNotifier.value,meal ];
    }
  }

  static void removeFavorite(MealDetails product) {
    favoriteProductsNotifier.value =
        favoriteProductsNotifier.value.where((p) => p != product).toList();
  }
}