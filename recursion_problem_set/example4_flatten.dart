/// Write a recursive function called flatten which accepts an array of array
/// and returns a new array with all values flattened.
///
/// flatten([1, 2, 3, [4, 5] ]) // [1, 2, 3, 4, 5]
/// flatten([1, [2, [3, 4], [[5]]]]) // [1, 2, 3, 4, 5]
/// flatten([[1],[2],[3]]) // [1,2,3]
/// flatten([[[[1], [[[2]]], [[[[[[[3]]]]]]]]]]) // [1,2,3]

void main() {
  print(flatten([
    1,
    [
      2,
      [3, 4],
      [
        [5]
      ]
    ]
  ]));
}

// Input: an array of array
// Output: new array with all values flattened
List<dynamic> flatten(List<dynamic> arr) {
  // If arr is empty return it (the base case)
  if (arr.isEmpty) return arr;

  // Start from last item:
  // if it's a list: return flatten of arr excluding last item + flatten of last item (as it's a list)
  // or else, return flatten of arr excluding last item + last item
  final newArray = arr.sublist(0, arr.length - 1);
  if (arr.last is List) {
    return [...flatten(newArray), ...flatten(arr.last)];
  }
  return [...flatten(newArray), arr.last];
}
