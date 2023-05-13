import 'package:test/test.dart';

class Node<T> {
  Node(this.value);

  T value;
  Node<T>? next;
  Node<T>? prev;
}

class DoubleLinkedList<T> extends Iterable<T> {
  int _length = 0;

  @override
  int get length => this._length;

  @override
  Iterator<T> get iterator => LinkedListIterator<T>(this._head);

  Node<T>? _head;
  Node<T>? _tail;

  /// Pseudocode:
  /// - Create a new node with the value passed to the function.
  /// - If the head property is null set the head and tail to be the newly created node.
  /// - If not, set the next property on the tail to be that node.
  /// - Set the previous property on the newly created node to be the tail.
  /// - Set the tail to be the newly created node.
  /// - Increment the length.
  /// - Return the Doubly Linked List.
  DoubleLinkedList<T> push(T value) {
    final newNode = Node(value);
    if (_length == 0) {
      _head = newNode;
      _tail = newNode;
    } else {
      newNode.prev = _tail;
      _tail!.next = newNode;
      _tail = newNode;
    }
    _length++;
    return this;
  }

  /// Pseudocode:
  /// - If there is no head, return undefined.
  /// - Store the current tail in a variable to return later.
  /// - Update the tail to be the previous Node.
  /// - Set the newTail's next to null.
  /// - If there is only 1 node, set the head to null too.
  /// - Decrement the length.
  /// - Return the value removed.
  T? pop() {
    if (_length == 0) return null;

    Node<T>? poppedNode = _tail;
    _tail = _tail?.prev;
    _tail?.next = null;
    if (_length == 1) _head = null;

    _length--;
    return poppedNode?.value;
  }

  /// Pseudocode:
  /// - If length is 0, return undefined.
  /// - Store the current tail in a variable to return later.
  /// - Update the head to be the next of the old head.
  /// - Set the head's prev property to null.
  /// - If there is only 1 node, set the tail to null too.
  /// - Decrement the length.
  /// - Return the value of the node removed.
  T? shift() {
    if (_length == 0) return null;

    Node<T>? oldHead = _head;
    _head = oldHead?.next;
    _head?.prev = null;
    if (_length == 1) _tail = null;

    _length--;
    return oldHead?.value;
  }

  /// Pseudocode:
  /// - This function should accept a value.
  /// - Create a new node using the value passed to the function.
  /// - If there is no head property on the list, set the head and tail to be the newly created node.
  /// - Otherwise:
  ///   - Set the prev property on the head of the list to be the new node.
  ///   - Set the next property on the new node to be the head property.
  ///   - Update the head to be the new node.
  /// - Increment the length of the list by 1.
  /// - Return the linked list.
  DoubleLinkedList<T> unShift(T value) {
    final newNode = Node(value);
    if (_length == 0) {
      _head = newNode;
      _tail = newNode;
    } else {
      _head?.prev = newNode;
      newNode.next = _head;
      _head = newNode;
    }
    _length++;
    return this;
  }

  /// Pseudocode:
  /// - If the index is less than 0 or greater or equal to the length, return null
  /// - If the index is less than or equal to half the length of the list:
  ///   - Loop through the list starting from the head and loop towards the middle.
  ///   - Return the node once it is found.
  /// - If the index is greater than half the length of the list:
  ///   - Loop through the list starting from the tail and loop towards the middle
  ///  - Return the node once it is found
  T? get(int index) {
    return _getNodeAtIndex(index)?.value;
  }

  Node<T>? _getNodeAtIndex(int index) {
    if (index < 0 || index >= _length) return null;

    final middleIndex = _length / 2;
    Node<T>? current;

    if (index < middleIndex) {
      current = _head;
      for (int i = 0; i != index; i++) {
        current = current?.next;
      }
    } else {
      current = _tail;
      for (int i = _length - 1; i != index; i--) {
        current = current?.prev;
      }
    }
    return current;
  }

