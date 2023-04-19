import 'package:characters/characters.dart';

/// Write a function called isSubsequence which takes in two strings and checks
/// whether the characters in the first string form a subsequence of the characters
/// in the second string. In other words, the function should check whether the characters
/// in the first string appear somewhere in the second string, without their order changing.
///
/// isSubsequence('hello', 'hello world'); // true
/// isSubsequence('sing', 'sting'); // true
/// isSubsequence('abc', 'abracadabra'); // true
/// isSubsequence('abc', 'acb'); // false (order matters)
///
/// Solution MUST have AT LEAST the following complexities: Time: O(n + m) / Space: O(1)

void main() {
  print(isSubsequence('hello', 'hello world'));
}

// Input: 2 strings
// Output: bool, whether chars in first String form a subsequence of chars in second string
bool isSubsequence(String first, String second) {
  if (first.isEmpty) return true;

  // Declare a pointer that point to the current lookup char of first string
  int pointer = 0;

  // Iterate over second string:
  // If current char equals to pointer's char, update pointer's char to next char.
  // If pointer's char is last one, return true. or else keep going.
  for (final char in second.characters) {
    if (char == first[pointer]) {
      if (pointer == first.length - 1) return true;
      pointer++;
    }
  }

  // Return false as we haven't reached last char of first string
  return false;
}
