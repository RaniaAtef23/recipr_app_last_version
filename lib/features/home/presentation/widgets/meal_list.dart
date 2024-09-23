import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/network/api_service.dart';
import 'package:meal_app/features/home/data/manager/meal_category_cubit.dart';
import 'package:meal_app/features/home/data/manager/meal_category_state.dart';
import 'package:meal_app/features/home/presentation/screens/meal_details.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/repo/home_repo_impl.dart';

class MealList extends StatefulWidget {
  final String categoryName;

  MealList(this.categoryName);

  @override
  _MealListState createState() => _MealListState();
}

class _MealListState extends State<MealList> {
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
      create: (context) => MealCubit(
        Home_repo_imp(MealService()), // Provide the repository
      )..fetchMealsByCategory(widget.categoryName),
      child: BlocBuilder<MealCubit, MealState>(
        builder: (context, state) {
          if (state is MealLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MealLoaded) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: Skeletonizer(
                  enabled: _showSkeleton, // Skeletonizer is controlled by this state
                  enableSwitchAnimation: true,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.meals.length + 1, // Adjust itemCount to account for the header
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        // Header (Row with back button and category name)
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back_ios),
                              ),
                              SizedBox(width: 100,),
                              Center(
                                child: Text(
                                  "${widget.categoryName}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // List of meals
                        final meal = state.meals[index - 1]; // Adjust for the header
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MealDetailsScreen(meal.idMeal),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20), // Apply the border radius
                                    child: Image.network(
                                      meal.strMealThumb,
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      fit: BoxFit.cover, // Ensures the image covers the full width without distortion
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                meal.strMeal,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text("Error: Unable to load meals"));
          }
        },
      ),
    );
  }
}
