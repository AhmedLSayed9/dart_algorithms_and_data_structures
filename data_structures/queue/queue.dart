import 'package:test/test.dart';

class Node<T> {
  Node(this.value);

  T value;
  Node<T>? next;
}

class Queue<T> {
  int _size = 0;

  Node<T>? _first, _last;

  T? get first => _first?.value;

  int get size => _size;

  bool get isEmpty => size == 0;

  /// Adding to the beginning of the Queue.
  /// En-queuing from the end (last) same as the linked list's push. (to achieve constant time when popping)
  ///
  /// Pseudocode:
  /// - This function accepts some value
  /// - Create a new node using that value passed to the function
  /// - If there are no nodes in the queue, set this node to be the first and last property of the queue
  /// - Otherwise:
  ///   - set the next property on the current last to be that node
  ///   - set the last property of the queue to be that node
  /// - Increment the size of the queue by 1
  int enqueue(T value) {
    final newNode = Node(value);

    if (_size == 0) {
      _first = newNode;
      _last = newNode;
    } else {
      _last!.next = newNode;
      _last = newNode;
    }

    return ++_size;
  }

  /// Removing from the beginning of the Queue.
  /// De-queuing from the start (first) same as the linked list's shift.
  ///
  /// Pseudocode:
  /// - If there is no first property, just return null.
  /// - Store the first property in a variable.
  /// - If the size is 1, set the first and last to be null.
  /// - Otherwise:
  ///   - set the first property to be the next property of first
  /// - Decrement the size by 1
  /// - Return the value of the node dequeued
  T? dequeue() {
    final oldFirst = _first;
    if (oldFirst == null) return null;

    if (size == 1) {
      _first = null;
      _last = null;
    } else {
      _first = oldFirst.next;
    }

    _size--;
    return oldFirst.value;
  }
}

void main() {
  group('enqueue', () {
    test('should enqueue items in order and return the size', () {
      final linkedList = Queue<int>();

      expect(linkedList.enqueue(10), 1);
      expect(linkedList.first, 10);

      expect(linkedList.enqueue(11), 2);
      expect(linkedList.first, 10);

      expect(linkedList.enqueue(12), 3);
      expect(linkedList.first, 10);

      expect(linkedList.size, 3);
    });
  });

  group('dequeue', () {
    test('should dequeue and return the first item added', () {
      final linkedList = Queue<int>();
      linkedList.enqueue(1);
      linkedList.enqueue(2);
      linkedList.enqueue(3);

      expect(linkedList.dequeue(), 1);
      expect(linkedList.first, 2);
      expect(linkedList.size, 2);
    });

    test('should return null if the list is empty', () {
      final linkedList = Queue<int>();

      expect(linkedList.dequeue(), isNull);
    });
  });

  test('isEmpty should return true only if the queue is empty', () {
    final linkedList = Queue<int>();
    expect(linkedList.isEmpty, true);
    linkedList.enqueue(1);
    expect(linkedList.isEmpty, false);
  });
}
