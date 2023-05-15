import 'package:test/test.dart';

class ArrayStack<T> {
  final List<T> _stack = [];

  int _size = 0;

  T? get last => size == 0 ? null : _stack[_size - 1];

  int get size => _size;

  bool get isEmpty => size == 0;

  int push(T value) {
    _stack.add(value);
    return ++_size;
  }

  T? pop() {
    if (_size == 0) return null;

    final T poppedItem = _stack[_size - 1];
    _stack.removeAt(_size - 1);

    _size--;
    return poppedItem;
  }
}

void main() {
  group('push', () {
    test('should push item to the top and return the size', () {
      final linkedList = ArrayStack<int>();

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
      final linkedList = ArrayStack<int>();
      linkedList.push(1);
      linkedList.push(2);
      linkedList.push(3);

      expect(linkedList.pop(), 3);
      expect(linkedList.last, 2);
      expect(linkedList.size, 2);
    });

    test('should return null if the list is empty', () {
      final linkedList = ArrayStack<int>();

      expect(linkedList.pop(), isNull);
    });
  });

  test('isEmpty should return true only if the stack is empty', () {
    final linkedList = ArrayStack<int>();
    expect(linkedList.isEmpty, true);
    linkedList.push(1);
    expect(linkedList.isEmpty, false);
  });
}
