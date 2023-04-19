import 'package:characters/characters.dart';

/// Write a function called sameFrequency. Given two positive integers,
/// find out if the two numbers have the same frequency of digits.
///
/// sameFrequency(182,281) // true
/// sameFrequency(34,14) // false
/// sameFrequency(3589578, 5879385) // true
/// sameFrequency(22,222) // false
///
/// Solution MUST have AT LEAST the following complexities: Time: O(n)

void main() {
  print(sameFrequency(182, 281));
}

// Input: 2 positive integers
// Output: bool, whether they have same frequency of digits
sameFrequency(int num1, int num2) {
  // Convert both numbers to strings
  final String n1 = num1.toString();
  final String n2 = num2.toString();

  // If they don't have the same length, return false immediately.
  if (n1.length != n2.length) return false;

  // Declare a map that store each number and its count
  final Map<String, int> freqCount = {};

  // Iterate over first string, and store each char and its count in the map
  for (final char in n1.characters) {
    freqCount[char] =
        freqCount[char] == null ? 1 : freqCount[char]! + 1;
  }

  // Iterate over second string, and check if that char has no count in the map
  // then return false, or else decrease its count
  for (final char in n2.characters) {
    final currentCount = freqCount[char];

    if (currentCount == null || currentCount == 0) return false;

    freqCount[char] = currentCount - 1;
  }

  // Return true as both have same digits
  return true;
}
