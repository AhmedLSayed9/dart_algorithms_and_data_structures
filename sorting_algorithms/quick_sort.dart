import '../utils/list_extension.dart';

/// Pseudocode:
/// - Call the pivot helper on the array.
/// - When the helper returns to you the updated pivot index, recursively call the pivot helper
///   on the sub-array to the left of that index, and the sub-array to the right of that index.
/// - Your base case occurs when you consider a sub-array with less than 2 elements.
///
/// Time Complexity: Best O(n log n) - Worst O(n²) - Average O(n log n)
/// Auxiliary Space: O(log n)

void main() {
  print(quickSort([4, 6, 9, 1, 2, 5, 3, -3, 0, -1]));
}

List<int> quickSort(List<int> arr, [int start = 0, int? end]) {
  end ??= arr.length - 1;
  // If sub-array has 0 or 1 items then return (the base case)
  if (end <= start) return arr;

  final pivotIndex = pivot(arr, start, end);
  //left
  quickSort(arr, start, pivotIndex - 1);
  //right
  quickSort(arr, pivotIndex + 1, end);

  return arr;
}

/// Pivot Pseudocode:
/// - It will help to accept three arguments: an array, a start index,
///   and an end index (these will be needed to recursively call pivot on the same array).
/// - Grab the pivot from the start of the array.
/// - Store the current pivot index in a variable (this will keep track of where the pivot should end up).
/// - Loop through the array from the start until the end:
///   - If the pivot is greater than the current element, increment the pivot index
///     variable and then swap the current element with the element at the pivot index.
/// - Swap the starting element (i.e. the pivot) with the pivot index.
/// - Return the pivot index.
///
/// The helper should do this in place, that is, it should not create a new array.
///
/// i.e: [ 5, 2, 1, 8, 4, 7, 6, 3 ] => 4
int pivot(List<int> arr, int start, int end) {
  final int pivot = arr[start];
  int pivotIndex = start;

  for (int i = start + 1; i <= end; i++) {
    if (arr[i] < pivot) {
      arr.swap(i, ++pivotIndex);
    }
  }
  arr.swap(start, pivotIndex);

  return pivotIndex;
}
