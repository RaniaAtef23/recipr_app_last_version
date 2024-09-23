import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:meal_app/features/home/presentation/widgets/Most_popular.dart';
import 'package:meal_app/features/my_recipes/presentation/screens/make_recipe.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:meal_app/features/home/presentation/widgets/carsoul.dart';
import 'package:meal_app/features/home/presentation/widgets/categories_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                  child: Skeletonizer(
                    enabled: _showSkeleton, // Skeletonizer is controlled by this state
                    enableSwitchAnimation: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Welcome",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                                color: Color(0xFF832EE5),
                              ),
                            ),
                            Text(
                              "Rania,",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage("assets/profile.png"),
                          radius: 20.r, // Adjust the radius as needed
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.sp),
                // Category Carousel
                CategoryCarousel(),
                Padding(
                  padding:  EdgeInsets.only(left: 20.w),
                  child: Column(
                    children: [
                      Skeletonizer(
                        enabled: _showSkeleton, // Skeletonizer is controlled by this state
                        enableSwitchAnimation: true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Categories",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CategoriesWidget(),
                      MostPopular(),
                      SizedBox(height:10.h),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned CircleAvatar (Add button) at the bottom-right
           Positioned(
                bottom: 40.h, // Distance from the bottom
                right: 20.w, // Distance from the right
                child: CircleAvatar(
                  backgroundColor: Color(0xFF832EE5),
                  child: InkWell(
                    onTap: (){
        
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>DashedBorderExample()));
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  radius: 30.r, // Adjust the radius as needed
                ),
              ),
        
          ],
        ),
      ),
    );
  }
}
