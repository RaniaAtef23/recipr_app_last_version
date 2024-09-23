import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_app/features/my_recipes/data/models/recipe.dart';
import 'package:meal_app/features/my_recipes/presentation/widgets/recipe_notifier.dart';
import 'dart:typed_data';




import '../../../favourite/presentation/widgets/favourite_recipe_nitifier.dart'; // For Uint8List



class DashedBorderExample extends StatefulWidget {
  @override
  _DashedBorderExampleState createState() => _DashedBorderExampleState();
}

class _DashedBorderExampleState extends State<DashedBorderExample> {
  Uint8List? _imageData; // Store image data as Uint8List
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _recipeController = TextEditingController();
  final List<Recipe> _newRecipes = []; // List to store new recipes

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h,),
              Row(

                children: [
                  IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
                  SizedBox(width: 20.w,),
                  Text(
                  'Make Your Recipe', // The text you wanted to display
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF832EE5), // Same color as the divider
                  ),
                              ),
                ],
              ),
                SizedBox(height: 20.h,),
                CircleAvatar(
                  backgroundImage: _imageData == null ? null : MemoryImage(_imageData!),
                  radius: 80,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF832EE5),
                  ),
                  child: Text("Pick Image", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 20),
                Container(
                  width: 600.w,
                  height: 200.h,
                  child: DottedBorder(
                    color: Color(0xFF832EE5),
                    strokeWidth: 2,
                    dashPattern: [4, 4],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: _ingredientsController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Recipe Ingredient',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: 600.w,
                  height: 200.h,
                  child: DottedBorder(
                    color: Color(0xFF832EE5),
                    strokeWidth: 2,
                    dashPattern: [4, 4],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: _recipeController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Your Recipe',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: (){
                    addRecipe;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network("assets/Iu9NwI5Xcw.gif"),
                              Text(
                                'Success',
                                style: TextStyle(
                                  color: const Color(0xFF101623),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp, // Responsive font size
                                  fontFamily: 'Comfortaa',
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Your Recipe has been added successfully!',
                                  style: TextStyle(
                                    color: const Color(0xFFA1A8B0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp, // Responsive font size
                                    fontFamily: 'Comfortaa',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);// Close the dialog
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:Color(0xFF832EE5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r), // Responsive border radius
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 50.w), // Responsive padding
                                ),
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp, // Responsive font size
                                    fontFamily: 'Comfortaa',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                  },
                  child: Container(
                    width: 150.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Color(0xFF832EE5),
                    ),
                    child: Center(child: Text("Add Recipe", style: TextStyle(color: Colors.white))),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      setState(() {
        _imageData = bytes; // Set the image data
      });
    }
  }

  void addRecipe() {
    if (_ingredientsController.text.isNotEmpty && _recipeController.text.isNotEmpty) {
      final newRecipe = Recipe(
        image: _imageData,
        ingredients: _ingredientsController.text,
        recipe: _recipeController.text,
      );

      setState(() {
        FavoriteRecipeNotifier.addFavorite(newRecipe);
      });

      _ingredientsController.clear();
      _recipeController.clear();
      setState(() {
        _imageData = null; // Optionally clear the selected image
      });

      // Navigate to the RecipeListPage
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in all fields.'),
      ));
    }
  }
}


