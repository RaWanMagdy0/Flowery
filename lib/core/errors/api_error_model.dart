class ApiErrorModel {
  int? statusCode;
  String? message;

  ApiErrorModel({
    this.statusCode,
    required this.message,
  });
}
