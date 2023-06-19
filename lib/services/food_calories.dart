import 'dart:convert';
import 'dart:developer';

import 'package:fitmate/Models/calories_response.dart';
import 'package:http/http.dart' as http;

class ApiServices {


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

}
