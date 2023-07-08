class FoodCaloriesRequestModel {
  String? foodName;
  String? foodType;
  double? quantity;
  double? calories;

  FoodCaloriesRequestModel(
      {this.foodName, this.foodType, this.quantity, this.calories});

  FoodCaloriesRequestModel.fromJson(Map<String, dynamic> json) {
    foodName = json['food_name'];
    foodType = json['food_type'];
    quantity = json['quantity'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_name'] = foodName;
    data['food_type'] = foodType;
    data['quantity'] = quantity;
    data['calories'] = calories;
    return data;
  }
}