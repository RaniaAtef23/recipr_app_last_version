import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/features/home/data/model/meal.dart';
import 'package:meal_app/features/home/data/model/meal_details.dart';


class ProductTile extends StatelessWidget {
  final MealDetails meal;

  const ProductTile({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        meal.strMealThumb ?? 'https://via.placeholder.com/150',
        width: 50.w, // Use screen utility for width
        height: 50.h, // Use screen utility for height
      ),
      title: Text(meal.strMeal ?? 'Product Title'),

    );
  }
}