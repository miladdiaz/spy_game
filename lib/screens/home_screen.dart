import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/widgets/button.dart';
import 'package:spy_game/widgets/join_game_container.dart';
import 'package:spy_game/widgets/logo.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 30, 13, 63),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/dark_house.png"),
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Logo(),
                    const SizedBox(height: 16),
                    Button(
                      label: "Create new Game",
                      onPressed: () {
                        Navigator.pushNamed(context, '/multiDevice');
                      },
                    ),
                  ],
                ),
                const JoinGameContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
