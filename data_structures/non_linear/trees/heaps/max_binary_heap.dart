import 'package:test/test.dart';

import '../../../../utils/list_extension.dart';

class MaxBinaryHeap {
  MaxBinaryHeap() : _heap = [];

  MaxBinaryHeap.buildFromArray(this._heap) {
    _heapify();
  }

  final List<num> _heap;

  /// Heapify describes the act of taking an existing, unordered array, and transforming it into a Heap structure.
  /// What makes this process intriguing, is that if implemented well, it can be done in place, meaning O(1) space,
  /// and in linear O(n) time versus the expected O(n log n) time "The naive iterate & insert approach".
  ///
  /// The reason why the _heapify() method starts at i = (_heap.length ~/ 2) - 1
  /// is because this is the index of the last non-leaf node in the heap.
  /// Starting from the last non-leaf node, sift it down and working backwards ensures
  /// that each node in the heap is visited exactly once during the heapify process.
  ///
  /// Iterate over the array and insert VS overriding the heap array and calling siftDown()
  /// for each non-leaf node: https://gist.github.com/AhmedLSayed9/968ba2811252f9bb135f4bd8db311ae1
  void _heapify() {
    final startingParent = (_heap.length ~/ 2) - 1;
    for (int i = startingParent; i >= 0; i--) {
      _siftDown(i);
    }
  }

  /// Pseudocode:
  /// - Push the value into the values property on the heap.
  /// - Sift-Up:
  ///   - Create a variable called index which is the length of the values property - 1.
  ///   - Create a variable called parentIndex which is the floor of (index-1)/2.
  ///   - Keep looping as long as the element at the parentIndex is less than the element at the child index:
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
      if (_heap[childIndex] <= _heap[parentIndex]) break;

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
  ///   - If the left or right child is greater than the element...swap.
  ///   - If both left and right children are larger, swap with the largest child.
  ///   - The child index you swapped to now becomes the new parent index.
  ///   - Keep looping and swapping until neither child is larger than the element.
  ///   - Return the old root.
  num? extract() {
    if (_heap.isEmpty) return null;

    _heap.swap(0, _heap.length - 1);
    final oldRoot = _heap.removeLast();
    _siftDown(0);
    return oldRoot;
  }

  /// _siftDown() is responsible for swapping the current item with its largest
  /// child (if any), and recursively calling itself on the new child index
  /// until the current item is in its correct position.
  _siftDown(int parentIndex) {
    final leftChildIndex = parentIndex * 2 + 1;
    final rightChildIndex = leftChildIndex + 1;

    if (leftChildIndex >= _heap.length) return;

    final maxChildIndex = rightChildIndex < _heap.length &&
            _heap[rightChildIndex] > _heap[leftChildIndex]
        ? rightChildIndex
        : leftChildIndex;

    if (_heap[maxChildIndex] <= _heap[parentIndex]) return;

    _heap.swap(parentIndex, maxChildIndex);
    _siftDown(maxChildIndex);
  }
}

void main() {
  group('insert', () {
    test('should insert items and sift-up to the correct spot', () {
      final heap = MaxBinaryHeap();
      //        41
      //   39        33
      // 18  27   12
      heap._heap.addAll([41, 39, 33, 18, 27, 12]);

      //             55
      //        39        41
      //     30   27    12  33
      //   18 10
      heap.insert(55);
      heap.insert(30);
      heap.insert(10);

      expect(heap._heap, [55, 39, 41, 30, 27, 12, 33, 18, 10]);
    });
  });

  group('extract', () {
    test(
        'should extract root item after swapping with last item, then sift-down',
        () {
      final heap = MaxBinaryHeap();
      //        41
      //   39        33
      // 18  27   12
      heap._heap.addAll([41, 39, 33, 18, 27, 12]);

      //        39
      //   27        33
      // 18  12
      expect(heap.extract(), 41);
      expect(heap._heap, [39, 27, 33, 18, 12]);
    });

    test('should return null if the heap is empty', () {
      final heap = MaxBinaryHeap();

      expect(heap.extract(), isNull);
    });
  });

  group('heapify', () {
    test('should convert the list into MaxBinaryHeap', () {
      //         2
      //     1      6
      //   3   5
      final heap = MaxBinaryHeap.buildFromArray([2, 1, 6, 3, 5]);
      //         6
      //     5      2
      //   3   1
      expect(heap._heap, [6, 5, 2, 3, 1]);
    });
  });
}
