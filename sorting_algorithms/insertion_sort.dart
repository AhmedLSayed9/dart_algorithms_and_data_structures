/// Pseudocode:
/// - Start by picking the second element in the array.
/// - Now compare the second element with the one before it and swap if necessary.
/// - Continue to the next element and if it is in the incorrect order, iterate
///   through the sorted portion (i.e. the left side) to place the element in the correct place.
/// - Repeat until the array is sorted.
///
/// Time Complexity: Best O(n) - Worst O(n²) - Average O(n²)
/// Auxiliary Space: O(1)

void main() {
  print(insertionSort([5, 3, 4, 1, 2]));
}

List<int> insertionSort(List<int> arr) {
  for (int i = 1; i < arr.length; i++) {
    final currentValue = arr[i];
    int j = i - 1;
    for (; j >= 0 && arr[j] > currentValue; j--) {
      arr[j + 1] = arr[j];
    }
    //j + 1 because at last iteration (j--) get executed before checking the condition
    arr[j + 1] = currentValue;
  }
  return arr;
}
