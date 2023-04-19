/// Given a sorted array of integers, write a function called search,
/// that accepts a value and returns the index where the value passed to
/// the function is located.If the value is not found, return -1.
///
/// search([1, 2, 3, 4, 5, 6], 4); // 3
/// search([1, 2, 3, 4, 5, 6], 6); // 5
/// search([1, 2, 3, 4, 5, 6], 11); // -1
///
/// Time: O(log n)

void main() {
  print(search([1, 2, 3, 4, 4, 4, 7, 7, 12, 12, 13], 4));
}

// Input: sorted array of numbers + search value
// Output: index of the value
search(List<int> numbers, int value) {
  int min = 0;
  int max = numbers.length - 1;

  while (min <= max) {
    final int middle = ((min + max) / 2).floor();
    final int middleElement = numbers[middle];

    if (middleElement < value) {
      min = middle + 1;
    }
    else if (middleElement > value) {
      max = middle - 1;
    }
    else {
      return middle;
    }
  }

  return -1;
}
