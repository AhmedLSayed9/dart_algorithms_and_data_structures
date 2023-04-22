import 'dart:math' as math;

/// Write a function called findLongestSubstring, which accepts a string
/// and returns the length of the longest substring with all distinct characters.
///
/// findLongestSubstring('') // 0
/// findLongestSubstring('rithmschool') // 7
/// findLongestSubstring('thisisawesome') // 6
/// findLongestSubstring('thecatinthehat') // 7
/// findLongestSubstring('bbbbbb') // 1
/// findLongestSubstring('longestsubstring') // 8
/// findLongestSubstring('thisishowwedoit') // 6
///
/// Solution MUST have AT LEAST the following complexities: Time: O(n)

void main() {
  print(findLongestSubstring('thisishowwedoit'));
}

// Input: String
// Output: length of longest substring with all distinct characters
findLongestSubstring(String str) {
  // Declare a variable to store the start index of current window (substring)
  int start = 0;
  // Declare a variable to store the longest substring length
  int longestSub = 0;
  // Declare a map to store each char and its last seen index
  final Map<String, int> lastSeen = {};

  // Iterate over the string:
  // If current char has seen before and its seenIndex is >= the start of current window
  // then move the start to that seenIndex + 1.
  // then re-calculate the longestSub.
  // Eventually, update the lastSeen index of the current char to current index and keep going.
  for (int i = 0; i < str.length; i++) {
    final char = str[i];
    final charLastSeen = lastSeen[char];

    if (charLastSeen != null && charLastSeen >= start) {
      start = charLastSeen + 1;
    }

    final currentSubLength = i - start + 1;
    longestSub = math.max(longestSub, currentSubLength);
    lastSeen[char] = i;
  }

  return longestSub;
}