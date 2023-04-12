import '../utils/time_measure.dart';

void main() {
  syncExecTimeMeasure(() => addUpTo(1000000000), name: 'addUpTo');
  syncExecTimeMeasure(() => addUpTo2(1000000000), name: 'addUpTo2');
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
