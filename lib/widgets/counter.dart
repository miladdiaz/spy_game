import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final String? label;
  final int count;
  final int startFrom;
  final void Function(int value) onChange;

  const Counter({
    super.key,
    this.label,
    this.startFrom = 0,
    required this.count,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final playerCount = List.generate(count, (index) => (index + startFrom));

    return Column(
      children: [
        Text(
          label!,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width * 0.25,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CupertinoPicker(
              magnification: 1.3,
              squeeze: 1.2,
              itemExtent: 48,
              diameterRatio: 2.1,
              onSelectedItemChanged: (int index) {
                onChange(playerCount[index]);
              },
              children: playerCount
                  .map(
                    (e) => Align(
                      alignment: Alignment.center,
                      child: Text(
                        '$e',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
