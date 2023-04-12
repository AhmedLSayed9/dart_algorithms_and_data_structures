import 'dart:async';

T syncExecTimeMeasure<T>(
  T Function() function, {
  String name = "",
}) {
  final stopWatch = Stopwatch()..start();
  final result = function();
  stopWatch.stop();
  print('$name execution time: ${stopWatch.elapsed}');
  return result;
}

Future<T> asyncExecTimeMeasure<T>(
  Future<T> Function() function, {
  String name = "",
}) async {
  final stopWatch = Stopwatch()..start();
  final result = await function();
  stopWatch.stop();
  print('$name execution time: ${stopWatch.elapsed}');
  return result;
}
