import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/providers/game_provider.dart';
import 'package:spy_game/widgets/button.dart';

class JoinGameContainer extends ConsumerStatefulWidget {
  const JoinGameContainer({super.key});

  @override
  JoinGameContainerState createState() => JoinGameContainerState();
}

class JoinGameContainerState extends ConsumerState<JoinGameContainer> {
  final TextEditingController tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gameNotifier = ref.read(gameNotifierProvider.notifier);

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          TextField(
            controller: tokenController,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Enter token',
              labelStyle: const TextStyle(color: Colors.white),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              filled: true,
              fillColor: Colors.black.withOpacity(0.5),
            ),
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          Button(
            color: Colors.green,
            label: 'Join a game',
            onPressed: () {
              gameNotifier.joinGame(tokenController.text);
              Navigator.pushNamed(context, '/play');
            },
          ),
        ],
      ),
    );
  }
}
