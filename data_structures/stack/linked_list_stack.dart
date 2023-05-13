import 'package:test/test.dart';

class Node<T> {
  Node(this.value);

  T value;
  Node<T>? next;
}

class LinkedListStack<T> {
  Node<T>? _head;
  int _size = 0;

  T? get last => _head?.value;

  int get size => _size;

  bool get isEmpty => size == 0;

  /// Push from the start same as the linked list's unShift. (to achieve constant time when popping)
  /// Pseudocode:
  /// - The function should accept a value.
  /// - Create a new node with that value.
  /// - Set the newly created node's next property to be the current head property on the stack.
  /// - Set the head property on the stack to be that newly created node.
  /// - Increment the size of the stack by 1 and return it.
  int push(T value) {
    final newNode = Node(value);
    newNode.next = _head;
    _head = newNode;
    return ++_size;
  }

  /// Pseudocode:
  /// - If there are no nodes in the stack, return null.
  /// - Create a temporary variable to store the head property on the stack.
  /// - Set the head property to be the next property on the current head.
  /// - Decrement the size by 1.
  /// - Return the value of the node removed.
  T? pop() {
    if (_size == 0) return null;

    Node<T>? oldHead = _head;
    _head = oldHead?.next;

    _size--;
    return oldHead?.value;
  }
}

void main() {
  group('push', () {
    test('should push item to the top and return the size', () {
      final linkedList = LinkedListStack<int>();

      expect(linkedList.push(10), 1);
      expect(linkedList.last, 10);

      expect(linkedList.push(11), 2);
      expect(linkedList.last, 11);

      expect(linkedList.push(12), 3);
      expect(linkedList.last, 12);

      expect(linkedList.size, 3);
    });
  });

  group('pop', () {
    test('should pop and return the last item', () {
      final linkedList = LinkedListStack<int>();
      linkedList.push(1);
      linkedList.push(2);
      linkedList.push(3);

      expect(linkedList.pop(), 3);
      expect(linkedList.last, 2);
      expect(linkedList.size, 2);
    });

    test('should return null if the list is empty', () {
      final linkedList = LinkedListStack<int>();

      expect(linkedList.pop(), isNull);
    });
  });


  test('isEmpty should return true only if the stack is empty', () {
    final linkedList = LinkedListStack<int>();
    expect(linkedList.isEmpty, true);
    linkedList.push(1);
    expect(linkedList.isEmpty, false);
  });
}
