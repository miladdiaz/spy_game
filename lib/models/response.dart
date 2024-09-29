class Response {
  final String? message;
  final bool success;

  Response({this.message, this.success = false});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      message: json['message'],
      success: json['success'],
    );
  }
}
