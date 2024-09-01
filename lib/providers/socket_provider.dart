import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:spy_game/env.dart';
import 'package:spy_game/models/game.dart';
import 'package:spy_game/models/player.dart';
import 'package:spy_game/models/web_socket.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:spy_game/providers/game_provider.dart';

class SocketProvider extends Notifier<WebSocket> {
  io.Socket? socket;

  @override
  WebSocket build() {
    return const WebSocket();
  }

  void start(String token) {
    state = state.copyWith(isLoading: true);

    socket = io.io(
      isHttps ? "https://$backendUrl" : "http://$backendUrl",
      OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNewConnection()
          .build(),
    );

    socket?.onConnect((_) {
      socket?.emit('joinGame', {'token': token});
    });

    socket?.on('error', (data) {
      socket?.disconnect();
      state = state.copyWith(
          isLoading: false, message: data, status: WebSocketStatus.error);
    });

    socket?.on('connect_error', (data) {
      state = state.copyWith(
          isLoading: false, message: data, status: WebSocketStatus.error);
    });

    socket?.on('event', (data) {
      if (data == "Game not found") {
        state = state.copyWith(isLoading: false, message: "Game not found");
        socket?.disconnect();
      } else {
        state = state.copyWith(
          isLoading: false,
          status: WebSocketStatus.connected,
        );

        List<Player> p = List.from(
          data['players'].map(
            (e) => const Player(name: "player", role: "player"),
          ),
        );

        GameStatus status = GameStatus.idle;

        if (data['status'] == "waiting") {
          status = GameStatus.waiting;
        } else if (data['status'] == "timer") {
          status = GameStatus.timer;
        } else if (data['status'] == "finished") {
          status = GameStatus.finished;
        }

        ref.read(gameNotifierProvider.notifier).setProperty(
            creatorDeviceId: data['creatorDeviceId'],
            token: data['token'],
            players: p,
            status: status);
      }
    });
  }

  void disconnect() {
    socket?.disconnect();
    socket?.destroy();
    state = state.copyWith(status: WebSocketStatus.disconnected);
  }

  startGame(String token) {
    socket?.emit('startGame', {'token': token});
  }
}

final socketNotifierProvider = NotifierProvider<SocketProvider, WebSocket>(() {
  return SocketProvider();
});
