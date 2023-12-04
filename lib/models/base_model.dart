class BaseModel {
  bool status;
  String message;

  BaseModel({
    required this.status,
    required this.message,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      status: json['status'] == "true",
      message: json['message'] ?? '',
    );
  }
}
