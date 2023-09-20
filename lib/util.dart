import 'dart:core';

String secondsToCustomString() {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/';
  final startDate = DateTime(2023, 9, 16, 16, 8);
  final now = DateTime.now();
  final duration = now.difference(startDate);
  final seconds = duration.inSeconds;

  final binaryString = seconds.toRadixString(2).padLeft(30, '0');

  // Définir un ordre de mélange déterministe pour les 30 bits
  const mixOrder = <int>[
    ...[4, 2, 28, 15, 9, 21, 7, 0, 19, 12, 26, 5, 17, 8, 23, 1, 29, 16, 11],
    ...[24, 3, 27, 14, 10, 25, 6, 18, 13, 22, 20],
  ];

  // Mélanger les bits
  final mixedBits =
      List.generate(30, (index) => binaryString[mixOrder[index]]).join();

  final binaryGroups = <int>[];
  for (var i = 0; i < mixedBits.length; i += 6) {
    final group = mixedBits.substring(i, i + 6);
    binaryGroups.add(int.parse(group, radix: 2));
  }

  final result = binaryGroups.map((group) => chars[group]).join();
  return result;
}
