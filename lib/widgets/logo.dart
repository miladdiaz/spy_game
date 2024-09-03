import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/spy.png"),
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          width: 8.0,
          color: Colors.white.withOpacity(0.3),
        ),
        color: Colors.white.withOpacity(0.1),
      ),
    );
  }
}
