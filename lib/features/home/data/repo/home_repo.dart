import 'package:dartz/dartz.dart';
import 'package:meal_app/core/errors/failers.dart';
import 'package:meal_app/features/home/data/model/category.dart';
import 'package:meal_app/features/home/data/model/meal.dart';
import 'package:meal_app/features/home/data/model/meal_details.dart';


abstract class Home_repo {
  Future<Either<failers, List<MealDetails>>> fetch_meal_details(String id);
  Future<Either<failers, List<Categories>>> fetch_all_categories();
  Future<Either<failers, List<Meal>>> fetch_meal_by_category(String category);
}
