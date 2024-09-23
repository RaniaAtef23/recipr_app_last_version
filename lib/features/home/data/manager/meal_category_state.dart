import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/home/data/model/category.dart';
import 'package:meal_app/features/home/data/model/meal.dart';
import 'package:meal_app/features/home/data/model/meal_details.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failers.dart';
import 'package:meal_app/features/home/data/repo/home_repo.dart';

// States for Categories
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Categories> categories;

  const CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryError extends CategoryState {
  final String errorMessage;

  const CategoryError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

// States for Meals
abstract class MealState extends Equatable {
  const MealState();

  @override
  List<Object> get props => [];
}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<Meal> meals;

  const MealLoaded(this.meals);

  @override
  List<Object> get props => [meals];
}

class MealError extends MealState {
  final String errorMessage;

  const MealError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

// States for Meal Details
abstract class MealDetailsState extends Equatable {
  const MealDetailsState();

  @override
  List<Object> get props => [];
}

class MealDetailsInitial extends MealDetailsState {}

class MealDetailsLoading extends MealDetailsState {}

class MealDetailsLoaded extends MealDetailsState {
  final List<MealDetails> mealDetails;

  const MealDetailsLoaded(this.mealDetails);

  @override
  List<Object> get props => [mealDetails];
}

class MealDetailsError extends MealDetailsState {
  final String errorMessage;

  const MealDetailsError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
