import 'dart:convert';
import 'dart:developer';
import 'package:fitmate/Models/calories_response.dart';
import 'package:fitmate/Models/food_request.dart';
import 'package:fitmate/Models/food_response.dart';
import 'package:http/http.dart' as http;
class APIServices {
  static var client = http.Client();


  //Fetch food calories API REQUEST
  Future<List<CaloriesResponseModel>> fetchNutritionData(String query) async {
  const apiKey = 'cyJ73QlfbP2hSsENjQcShw==K3HhFEpOYhC2h7WX';
  final url = 'https://api.api-ninjas.com/v1/nutrition?query=$query';

  final response = await http.get(Uri.parse(url), headers: {'X-Api-Key': apiKey});

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse is List) {
      return jsonResponse
          .map((json) => CaloriesResponseModel.fromJson(json))
          .toList();
    } else if (jsonResponse is Map<String, dynamic>) {
      if (jsonResponse.containsKey('items')) {
        final items = jsonResponse['items'];
        if (items is List) {
          return items
              .map((json) => CaloriesResponseModel.fromJson(json))
              .toList();
        }
      }
    }
    throw Exception('Unexpected response format');
  } else {
    print('Error: ${response.statusCode} ${response.body}');
    throw Exception('Failed to load data!');
  }
}



   //Food ADDING API REQUEST
 Future<bool> addFood(FoodCaloriesRequestModel model) async {
    log(model.toJson().toString());
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    int userId = 1;
    final url = Uri.parse("https://fitmate-api-r2ic.onrender.com/user/data/food/details/add/$userId");
    final body = jsonEncode(model.toJson());
    var response = await client.post(url, headers: headers, body: body);

    if (response.statusCode == 307) {
      var redirectUrl = response.headers['location'];
      response = await client.post(Uri.parse(redirectUrl!),
          headers: headers, body: body);
    }

    if (response.statusCode == 200) {
      log(response.body);
      return true;
    } else {
      throw Exception(
          'Failed to add product: ${response.body}+ ${response.statusCode}');
      // return false;
    }
  }

  //get added food from user

Future<FoodResponseModel> fetchFoodData() async {
  final url = Uri.parse('https://fitmate-api-r2ic.onrender.com/user/data/food/details/read/1');

  final response = await http.post(url);
  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body);

    // Parse the JSON response into FoodResponseModel
    final foodResponse = FoodResponseModel.fromJson(jsonBody);
    return foodResponse;
  } else {
    throw Exception('Failed to fetch food data');
  }
}
}
