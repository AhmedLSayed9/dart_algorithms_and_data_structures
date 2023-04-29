extension ListX<T> on List<T> {
  void swap(int a, int b) {
    final tmp = this[a];
    this[a] = this[b];
    this[b] = tmp;
  }
}