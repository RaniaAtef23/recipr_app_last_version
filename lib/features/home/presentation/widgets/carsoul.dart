import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/network/api_service.dart';
import 'package:meal_app/features/home/data/manager/meal_category_cubit.dart';
import 'package:meal_app/features/home/data/manager/meal_category_state.dart';
import 'package:meal_app/features/home/data/repo/home_repo_impl.dart';



import 'package:skeletonizer/skeletonizer.dart';


class CategoryCarousel extends StatefulWidget {
  @override
  State<CategoryCarousel> createState() => _CategoryCarouselState();
}

class _CategoryCarouselState extends State<CategoryCarousel> {
  bool _showSkeleton = true; // Initial state to show skeleton

  @override
  void initState() {
    super.initState();
    // Disable skeleton after 2 seconds
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showSkeleton = false; // Stop showing skeleton after 2 seconds
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        Home_repo_imp(MealService()), // Provide the repository
      )..fetchAllCategories(), // Automatically fetch categories on widget build
      child: BlocBuilder<HomeCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return Skeletonizer(
              enabled: _showSkeleton, // Skeletonizer is controlled by this state
              enableSwitchAnimation: true,
              child: CarouselSlider.builder(
                itemCount: state.categories.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  final category = state.categories[index];
                  return Container(
                    width: double.infinity,
                    //margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: (category.strCategory=="Goat")?NetworkImage("assets/placeholder1.jpg",):(category.strCategory=="Breakfast")?NetworkImage("assets/placeholder2.jpg"):(category.strCategory=="Beef")?NetworkImage("assets/placeholder2.jpg"):NetworkImage(category.strCategoryThumb),
                        fit: BoxFit.cover,
                      ),
                    ),

                  );
                },
                options: CarouselOptions(
                  height: 220,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
              ),
            );
          } else if (state is CategoryError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return Center(child: Text('No categories available.'));
          }
        },
      ),
    );
  }
}