  /// Pseudocode:
  /// - This function should accept a value and an index.
  /// - Use your get function to find the specific node.
  /// - If the node is not found, return false.
  /// - If the node is found, set the value of that node to be the value passed to the function and return true.
  bool set(int index, T value) {
    final node = _getNodeAtIndex(index);
    if (node != null) {
      node.value = value;
      return true;
    }
    return false;
  }

  /// Pseudocode:
  /// - If the index is less than zero or greater than the length, return false.
  /// - If the index is the same as the length, push a new node to the end of the list.
  /// - If the index is 0, unshift a new node to the start of the list.
  /// - Otherwise, using the get method, access the node at the index - 1.
  /// - Set the next and prev properties on the correct nodes to link everything together.
  /// - Increment the length.
  /// - Return true.
  bool insert(int index, T value) {
    if (index < 0 || index > _length) return false;

    if (index == _length) {
      push(value);
    } else if (index == 0) {
      unShift(value);
    } else {
      final newNode = Node(value);
      final prevNode = _getNodeAtIndex(index - 1)!;
      final nextNode = prevNode.next!;
      newNode.next = nextNode;
      nextNode.prev = newNode;
      newNode.prev = prevNode;
      prevNode.next = newNode;
      _length++;
    }
    return true;
  }

  /// Pseudocode:
  /// - If the index is less than zero or greater than or equal to the length, return undefined.
  /// - If the index is the same as the length-1, pop.
  /// - If the index is 0, shift.
  /// - Otherwise, use the get method to retrieve the item to be removed.
  /// - Update the next and prev properties to remove the found node from the list.
  /// - Set next and prev to null on the found node.
  /// - Decrement the length.
  /// - Return the value of the node removed.
  T? remove(int index) {
    if (index < 0 || index >= _length) return null;

    if (index == _length - 1) return pop();
    if (index == 0) return shift();

    final removedNode = _getNodeAtIndex(index)!;
    final prevNode = removedNode.prev!;
    final nextNode = removedNode.next!;
    prevNode.next = nextNode;
    nextNode.prev = prevNode;
    _length--;
    return removedNode.value;
  }

  @override
  String toString() {
    List<T> values = [];
    Node<T>? currentNode = _head;
    while (currentNode != null) {
      values.add(currentNode.value);
      currentNode = currentNode.next;
    }
    return values.toString();
  }
}

class LinkedListIterator<T> extends Iterator<T> {
  LinkedListIterator(this._current);

  Node<T>? _current;

  @override
  bool moveNext() => _current != null;

  @override
  T get current {
    T currentValue = this._current!.value;
    this._current = this._current!.next;
    return currentValue;
  }
}

void main() {
  group('push', () {
    test('should push items in order', () {
      final linkedList = DoubleLinkedList<int>();
      linkedList.push(1);
      linkedList.push(2);
      linkedList.push(3);

      expect(linkedList, [1, 2, 3]);
      expect(linkedList.length, 3);
      expect(linkedList._head, isA<Node>().having((p) => p.value, 'value', 1));
      expect(linkedList._tail, isA<Node>().having((p) => p.value, 'value', 3));
    });

    test('pushed node should has ref to prev node', () {
      final linkedList = DoubleLinkedList<int>();
      linkedList.push(1);
      linkedList.push(2);

      expect(linkedList._tail?.prev, linkedList._head);
    });
  });

  group('pop', () {
    test('should pop and return the tail', () {
      final linkedList = DoubleLinkedList<int>();
      linkedList.push(1);
      linkedList.push(2);
      linkedList.push(3);

      expect(linkedList.pop(), 3);
      expect(linkedList, [1, 2]);
      expect(linkedList.length, 2);
      expect(linkedList._tail, isA<Node>().having((p) => p.value, 'value', 2));
    });

    test('should return null if the list is empty', () {
      final linkedList = DoubleLinkedList<int>();

      expect(linkedList.pop(), isNull);
      expect(linkedList, equals([]));
    });
  });

  //TODO: Test the rest of the methods.
}
