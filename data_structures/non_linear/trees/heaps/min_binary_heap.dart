import 'package:test/test.dart';

import '../../../../utils/list_extension.dart';

class MinBinaryHeap {
  final List<num> _heap = [];

  /// Pseudocode:
  /// - Push the value into the values property on the heap.
  /// - Sift-Up:
  ///   - Create a variable called index which is the length of the values property - 1.
  ///   - Create a variable called parentIndex which is the floor of (index-1)/2.
  ///   - Keep looping as long as the element at the parentIndex is smaller than the element at the child index:
  ///     - Swap the value of the values element at the parentIndex with the value
  ///       of the element property at the child index.
  ///     - Set the index to be the parentIndex, and start over.
  void insert(num value) {
    _heap.add(value);
    _siftUp();
  }

  _siftUp() {
    int childIndex = _heap.length - 1;

    while (childIndex > 0) {
      final parentIndex = (childIndex - 1) ~/ 2;
      if (_heap[childIndex] >= _heap[parentIndex]) break;

      _heap.swap(childIndex, parentIndex);
      childIndex = parentIndex;
    }
  }

  /// Pseudocode:
  /// - Swap the first value in the values property with the last one.
  /// - Pop from the values property, so you can return the value at the end.
  /// - Sift-Down:
  ///   - Your parent index starts at 0 (the root).
  ///   - Find the index of the left child: 2*index + 1 (make sure its not out of bounds).
  ///   - Find the index of the right child: 2*index + 2 (make sure its not out of bounds).
  ///   - If the left or right child is less than the element...swap.
  ///   - If both left and right children are smaller, swap with the smaller child.
  ///   - The child index you swapped to now becomes the new parent index.
  ///   - Keep looping and swapping until neither child is smaller than the element.
  ///   - Return the old root.
  num? extract() {
    if (_heap.isEmpty) return null;

    _heap.swap(0, _heap.length - 1);
    final oldRoot = _heap.removeLast();
    _siftDown();
    return oldRoot;
  }

  _siftDown() {
    int parentIndex = 0;

    while (true) {
      final leftChildIndex = parentIndex * 2 + 1;
      final rightChildIndex = leftChildIndex + 1;

      if (leftChildIndex >= _heap.length) break;

      final maxChildIndex = rightChildIndex < _heap.length &&
              _heap[rightChildIndex] < _heap[leftChildIndex]
          ? rightChildIndex
          : leftChildIndex;

      if (_heap[maxChildIndex] >= _heap[parentIndex]) break;

      _heap.swap(parentIndex, maxChildIndex);
      parentIndex = maxChildIndex;
    }
  }
}

void main() {
  group('insert', () {
    test('should insert items and sift-up to the correct spot', () {
      final heap = MinBinaryHeap();
      //        6
      //   12        15
      // 18  16   20
      heap._heap.addAll([6, 12, 15, 18, 16, 20]);

      //            3
      //       4         6
      //    10   16    20   15
      //  18  12
      heap.insert(4);
      heap.insert(10);
      heap.insert(3);

      expect(heap._heap, [3, 4, 6, 10, 16, 20, 15, 18, 12]);
    });
  });

  group('extract', () {
    test('should extract last item and sift-down', () {
      final heap = MinBinaryHeap();
      //        6
      //   12        15
      // 18  16   20
      heap._heap.addAll([6, 12, 15, 18, 16, 20]);

      //        12
      //   16        15
      // 18  20
      expect(heap.extract(), 6);
      expect(heap._heap, [12, 16, 15, 18, 20]);
    });

    test('should return null if the heap is empty', () {
      final heap = MinBinaryHeap();

      expect(heap.extract(), isNull);
    });
  });
}
