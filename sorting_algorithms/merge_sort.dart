/// Pseudocode:
/// - Break up the array into halves until you have arrays that are empty or have one element.
/// - Once you have smaller sorted arrays, merge those arrays with other sorted
///   arrays until you are back at the full length of the array.
/// - Once the array has been merged back together, return the merged (and sorted!) array.
///
/// Time Complexity: Best O(n log n) - Worst O(n log n) - Average O(n log n)
/// Auxiliary Space: O(n)

void main() {
  print(mergeSort([1, 142, 10, 50, 2, 14, 3, 2, 100]));
}

List<int> mergeSort(List<int> arr) {
  // If arr has 0 or 1 items return it (the base case)
  if (arr.length <= 1) return arr;
  // define the middle item's index
  final int middle = ((arr.length - 1) / 2).floor();

  // declare the left half range from the start to middle
  // re-call mergeSort (recursive) (which will break if there's no more than 1 items)
  final List<int> left = mergeSort(arr.sublist(0, middle + 1));
  // declare the right half range from middle to the end
  // re-call mergeSort (recursive) (which will break if there's no more than 1 items)
  final List<int> right = mergeSort(arr.sublist(middle + 1));

  // return merge(left, right) as both halves should be sorted
  return merge(left, right);
}

/// Merging Sorted Arrays Pseudocode:
/// - Create an empty array, take a look at the smallest values in each input array.
/// - While there are still values we haven't looked at:
///   - If the value in the first array is smaller than the value in the second array,
///   push the value in the first array into our results and move on to the next value in the first array.
///   - If the value in the first array is larger than the value in the second array,
///   push the value in the second array into our results and move on to the next value in the second array.
///   - Once we exhaust one array, push in all remaining values from the other array.
///
/// This function should run in O(n + m) time and O(n + m) space and should not modify the parameters passed to it.
///
/// i.e: [1, 10, 50] [2, 14, 99, 100] => [1, 2, 10, 14, 50, 99, 100]
List<int> merge(List<int> arr1, List<int> arr2) {
  final List<int> result = [];
  int p1 = 0;
  int p2 = 0;

  while (p1 < arr1.length && p2 < arr2.length) {
    arr1[p1] <= arr2[p2] ? result.add(arr1[p1++]) : result.add(arr2[p2++]);
  }

  if (p1 < arr1.length) {
    result.addAll(arr1.getRange(p1, arr1.length));
  } else if (p2 < arr2.length) {
    result.addAll(arr2.getRange(p2, arr2.length));
  }

  return result;
}
