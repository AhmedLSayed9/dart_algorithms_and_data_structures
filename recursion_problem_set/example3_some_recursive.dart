/// Write a recursive function called someRecursive which accepts an array and a callback.
/// The function returns true if a single value in the array returns true when passed to the callback.
/// Otherwise it returns false.
///
/// someRecursive([1,2,3,4], isOdd) // true
/// someRecursive([4,6,8,9], isOdd) // true
/// someRecursive([4,6,8], isOdd) // false
/// someRecursive([4,6,8], val => val > 10); // false

void main() {
  print(someRecursive([4, 6, 8], isOdd));
  print(someRecursive(['a', 'b', 'c'], (String val) => val == 'c'));
}

bool isOdd(int val) => val % 2 != 0;

// Input: array and a callback
// Output: bool, if a single value in the array returns true when passed to the callback
bool someRecursive<T>(List<T> arr, bool Function(T val) callBack) {
  // If list is empty return false (the base case)
  if (arr.isEmpty) return false;

  // Test last value of arr at the callBack:
  // If it returns true then someRecursive should return true
  // Or else return someRecursive of arr excluding last value
  if (callBack(arr.last)) return true;
  return someRecursive(arr..removeLast(), callBack);
}
