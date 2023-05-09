/// KMP algorithm offers an improvement over the naive approach.
/// It provides a linear time algorithm for searches in strings
///
/// Time Complexity: O(n) “O(n+m)”
/// Auxiliary Space: O(m)

void main() {
  print(kmpSearch('wowomgzomg', 'omg'));
}

int kmpSearch(String long,String short) {
  final List<int> table = matchTable(short);
  int shortPointer = 0;
  int longPointer = 0;
  int count = 0;
  while (longPointer < long.length - short.length + shortPointer + 1) {
    if (short[shortPointer] != long[longPointer]) {
      // we found a mismatch :(
      // if we just started searching the short, move the long pointer
      // otherwise, move the short pointer to the end of the next potential prefix
      // that will lead to a match
      if (shortPointer == 0) {
        longPointer += 1;
      } else {
        shortPointer = table[shortPointer - 1];
      }
    } else {
      // we found a match! shift both pointers
      shortPointer += 1;
      longPointer += 1;
      // then check to see if we've found the substring in the large string
      if (shortPointer == short.length) {
        // we found a substring! increment the count
        // then move the short pointer to the end of the next potential prefix
        count++;
        shortPointer = table[shortPointer - 1];
      }
    }
  }
  return count;
}

List<int> matchTable(String word) {
  final List<int> arr = List.generate(word.length, (index) => 0);
  int suffixEnd = 1;
  int prefixEnd = 0;
  while (suffixEnd < word.length) {
    if (word[suffixEnd] == word[prefixEnd]) {
      // we can build a longer prefix based on this suffix
      // store the length of this longest prefix
      // move prefixEnd and suffixEnd
      prefixEnd += 1;
      arr[suffixEnd] = prefixEnd;
      suffixEnd += 1;
    } else if (word[suffixEnd] != word[prefixEnd] && prefixEnd != 0) {
      // there's a mismatch, so we can't build a larger prefix
      // move the prefixEnd to the position of the next largest prefix
      prefixEnd = arr[prefixEnd - 1];
    } else {
      // we can't build a proper prefix with any of the proper suffixes
      // let's move on
      arr[suffixEnd] = 0;
      suffixEnd += 1;
    }
  }
  return arr;
}