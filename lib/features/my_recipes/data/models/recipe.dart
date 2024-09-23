
import 'dart:typed_data';

class Recipe {
  final Uint8List? image;
  final String ingredients;
  final String recipe;

  Recipe({this.image, required this.ingredients, required this.recipe});
}