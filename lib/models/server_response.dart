class ServerResponse<T> {
  T? data;
  ServerResponseStatus status = ServerResponseStatus(type: '', message: '');

  ServerResponse({this.data, required this.status});

  ServerResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    status = ServerResponseStatus.fromJson(json['status']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['status'] = status.toJson();
    return map;
  }
}

class ServerResponseStatus {
  String type = '';
  String message = '';

  ServerResponseStatus({
    required this.type,
    required this.message,
  });

  ServerResponseStatus.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['type'] = type;
    map['message'] = message;
    return map;
  }
}
