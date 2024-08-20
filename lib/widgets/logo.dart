import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          width: 8.0,
          color: Colors.white.withOpacity(0.3),
        ),
        color: Colors.white.withOpacity(0.1),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SPY',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Permanent Marker",
              ),
            ),
            Text(
              'Party Game',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white.withOpacity(0.8),
                fontFamily: "Permanent Marker",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
