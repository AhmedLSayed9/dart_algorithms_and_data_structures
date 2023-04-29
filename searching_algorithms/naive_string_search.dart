/// Pseudocode:
/// Loop over the longer string
/// Loop over the shorter string
/// If the characters don't match, break out of the inner loop
/// If the characters do match, keep going
/// If you complete the inner loop and find a match, increment the count of matches
/// Return the count
///
/// Time Complexity: O(n²) “O(nm)”
/// Auxiliary Space: O(1)

void main() {
  print(naiveSearch('wowomgzomg', 'omg'));
}

int naiveSearch(String long, String short) {
  int totalCount = 0;

  for (int i = 0; i < long.length; i++) {
    for (int j = 0; j < short.length; j++) {
      if (i + j == long.length || short[j] != long[i + j]) break;
      if (j == short.length - 1) totalCount++;
    }
  }

  return totalCount;
}
