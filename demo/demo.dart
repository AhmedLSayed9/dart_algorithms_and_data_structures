import 'dart:async';

void main() {
  measureExecTime(() => addUpTo(1000000000), name: 'addUpTo');
  measureExecTime(() => addUpTo2(1000000000), name: 'addUpTo2');
}

double addUpTo(int n) {
  double total = 0;
  for (int i = 1; i <= n; i++) {
    total += i;
  }
  return total;
}

double addUpTo2(int n) {
  return n * (n + 1) / 2;
}

Future<T> measureExecTime<T>(
  FutureOr<T> Function() function, {
  String name = "",
}) async {
  final stopWatch = Stopwatch()..start();
  final result = await function();
  stopWatch.stop();
  print('$name execution time: ${stopWatch.elapsed}');
  return result;
}
