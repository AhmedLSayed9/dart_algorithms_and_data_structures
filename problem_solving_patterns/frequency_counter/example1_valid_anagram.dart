import 'package:characters/characters.dart';

import '../../utils/time_measure.dart';

/// Given two strings, write a function called validAnagram to determine if the second
/// string is an anagram of the first. An anagram is a word, phrase, or name formed
/// by rearranging the letters of another, such as cinema, formed from iceman.
///
/// Note: You may assume the string contains only lowercase alphabets.
///
/// validAnagram('', ''); // true
/// validAnagram('aaz', 'zza'); // false
/// validAnagram('anagram', 'nagaram'); // true
///
/// Solution MUST have AT LEAST the following complexities: Time: O(n) / Space: O(n)

void main() {
  final String s1 = 'some' * 10000;
  final String s2 = 'some' * 10000;
  syncExecTimeMeasure(() => isValidAnagram(s1, s2), name: 'O(n)');
  syncExecTimeMeasure(() => naiveSolution(s1, s2), name: 'O(n^2)');
}

// Input: 2 strings
// Output: bool
bool isValidAnagram(String first, String second) {
  // If both strings have different length, return false immediately.
  if (first.length != second.length) return false;

  // Create Map<String,int> to store each char and its count.
  final Map<String, int> freqCount = {};

  // Loop through first string, and store each char in a Map<String,int> where the key
  // is the char and the value is the count.
  for (final char in first.characters) {
    freqCount[char] = freqCount[char] == null ? 1 : freqCount[char]! + 1;
  }

  // Loop through second string, If can't find a letter at freqCount return false,
  // or else decrease the count of that letter.
  for (final char in second.characters) {
    final charCount = freqCount[char];

    if (charCount == null || charCount == 0) {
      return false;
    } else {
      freqCount[char] = charCount - 1;
    }
  }

  // Return true eventually.
  return true;
}

// Naive Solution
bool naiveSolution(String first, String second) {
  if (first.length != second.length) return false;

  final secondChars = second.split('');
  for (final char in first.characters) {
    final indexAtSecond = secondChars.indexOf(char);
    if (indexAtSecond == -1) return false;
    secondChars.removeAt(indexAtSecond);
  }
  return true;
}
