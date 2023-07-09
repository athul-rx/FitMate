class BiometricResponse {
  String? status;
  int? code;
  Data? data;

  BiometricResponse({this.status, this.code, this.data});

  BiometricResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  double? height;
  double? bmi;
  int? id;
  int? age;
  double? weight;

  Data({this.userId, this.height, this.bmi, this.id, this.age, this.weight});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    height = json['height'];
    bmi = json['bmi'];
    id = json['id'];
    age = json['age'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['height'] = height;
    data['bmi'] = bmi;
    data['id'] = id;
    data['age'] = age;
    data['weight'] = weight;
    return data;
  }
}