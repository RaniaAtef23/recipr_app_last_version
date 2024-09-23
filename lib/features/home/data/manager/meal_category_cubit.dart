import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/home/data/model/category.dart';
import 'package:meal_app/features/home/data/model/meal.dart';
import 'package:meal_app/features/home/data/model/meal_details.dart';
import '../../../../core/errors/failers.dart';
import 'package:meal_app/features/home/data/manager/meal_category_state.dart';

import 'package:meal_app/features/home/data/repo/home_repo.dart';

// Cubit to manage categories
class HomeCubit extends Cubit<CategoryState> {
  final Home_repo _homeRepo;

  HomeCubit(this._homeRepo) : super(CategoryInitial());

  // Fetch all categories
  Future<void> fetchAllCategories() async {
    emit(CategoryLoading());
    final Either<failers, List<Categories>> result =
    await _homeRepo.fetch_all_categories();

    result.fold(
          (failure) => emit(CategoryError(failure.error)),
          (categories) => emit(CategoryLoaded(categories)),
    );
  }
}

// Cubit to manage meals by category
class MealCubit extends Cubit<MealState> {
  final Home_repo _homeRepo;

  MealCubit(this._homeRepo) : super(MealInitial());

  // Fetch meals by category
  Future<void> fetchMealsByCategory(String category) async {
    emit(MealLoading());
    final Either<failers, List<Meal>> result =
    await _homeRepo.fetch_meal_by_category(category);

    result.fold(
          (failure) => emit(MealError(failure.error)),
          (meals) => emit(MealLoaded(meals)),
    );
  }
}

// Cubit to manage meal details
class MealDetailsCubit extends Cubit<MealDetailsState> {
  final Home_repo _homeRepo;

  MealDetailsCubit(this._homeRepo) : super(MealDetailsInitial());

  // Fetch meal details by ID
  Future<void> fetchMealDetails(String id) async {
    emit(MealDetailsLoading());
    final Either<failers, List<MealDetails>> result =
    await _homeRepo.fetch_meal_details(id);

    result.fold(
          (failure) => emit(MealDetailsError(failure.error)),
          (mealDetails) => emit(MealDetailsLoaded(mealDetails)),
    );
  }
}
