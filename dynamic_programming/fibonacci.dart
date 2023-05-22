import '../utils/time_measure.dart';

/// Calculate fibonacci number at specific position "n" using Dynamic Programming approach.
/// Fibonacci Sequence:
/// 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144
void main() {
  syncExecTimeMeasure(() => print(fibTabulated(45)), name: 'O(n)');
  syncExecTimeMeasure(() => print(fibMemoized(45)), name: 'O(n)');
  syncExecTimeMeasure(() => print(fibRecursive(45)), name: 'O(n^2)');
}

// Tabulation (Bottom-up approach in Dynamic Programming) (usually done using iteration).
// Time Complexity: O(n), and better Auxiliary Space.
fibTabulated(int n) {
  if (n <= 0) throw ArgumentError('Input must be a positive integer');

  final table = [1, 1];
  int currentFib = 1;

  for (int i = 3; i <= n; i++) {
    currentFib = table[0] + table[1];
    table[0] = table[1];
    table[1] = currentFib;
  }
  return currentFib;
}

// Memoization (Top-down approach in Dynamic Programming) (involves recursion).
// Time Complexity: O(n)
fibMemoized(int n) {
  if (n <= 0) throw ArgumentError('Input must be a positive integer');
  if (n <= 2) return 1;
  if (_memo.containsKey(n)) return _memo[n];

  final result = fibMemoized(n - 1) + fibMemoized(n - 2);
  _memo[n] = result;
  return result;
}

final Map<int, int> _memo = {};

// Naive solution using Recursion.
// Time Complexity: O(2^n) "Exponential Big O"
// https://i.stack.imgur.com/kgXDS.png
// Note: it's exactly (1.6180339887^n), which is known as the golden ratio:
// https://stackoverflow.com/questions/360748
fibRecursive(int n) {
  if (n <= 0) throw ArgumentError('Input must be a positive integer');
  if (n <= 2) return 1;

  return fibRecursive(n - 1) + fibRecursive(n - 2);
}
