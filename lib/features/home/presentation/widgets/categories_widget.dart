import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/home/data/manager/meal_category_cubit.dart';
import 'package:meal_app/features/home/data/manager/meal_category_state.dart';
import 'package:meal_app/features/home/data/repo/home_repo.dart';
import 'package:meal_app/features/home/data/repo/home_repo_impl.dart';
import 'package:meal_app/features/home/presentation/widgets/meal_list.dart';

import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/network/api_service.dart';
class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
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
    return BlocProvider(create: (context) => HomeCubit(
      Home_repo_imp(MealService()) as Home_repo, // Provide the repository
    )..fetchAllCategories(),
      child: BlocBuilder<HomeCubit, CategoryState>(builder:(context,state){
        if(state is CategoryLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        else if(state is CategoryLoaded){
          return Skeletonizer(
            enabled: _showSkeleton, // Skeletonizer is controlled by this state
            enableSwitchAnimation: true,
            child: SizedBox(
              height: 100, // You can adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final category = state.categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>MealList(category.strCategory) ));
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(category.strCategoryThumb),
                            radius: 30, // Adjust the radius as needed
                          ),
                        ),
                        Text("${category.strCategory}",style: TextStyle(color: Color(
                            0xFF9E9E9E)),)
                      ],
                    ),
                  );
                },
                itemCount: state.categories.length,
              ),
            ),
          );

        }
        else{
          return Text("Error:");
        }
      }),
    );

  }
}
