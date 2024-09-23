import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/features/home/data/manager/meal_category_cubit.dart';
import 'package:meal_app/features/home/data/manager/meal_category_state.dart';
import 'package:meal_app/features/home/data/repo/home_repo.dart';
import 'package:meal_app/features/home/data/repo/home_repo_impl.dart';
import 'package:meal_app/features/home/presentation/widgets/meal_list.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/network/api_service.dart';

class MostPopular extends StatefulWidget {
  const MostPopular({super.key});

  @override
  State<MostPopular> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
  bool _showSkeleton = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showSkeleton = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(Home_repo_imp(MealService()) as Home_repo)
        ..fetchAllCategories(),
      child: BlocBuilder<HomeCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return Skeletonizer(
              enabled: _showSkeleton,
              enableSwitchAnimation: true,
              child: SizedBox(
                height: 300.h, // Set the height to 300
                width: 600.w, // Adjust width as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final category = state.categories[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MealList(category.strCategory),
                                ),
                              );
                            },
                            child: SizedBox(
                              width:350.w, // Adjust the width of the card
                              child: Container(
                                height: 250.h, // Adjust the height of the container
                                decoration: BoxDecoration(
                                  color: Color(0x4A760EBB),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.w),
                                      child: Image.network(
                                        category.strCategoryThumb,
                                        width: 170.w, // Adjust the width of the image
                                        height: 130.h, // Adjust the height of the image
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10.w), // Add spacing
                                    Expanded(
                                      child: Text(
                                        category.strCategoryDescription,
                                        overflow: TextOverflow.ellipsis, // Prevent overflow
                                        maxLines: 5, // Limit the lines to prevent stretching
                                        style: TextStyle(fontSize: 12.sp,color: Colors.grey,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h), // Add some space between image and text

                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const Text("Error:");
          }
        },
      ),
    );
  }
}
