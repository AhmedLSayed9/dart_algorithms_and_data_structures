import 'dart:math';
import 'package:collection/collection.dart';

import '../utils/log_base.dart';

/// Pseudocode:
/// - Define a function that accepts list of numbers.
/// - Figure out how many digits the largest number has.
/// - Loop from k = 0 up to this largest number of digits.
/// - For each iteration of the loop:
///   - Create buckets for each digit (0 to 9)
///   - place each number in the corresponding bucket based on its kth digit
/// - Replace our existing array with values in our buckets, starting with 0 and going up to 9
/// - return list at the end!
///
/// Time Complexity: Best O(nk) - Worst O(nk) - Average O(nk)
/// Auxiliary Space: O(n+k)

void main() {
  print(radixSort([23, 345, 5467, 12, 2345, 9852]));
}

List<int> radixSort(List<int> arr) {
  // Find max digits in a number in our list
  final maxDigits = _getMaxDigits(arr);

  // Loop from 0 to maxDigits - 1
  for (int i = 0; i < maxDigits; i++) {
    // Define a list (bucket) for each digit (0 to 9)
    final List<List<int>> digitBuckets = List.generate(10, (index) => []);

    // Place each number in the correct bucket based on its digit at i index
    for (final num in arr) {
      final digit = _getDigitAtIndex(num, i);
      digitBuckets[digit].add(num);
    }

    // Concatenate these buckets and replace our existing array with it
    arr = digitBuckets.flattened.toList();
  }

  return arr;
}

/// returns the digit in num at the given place value.
/// i.e: _getDigitAtIndex(12345, 1) => 4
int _getDigitAtIndex(int num, int digitIndex) {
  return num.abs() ~/ pow(10, digitIndex) % 10;
}

/// returns the number of digits in num
int _getDigitsCount(int num) {
  if (num == 0) return 1;
  return log10(num.abs()).truncate() + 1;
}

/// Given an array of numbers, returns the number of digits in the largest number in the list
int _getMaxDigits(List<int> arr) {
  int maxDigits = 0;
  for (final num in arr) {
    maxDigits = max(maxDigits, _getDigitsCount(num));
  }
  return maxDigits;
}
