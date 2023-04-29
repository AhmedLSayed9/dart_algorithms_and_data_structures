import '../utils/list_extension.dart';

/// Pseudocode:
/// - Store the first element as the smallest value you've seen so far.
/// - Compare this item to the next item in the array until you find a smaller number.
/// - If a smaller number is found, designate that smaller number to be the new "minimum"
///   and continue until the end of the array.
/// - If the "minimum" is not the value (index) you initially began with, swap the two values.
/// - Repeat this with the next element until the array is sorted.
///
/// Time Complexity: Best O(n²) - Worst O(n²) - Average O(n²)
/// Auxiliary Space: O(1)

void main() {
  print(selectionSort([8, 4, 5, 10, 9]));
}

List<int> selectionSort(List<int> arr) {
  for (int i = 0; i < arr.length; i++) {
    int smallestIndex = i;
    for (int j = i + 1; j < arr.length; j++) {
      if (arr[j] < arr[smallestIndex]) smallestIndex = j;
    }
    if (i != smallestIndex) arr.swap(i, smallestIndex);
  }

  return arr;
}
