
import 'package:dartz/dartz.dart';
import 'package:meal_app/core/errors/failers.dart';
import 'package:meal_app/features/home/data/model/category.dart';
import 'package:meal_app/features/home/data/model/meal.dart';
import 'package:meal_app/features/home/data/model/meal_details.dart';
import 'package:meal_app/features/home/data/repo/home_repo.dart';



import '../../../../core/network/api_service.dart';

class Home_repo_imp implements Home_repo {
  final MealService _mealService;

  Home_repo_imp(this._mealService);
  @override

  Future<Either<failers, List<MealDetails>>> fetch_meal_details(String id) async {
    try {
      // Assuming correct endpoint
      List<dynamic> mealDetailsJson = await _mealService.fetchdata("lookup.php?i=$id");
      List<MealDetails> mealDetailsList = mealDetailsJson.map((details) => MealDetails.fromJson(details)).toList();

      return right(mealDetailsList);
    } catch (e) {
      print(e); // Print the error for more insight
      return left(server_error(e.toString()));
    }
  }


  @override
  Future<Either<failers, List<Categories>>> fetch_all_categories() async {
    try {
      // Assuming correct endpoint
      List<dynamic> categories = await _mealService.fetchdata("categories.php");
      List<Categories> categories2 = [];
      for (var category in categories) {
        var meal = Categories.fromJson(category);

        // Check if the image link is null and only add the meal if it is not null

        categories2.add(meal);
      }

      return right(categories2);
    } catch (e) {
      print(e); // Print the error for more insight
      return left(server_error(e.toString()));
    }
  }


  @override
  Future<Either<failers, List<Meal>>> fetch_meal_by_category(
      String category) async {
    try {
      // Assuming correct endpoint
      List<dynamic> meals = await _mealService.fetchdata(
          "filter.php?c=$category");
      List<Meal> meals2 = [];
      for (var food in meals) {
        var meal = Meal.fromJson(food);
        meals2.add(meal);
      }
      return right(meals2);

    } catch (e) {
      print(e); // Print the error for more insight
      return left(server_error(e.toString()));
    }
  }
}