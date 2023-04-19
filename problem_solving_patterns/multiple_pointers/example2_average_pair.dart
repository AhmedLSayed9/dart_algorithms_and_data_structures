/// Write a function called averagePair. Given a sorted array of integers and a target average,
/// determine if there is a pair of values in the array where the average of the pair equals
/// the target average. There may be more than one pair that matches the average target.
///
/// averagePair([1, 2, 3], 2.5); // true
/// averagePair([1, 3, 3, 5, 6, 7, 10, 12, 19], 8); // true
/// averagePair([-1, 0, 3, 4, 5, 6], 4.1); // false
/// averagePair([], 4); // false
///
/// Solution MUST have AT LEAST the following complexities: Time: O(n) / Space: O(1)

void main() {
  print(averagePair([1, 3, 3, 5, 6, 7, 10, 12, 19], 8));
}

// Input: sorted List<int> and target average
// Output: bool, if there is a pair where the average equals the target average
bool averagePair(List<int> numbers, double targetAverage) {
  int left = 0;
  int right = numbers.length - 1;

  while (left < right) {
    final average = (numbers[left] + numbers[right]) / 2;

    if (average == targetAverage) {
      return true;
    } else if (average < targetAverage) {
      left++;
    } else {
      right--;
    }
  }
  return false;
}
