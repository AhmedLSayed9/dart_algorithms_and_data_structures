/// Given a sorted array of integers, write a function called search,
/// that accepts a value and returns the index where the value passed to
/// the function is located.If the value is not found, return -1.
///
/// search([1, 2, 3, 4, 5, 6], 4); // 3
/// search([1, 2, 3, 4, 5, 6], 6); // 5
/// search([1, 2, 3, 4, 5, 6], 11); // -1
///
/// Solution MUST have AT LEAST the following complexities: Time: O(log n)

void main() {
  print(search([1, 2, 3, 4, 4, 4, 7, 7, 12, 12, 13], 4));
}

// Input: sorted array of numbers + search value
// Output: index of the value
search(List<int> numbers, int value) {
  int left = 0;
  int right = numbers.length - 1;

  while (left <= right) {
    final int middle = ((left + right) / 2).floor();
    final int middleItem = numbers[middle];

    if (value > middleItem) {
      left = middle + 1;
    } else if (value < middleItem) {
      right = middle - 1;
    } else {
      return middle;
    }
  }

  return -1;
}
