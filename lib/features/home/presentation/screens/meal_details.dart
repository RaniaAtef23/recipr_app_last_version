import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/network/api_service.dart';
import 'package:meal_app/features/favourite/presentation/widgets/favourite_recipe_nitifier.dart';
import 'package:meal_app/features/home/data/manager/meal_category_cubit.dart';
import 'package:meal_app/features/home/data/manager/meal_category_state.dart';
import 'package:meal_app/features/home/data/model/meal.dart';
import 'package:meal_app/features/home/data/model/meal_details.dart';
import 'package:meal_app/features/home/data/repo/home_repo_impl.dart';
import 'package:meal_app/features/home/presentation/widgets/shimmer_arrows.dart';
import 'package:meal_app/features/home/presentation/widgets/youtube_player.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailsScreen extends StatefulWidget {
  final String id;

  MealDetailsScreen(this.id);

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  bool isFavorite = false;

  void toggleFavorite(MealDetails meal) {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        FavoriteProductNotifier.addFavorite(meal);
      } else {
        FavoriteProductNotifier.removeFavorite(meal);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealDetailsCubit(
        Home_repo_imp(MealService()), // Provide the repository
      )..fetchMealDetails(widget.id),
      child: BlocBuilder<MealDetailsCubit, MealDetailsState>(
        builder: (context, state) {
          if (state is MealDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MealDetailsLoaded) {
            final meal_d = state.mealDetails[0]; // Access the first meal in the list
            final isFavorite = FavoriteProductNotifier.favoriteProductsNotifier.value.contains(meal_d);

            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r),
                          ),
                          child: Stack(
                            children: [
                              Image.network(
                                meal_d.strMealThumb,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 10,
                                right: 8,
                                child: ValueListenableBuilder<List<MealDetails>>(
                                  valueListenable: FavoriteProductNotifier.favoriteProductsNotifier,
                                  builder: (context, favoriteProducts, child) {
                                    final isFavorite = favoriteProducts.contains(meal_d);
                                    return IconButton(
                                      icon: Icon(
                                        isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: isFavorite ? Colors.red : Colors.grey,
                                        size: 40.sp,
                                      ),
                                      onPressed: (){
                                        toggleFavorite(meal_d);

                                      } // Pass the meal

                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0.h,
                          left: 0.w,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20.h),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          meal_d.strMeal,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "Area",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ShimmerArrows(),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              meal_d.strArea,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF832EE5)),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "Category",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ShimmerArrows(),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "${meal_d.strCategory}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF832EE5)),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.h),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 120.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               GestureDetector(
                                  onTap: () async {
                                    final url = meal_d.strYoutube; // Use the YouTube link here
                                    if (await canLaunch(url!)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Container(
                                    width: 100.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF832EE5),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text("Video", style: TextStyle(color: Colors.white, fontSize: 16.sp))),
                                  ),
                                ),
                              SizedBox(width: 15.w),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context) => Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(
                                                  "Ingredients",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemCount: meal_d.ingredients.length,
                                                itemBuilder: (context, index) {
                                                  final meal_ing = meal_d.ingredients[index];
                                                  return Text(meal_ing);
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(
                                                  "Recipe",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(
                                                  "${meal_d.strInstructions}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 100.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF832EE5),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(child: Text("Recipe", style: TextStyle(color: Colors.white, fontSize: 16.sp))),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          right: 190.w,
                          top: -205.h,
                          child: GestureDetector(

                            child: ClipRect(
                              child: ClipPath(
                                clipper: MyClipper2(),
                                child: Container(
                                  width: 300.w,
                                  height: 500.h,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Icon(Icons.video_collection, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          left: 190.w,
                          top: -205.h,
                          child: GestureDetector(

                            child: ClipRect(
                              child: ClipPath(
                                clipper: MyClipper(),
                                child: Container(
                                  width: 300.w,
                                  height: 500.h,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Icon(Icons.receipt, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h), // Added space for the clippers
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text("Error: Unable to load meal details"));
          }
        },
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.7656410,size.height*0.1793839);
    path_0.quadraticBezierTo(size.width*0.7410256,size.height*0.4095972,size.width*0.6528205,size.height*0.4447867);
    path_0.cubicTo(size.width*0.6119231,size.height*0.4760664,size.width*0.4050000,size.height*0.4561611,size.width*0.4051282,size.height*0.5139810);
    path_0.cubicTo(size.width*0.4050000,size.height*0.5723934,size.width*0.6242308,size.height*0.5640995,size.width*0.6671795,size.height*0.5931280);
    path_0.quadraticBezierTo(size.width*0.7457692,size.height*0.6750592,size.width*0.8133333,size.height*0.8905213);
    path_0.lineTo(size.width,size.height*0.8886256);
    path_0.lineTo(size.width*1.0020513,size.height*0.1777251);
    path_0.lineTo(size.width*0.7656410,size.height*0.1793839);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=>true;
}
class MyClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    // Flip the x-coordinates
    path_0.moveTo(size.width * (1 - 0.7656410), size.height * 0.1793839);
    path_0.quadraticBezierTo(
      size.width * (1 - 0.7410256), size.height * 0.4095972,
      size.width * (1 - 0.6528205), size.height * 0.4447867,
    );
    path_0.cubicTo(
      size.width * (1 - 0.6119231), size.height * 0.4760664,
      size.width * (1 - 0.4050000), size.height * 0.4561611,
      size.width * (1 - 0.4051282), size.height * 0.5139810,
    );
    path_0.cubicTo(
      size.width * (1 - 0.4050000), size.height * 0.5723934,
      size.width * (1 - 0.6242308), size.height * 0.5640995,
      size.width * (1 - 0.6671795), size.height * 0.5931280,
    );
    path_0.quadraticBezierTo(
      size.width * (1 - 0.7457692), size.height * 0.6750592,
      size.width * (1 - 0.8133333), size.height * 0.8905213,
    );
    path_0.lineTo(size.width * 0, size.height * 0.8886256);
    path_0.lineTo(size.width * (1 - 1.0020513), size.height * 0.1777251);
    path_0.lineTo(size.width * (1 - 0.7656410), size.height * 0.1793839);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
