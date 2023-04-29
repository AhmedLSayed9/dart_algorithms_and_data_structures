/// Write a function called binarySearch which accepts a sorted array and a value
/// and returns the index at which the value exists. Otherwise, return -1.
///
/// binarySearch([1,2,3,4,5],2) // 1
/// binarySearch([1,2,3,4,5],3) // 2
/// binarySearch([1,2,3,4,5],5) // 4
/// binarySearch([1,2,3,4,5],6) // -1
/// binarySearch([
///   5, 6, 10, 13, 14, 18, 30, 34, 35, 37,
///   40, 44, 64, 79, 84, 86, 95, 96, 98, 99
/// ], 10) // 2
/// binarySearch([
///   5, 6, 10, 13, 14, 18, 30, 34, 35, 37,
//   40, 44, 64, 79, 84, 86, 95, 96, 98, 99
/// ], 95) // 16
/// binarySearch([
///   5, 6, 10, 13, 14, 18, 30, 34, 35, 37,
///   40, 44, 64, 79, 84, 86, 95, 96, 98, 99
/// ], 100) // -1
///
/// Time Complexity: Best O(1) - Worst O(log n) - Average O(log n)
/// Auxiliary Space: O(1)

void main() {
  print(binarySearch([1, 2, 3, 4, 5], 5));
}

// Input: a sorted array and a value
// Output: the index at which the value exists, or -1 if not found
int binarySearch(List<int> arr, int val) {
  // Declare the left,right variables to first and last items
  int left = 0;
  int right = arr.length - 1;

  // While left is <= right:
  // Get the middle point between left and right.
  // If the value is greater than the middle item set left to the middle + 1.
  // If the value is less than the middle item set right to the middle - 1.
  // or else, that means the middle item is the wanted value, then return its index.
  while (left <= right) {
    final int middle = ((right + left) / 2).floor();
    final int middleItem = arr[middle];

    if (val > middleItem) {
      left = middle + 1;
    } else if (val < middleItem) {
      right = middle - 1;
    } else {
      return middle;
    }
  }

  // Eventually, return -1 if the value is not found
  return -1;
}
