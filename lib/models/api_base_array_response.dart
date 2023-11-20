class ArrayResponse<T> {
  bool status;
  String message;
  List<T> data;

  ArrayResponse(
      {required this.status, required this.message, required this.data});

  factory ArrayResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJson) {
    return ArrayResponse<T>(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => fromJson(i)).toList()
          : [],
    );
  }
}
