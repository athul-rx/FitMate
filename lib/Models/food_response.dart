class FoodResponseModel {
  String status;
  int code;
  List<FoodItem> data;

  FoodResponseModel({
    required this.status,
    required this.code,
    required this.data,
  });

  factory FoodResponseModel.fromJson(Map<String, dynamic> json) {
    return FoodResponseModel(
      status: json['status'],
      code: json['code'],
      data: List<FoodItem>.from(
        json['data'].map((item) => FoodItem.fromJson(item)),
      ),
    );
  }
}

class FoodItem {
  int userId;
  String foodName;
  int quantity;
  DateTime foodTime;
  int id;
  String foodType;
  double calories;

  FoodItem({
    required this.userId,
    required this.foodName,
    required this.quantity,
    required this.foodTime,
    required this.id,
    required this.foodType,
    required this.calories,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      userId: json['user_id'],
      foodName: json['food_name'],
      quantity: json['quantity'],
      foodTime: DateTime.parse(json['food_time']),
      id: json['id'],
      foodType: json['food_type'],
      calories: json['calories'].toDouble(),
    );
  }
}
