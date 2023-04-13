import 'dart:math' as math;

/// Write a function called maxSubArraySum which accepts an array of integers and a number called n.
/// The function should calculate the maximum sum of n consecutive elements in the array.
///
/// maxSubArraySum([1, 2, 5, 2, 8, 1, 5], 2); // 10
/// maxSubArraySum([1, 2, 5, 2, 8, 1, 5], 4); // 17
/// maxSubArraySum([4, 2, 1, 6], 1); // 6
/// maxSubArraySum([], 4); // null
///
/// Time: O(n) / Space: O(1)

void main() {
  print(maxSubArraySum([1, 2, 5, 2, 8, 1, 5], 4));
}

//Input: Array of integers + n / Output: Max sum of n consecutive elements
int? maxSubArraySum(List<int> numbersList, int n) {
  if (numbersList.length < n) return null;

  int maxSum = 0;
  int tempSum = 0;

  for (int i = 0; i < n; i++) {
    maxSum += numbersList[i];
  }

  tempSum = maxSum;
  for (int i = n; i < numbersList.length; i++) {
    tempSum = tempSum - numbersList[i - n] + numbersList[i];
    maxSum = math.max(maxSum, tempSum);
  }

  return maxSum;
}
