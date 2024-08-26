enum WebSocketStatus { connected, disconnected, error }

class WebSocket {
  final WebSocketStatus status;
  final String message;
  final String? token;
  final bool isLoading;

  const WebSocket({
    this.status = WebSocketStatus.disconnected,
    this.message = '',
    this.token,
    this.isLoading = false,
  });

  WebSocket copyWith({
    WebSocketStatus? status,
    String? message,
    String? token,
    bool? isLoading,
  }) {
    return WebSocket(
      status: status ?? this.status,
      message: message ?? this.message,
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
