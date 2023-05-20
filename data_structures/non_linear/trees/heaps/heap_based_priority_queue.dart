import 'package:test/test.dart';

import '../../../../utils/list_extension.dart';

/// Note: While priority queues are often implemented using heaps, they are conceptually
/// distinct from heaps. A priority queue is an abstract data structure like a list
/// or a map; just as a list can be implemented with a linked list or with an array,
/// a priority queue can be implemented with a heap or another method such as an unordered array.
///
/// Pseudocode:
/// - Write a Min Binary Heap - lower number means higher priority.
/// - Each Node has a val value a priority. Use the priority to build the heap.
/// - Enqueue method accepts a value and priority, makes a new node,
///   and puts it in the right spot based off of its priority.
/// - Dequeue method removes root element, returns it, and rearranges heap using priority.

class Node<T> {
  Node(this.value, this.priority);

  T value;
  num priority;
}

class PriorityQueue<T> {
  final List<Node<T>> _heap = [];

  void enqueue(T value, num priority) {
    final newNode = Node(value, priority);
    _heap.add(newNode);
    _siftUp();
  }

  _siftUp() {
    int childIndex = _heap.length - 1;

    while (childIndex > 0) {
      final parentIndex = (childIndex - 1) ~/ 2;
      if (_heap[childIndex].priority >= _heap[parentIndex].priority) break;

      _heap.swap(childIndex, parentIndex);
      childIndex = parentIndex;
    }
  }

  T? dequeue() {
    if (_heap.isEmpty) return null;

    _heap.swap(0, _heap.length - 1);
    final oldRoot = _heap.removeLast();
    _siftDown();
    return oldRoot.value;
  }

  _siftDown() {
    int parentIndex = 0;

    while (true) {
      final leftChildIndex = parentIndex * 2 + 1;
      final rightChildIndex = leftChildIndex + 1;

      if (leftChildIndex >= _heap.length) break;

      final minChildIndex = rightChildIndex < _heap.length &&
              _heap[rightChildIndex].priority < _heap[leftChildIndex].priority
          ? rightChildIndex
          : leftChildIndex;

      if (_heap[minChildIndex].priority >= _heap[parentIndex].priority) break;

      _heap.swap(parentIndex, minChildIndex);
      parentIndex = minChildIndex;
    }
  }
}

void main() {
  group('enqueue', () {
    test('should enqueue items and sift-up based on the priority', () {
      final queue = PriorityQueue<String>();
      //         1
      //     2      5
      //   6   3
      queue.enqueue('some5', 5);
      queue.enqueue('some6', 6);
      queue.enqueue('some3', 3);
      queue.enqueue('some1', 1);
      queue.enqueue('some2', 2);

      expect(queue._heap.map((e) => e.priority).toList(), [1, 2, 5, 6, 3]);
    });
  });

  group('dequeue', () {
    test(
        'should dequeue root item after swapping with last item, then sift-down',
        () {
      final queue = PriorityQueue<String>();
      //         1
      //     2      5
      //   6   3
      queue.enqueue('some5', 5);
      queue.enqueue('some6', 6);
      queue.enqueue('some3', 3);
      queue.enqueue('some1', 1);
      queue.enqueue('some2', 2);

      //         2
      //     3      5
      //   6
      expect(queue.dequeue(), 'some1');
      expect(queue._heap.map((e) => e.priority).toList(), [2, 3, 5, 6]);
      //         3
      //     6      5
      expect(queue.dequeue(), 'some2');
      expect(queue._heap.map((e) => e.priority).toList(), [3, 6, 5]);
      expect(queue.dequeue(), 'some3');
      expect(queue.dequeue(), 'some5');
      expect(queue.dequeue(), 'some6');
      expect(queue.dequeue(), isNull);
    });

    test('should return null if the queue is empty', () {
      final queue = PriorityQueue();

      expect(queue.dequeue(), isNull);
    });
  });
}
