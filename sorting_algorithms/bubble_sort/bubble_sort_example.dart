import '../../utils/list_extension.dart';

/// Pseudocode:
/// Start looping with a variable called i from the end of the array towards the beginning.
/// Start an inner loop with a variable called j from the beginning until i - 1.
/// If arr[j] is greater than arr[j+1], swap those two values!
/// Return the sorted array
///
/// Time Complexity: Best O(n) - Worst O(n²) - Average O(n²)
/// Auxiliary Space: O(1)

void main() {
  print(bubbleSort([3, 4, 5, 10, 9]));
}

List<int> bubbleSort(List<int> arr) {
  bool swapped;
  for (int i = arr.length - 1; i >= 0; i--) {
    swapped = false;
    for (int j = 0; j < i; j++) {
      if (arr[j] > arr[j + 1]) {
        swapped = true;
        arr.swap(j, j + 1);
      }
    }
    // (Optimization) if no two elements were swapped by inner loop, then break.
    if (!swapped) break;
  }

  return arr;
}
