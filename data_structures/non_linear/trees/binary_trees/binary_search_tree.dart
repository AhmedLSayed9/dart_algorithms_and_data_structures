import 'package:test/test.dart';

import '../../../linear/queue/queue.dart' as q;

part 'binary_tree_traversal.dart';

class Node<num> {
  Node(this.value);

  num value;
  Node<num>? left;
  Node<num>? right;
}

class BinarySearchTree {
  Node<num>? _root;

  /// Pseudocode (Iteratively or Recursively):
  /// - Create a new node.
  /// - Check if there is a root, if not - the root now becomes that new node.
  /// - If there is a root, check if the value of the new node is greater than or less than the value of the root.
  /// - If it is greater:
  ///   - Check to see if there is a node to the right:
  ///     - If there is, move to that node and repeat these steps.
  ///     - If there is not, add that node as the right property.
  /// - If it is less:
  ///   - Check to see if there is a node to the left:
  ///     - If there is, move to that node and repeat these steps.
  ///     - If there is not, add that node as the left property.
  BinarySearchTree? insert(num value) {
    if (_root case final root?) {
      return _insertRecursion(value, root);
    }
    _root = Node(value);
    return this;
  }

  BinarySearchTree? _insertRecursion(num value, Node<num> node) {
    if (value < node.value) {
      if (node.left == null) {
        node.left = Node(value);
        return this;
      }
      return _insertRecursion(value, node.left!);
    }
    if (value > node.value) {
      if (node.right == null) {
        node.right = Node(value);
        return this;
      }
      return _insertRecursion(value, node.right!);
    }
    //value == node.value (value already there)
    return null;
  }

  /// Pseudocode (Iteratively or Recursively):
  /// - Starting at the root.
  /// - Check if there is a root, if not - we're done searching.
  /// - If there is a root, check if the value of the new node is the value we are looking for:
  ///   - If we found it, we're done.
  ///   - If not, check to see if the value is greater than or less than the value of the root:
  ///     - If it is greater, check to see if there is a node to the right:
  ///       - If there is, move to that node and repeat these steps.
  ///       - If there is not, we're done searching.
  ///     - If it is less, check to see if there is a node to the left:
  ///       - If there is, move to that node and repeat these steps.
  ///       - If there is not, we're done searching.
  bool find(num value) {
    return _findRecursion(value, _root);
  }

  bool _findRecursion(num value, Node<num>? node) {
    if (node == null) return false;
    if (value < node.value) return _findRecursion(value, node.left);
    if (value > node.value) return _findRecursion(value, node.right);
    return true; //value == node.value (value has found)
  }
}

void main() {
  group('insert', () {
    test('should insert items to the correct branches', () {
      final tree = BinarySearchTree();
      tree.insert(3);
      tree.insert(2);
      tree.insert(1);
      tree.insert(4);

      expect(tree._root, isA<Node>().having((p) => p.value, 'value', 3));
      expect(tree._root?.right, isA<Node>().having((p) => p.value, 'value', 4));
      expect(tree._root?.left, isA<Node>().having((p) => p.value, 'value', 2));
      expect(tree._root?.left?.left,
          isA<Node>().having((p) => p.value, 'value', 1));
    });

    test('should not insert item if it is already there', () {
      final tree = BinarySearchTree();
      tree.insert(1);
      tree.insert(1);

      expect(tree._root, isA<Node>().having((p) => p.value, 'value', 1));
      expect(tree._root?.right, null);
      expect(tree._root?.left, null);
    });
  });

  group('find', () {
    test('should return true if item is found and false if not found', () {
      final tree = BinarySearchTree();
      tree.insert(3);
      tree.insert(2);
      tree.insert(4);

      expect(tree.find(3), true);
      expect(tree.find(2), true);
      expect(tree.find(4), true);
      expect(tree.find(1), false);
    });
  });

  group('BinaryTreeTraversalX', () {
    test('breadthFirstSearch', () {
      final emptyTree = BinarySearchTree();
      expect(emptyTree.bfs(), []);

      //       4
      //  2        6
      // 1  3        7
      final tree = BinarySearchTree();
      tree.insert(4);
      tree.insert(2);
      tree.insert(6);
      tree.insert(1);
      tree.insert(3);
      tree.insert(7);
      expect(tree.bfs(), [4, 2, 6, 1, 3, 7]);
    });

    test('dfsPreOrder', () {
      final emptyTree = BinarySearchTree();
      expect(emptyTree.dfsPreOrder(), []);

      //       4
      //  2        6
      // 1  3        7
      final tree = BinarySearchTree();
      tree.insert(4);
      tree.insert(2);
      tree.insert(6);
      tree.insert(1);
      tree.insert(3);
      tree.insert(7);
      expect(tree.dfsPreOrder(), [4, 2, 1, 3, 6, 7]);
    });

    test('dfsPostOrder', () {
      final emptyTree = BinarySearchTree();
      expect(emptyTree.dfsPostOrder(), []);

      //       4
      //  2        6
      // 1  3        7
      final tree = BinarySearchTree();
      tree.insert(4);
      tree.insert(2);
      tree.insert(6);
      tree.insert(1);
      tree.insert(3);
      tree.insert(7);
      expect(tree.dfsPostOrder(), [1, 3, 2, 7, 6, 4]);
    });

    test('dfsInOrder', () {
      final emptyTree = BinarySearchTree();
      expect(emptyTree.dfsInOrder(), []);

      //       4
      //  2        6
      // 1  3        7
      final tree = BinarySearchTree();
      tree.insert(4);
      tree.insert(2);
      tree.insert(6);
      tree.insert(1);
      tree.insert(3);
      tree.insert(7);
      expect(tree.dfsInOrder(), [1, 2, 3, 4, 6, 7]);
    });
  });
}
