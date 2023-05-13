extension ListX<T> on List<T> {
  void swap(int a, int b) {
    final temp = this[a];
    this[a] = this[b];
    this[b] = temp;
  }
}