import 'dart:math' as math;

/// Write a function called minSubArrayLen which accepts two parameters:
/// an array of positive integers and a positive integer.
///
/// This function should return the minimal length of a contiguous sub-array of
/// which the sum is greater than or equal to the integer passed to the function.
/// If there isn’t one, return 0 instead.
///
/// minSubArrayLen([2, 3, 1, 2, 4, 3], 7); // 2 -> because [4, 3] is the smallest sub-array
/// minSubArrayLen([2, 1, 6, 5, 4], 9); // 2 -> because [5, 4] is the smallest sub-array
/// minSubArrayLen([3, 1, 62, 19], 52); // 1 -> because [62] is greater than 52
/// minSubArrayLen([1,4,16,22,5,7,8,9,10],39) // 3
/// minSubArrayLen([1,4,16,22,5,7,8,9,10],55) // 5
/// minSubArrayLen([4, 3, 3, 8, 1, 2, 3], 11) // 2
/// minSubArrayLen([1,4,16,22,5,7,8,9,10],95) // 0
///
/// Solution MUST have AT LEAST the following complexities: Time: O(n) / Space: O(1)

void main() {
  print(minSubArrayLen([1,4,16,22,5,7,8,9,10],39));
}

// Input: positive List<int> and a positive int (targetSum)
// Output: minimal length of a contiguous sub-array which sum is greater than or equal to the targetSum
num minSubArrayLen(List<int> numbers, int targetSum) {
  if (numbers.isEmpty) return 0;
  // Declare the start and end of the window starting from index 0
  int start = 0, end = 0;
  // Declare a variable to store sum of the current window starting with first value
  int sum = numbers[start];
  // Declare a variable to store the min length of a window that achieves the targetSum
  num minLength = double.infinity;

  // Iterate over the list while start doesn't exceed the end of the list:
  while (start < numbers.length) {
    // If current window's sum is less than targetSum, increase the window to the right.
    // or else, record the length of that window (if < minLength) then we can shrink the window from the left and retry.
    if (sum < targetSum) {
      // current sum less than targetSum but we reach the end (can't increase the window to the right)
      if (end == numbers.length - 1) break;

      end++;
      sum += numbers[end];
    } else {
      final currentLength = end - start + 1;
      minLength = math.min(minLength, currentLength);
      //If length equals 1 (min possible length), no need to complete.
      if (minLength == 1) break;

      sum -= numbers[start];
      start++;
    }
  }

  return minLength == double.infinity ? 0 : minLength;
}
