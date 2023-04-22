/// Implement a function called countUniqueValues, which accepts a sorted array,
/// and counts the unique values in the array. There can be negative numbers in the array,
/// but it will always be sorted.
///
/// countUniqueValues([1,1,1,1,1,2]) // 2
/// countUniqueValues([1,2,3,4,4,4,7,7,12,12,13]) // 7
/// countUniqueValues([]) // 0
/// countUniqueValues([-2,-1,-1,0,1]) // 4
///
/// Solution MUST have AT LEAST the following complexities: Time: O(n) / Space: O(1)

void main() {
  print(countUniqueValues([1, 2, 3, 4, 4, 4, 7, 7, 12, 12, 13]));
}

// Input: sorted array of numbers
// Output: count of the unique values
int countUniqueValues(List<int> numbers) {
  // If the list is empty, return directly
  if (numbers.isEmpty) return 0;

  // Declare 2 pointers, one start from index 0 and the other from index 1
  int p1 = 0;

  // p2 is going to start from index 1 and compare its value with value at p1:
  // if they're equal, then p2 will keep going.
  // if they're different then:
  //   - p1 will move forward one step and put p2's value at that index.
  //   - then pointer2 will keep going.
  // The loop will stop if p2 is the last item
  for (int p2 = 1; p2 < numbers.length; p2++) {
    if (numbers[p1] != numbers[p2]) {
      numbers[++p1] = numbers[p2];
    }
  }

  // Return current p1 + 1 (the count of unique values)
  return p1 + 1;
}
