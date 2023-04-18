import '../../utils/time_measure.dart';

/// Implement a function called, areThereDuplicates which accepts a variable number of arguments,
/// and checks whether there are any duplicates among the arguments passed in.
/// You can solve this using the frequency counter pattern OR the multiple pointers pattern.
///
/// areThereDuplicates(1, 2, 3); // false
/// areThereDuplicates(1, 2, 2); // true
/// areThereDuplicates('a', 'b', 'c', 'a'); // true
///
/// Solution MUST have the following complexities: Time: O(n) / Space: O(n)

void main() {
  final List<int> argsList = [];
  for (int i = 0; i < 100000; i++) {
    argsList.add(i);
  }
  syncExecTimeMeasure(() => areThereDuplicates(argsList),
      name: 'O(n) using map');
  syncExecTimeMeasure(() => usingSet(argsList), name: 'O(n) using set');
  syncExecTimeMeasure(() => usingList(argsList), name: 'O(n^2)');
}

//Input: variable number of arguments (var-args not supported in dart) / Output: bool, if any duplicates
bool areThereDuplicates([List<dynamic> args = const []]) {
  //Declare a map that store each argument and its count
  final Map<dynamic, int> freqCount = {};

  //Iterate over the list of arguments convert each arg to string then check:
  //If that argument already exists in that map, return true.
  //or else add it to the map.
  for (final arg in args) {
    if (freqCount[arg] != null) return true;
    freqCount[arg] = 1;
  }

  //Return false eventually
  return false;
}

//Using a set instead of a map is slightly faster (possible when we don't need counts)
bool usingSet([List<dynamic> args = const []]) {
  final Set<dynamic> lookup = {};

  for (final arg in args) {
    if (lookup.contains(arg)) return true;
    lookup.add(arg);
  }

  return false;
}

//Naive Solution
bool usingList([List<dynamic> args = const []]) {
  final List<dynamic> lookup = [];

  for (final arg in args) {
    if (lookup.contains(arg)) return true;
    lookup.add(arg);
  }

  return false;
}
