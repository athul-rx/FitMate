class CaloriesResponseModel {
  String? name;
  double? calories;
  double? servingSizeG;
  double? fatTotalG;
  double? fatSaturatedG;
  double? proteinG;
  int? sodiumMg;
  int? potassiumMg;
  int? cholesterolMg;
  double? carbohydratesTotalG;
  double? fiberG;
  double? sugarG;

  CaloriesResponseModel(
      {this.name,
      this.calories,
      this.servingSizeG,
      this.fatTotalG,
      this.fatSaturatedG,
      this.proteinG,
      this.sodiumMg,
      this.potassiumMg,
      this.cholesterolMg,
      this.carbohydratesTotalG,
      this.fiberG,
      this.sugarG});

  factory CaloriesResponseModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return CaloriesResponseModel(
        name: json['name'],
        calories: json['calories'],
        servingSizeG: json['serving_size_g'],
        fatTotalG: json['fat_total_g'],
        fatSaturatedG: json['fat_saturated_g'],
        proteinG: json['protein_g'],
        sodiumMg: json['sodium_mg'],
        potassiumMg: json['potassium_mg'],
        cholesterolMg: json['cholesterol_mg'],
        carbohydratesTotalG: json['carbohydrates_total_g'],
        fiberG: json['fiber_g'],
        sugarG: json['sugar_g'],
      );
    } else {
      // Handle JSON array response
      // You can iterate over the array and create a list of CaloriesResponseModel objects if needed
      throw Exception('Unexpected response format');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['calories'] = calories;
    data['serving_size_g'] = servingSizeG;
    data['fat_total_g'] = fatTotalG;
    data['fat_saturated_g'] = fatSaturatedG;
    data['protein_g'] = proteinG;
    data['sodium_mg'] = sodiumMg;
    data['potassium_mg'] = potassiumMg;
    data['cholesterol_mg'] = cholesterolMg;
    data['carbohydrates_total_g'] = carbohydratesTotalG;
    data['fiber_g'] = fiberG;
    data['sugar_g'] = sugarG;
    return data;
  }
}
