import 'package:flutter/material.dart';
import 'package:meal_app/features/favourite/presentation/widgets/favourite_recipe_nitifier.dart';
import 'package:meal_app/features/favourite/presentation/widgets/meal_tile.dart';
import 'package:meal_app/features/home/data/model/meal.dart';
import 'package:meal_app/features/home/data/model/meal_details.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Favorite Recipes",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Color(0xFF832EE5),
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<List<MealDetails>>(
        valueListenable: FavoriteProductNotifier.favoriteProductsNotifier,
        builder: (context, favoriteProducts, child) {
          if (favoriteProducts.isEmpty) {
            return const Center(child: Text('No favorites added.'));
          }
          return ListView.builder(
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = favoriteProducts[index];
              return Column(
                children: [
                  ProductTile(meal: product,),
                  Divider(color: Color(0xFF832EE5),)
                ],
              );
            },
          );
        },
      ),
    );
  }
}