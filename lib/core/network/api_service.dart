import 'package:dio/dio.dart';

class MealService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchdata(String endpoint) async {
    final String url = 'https://www.themealdb.com/api/json/v1/1/$endpoint';


    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        // The API returns a "categories" key in the response
        if(endpoint=="categories.php") {
          return response.data['categories'];
        }
        else {
          return response.data['meals'];

        }
      } else {
        throw Exception('Failed to load meal categories');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching data');
    }
  }
}
