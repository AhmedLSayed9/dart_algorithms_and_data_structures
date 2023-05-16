import 'package:test/test.dart';

class Node<num> {
  Node(this.value);

  num value;
  Node<num>? left;
  Node<num>? right;
}

class BinarySearchTree {
  Node<num>? root;

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
    final newNode = Node(value);
    final currentRoot = root;

    if (currentRoot == null) {
      root = newNode;
      return this;
    }

    BinarySearchTree? insertHelper(Node<num> node) {
      if (value < node.value) {
        if (node.left == null) {
          node.left = newNode;
          return this;
        }
        return insertHelper(node.left!);
      }
      if (value > node.value) {
        if (node.right == null) {
          node.right = newNode;
          return this;
        }
        return insertHelper(node.right!);
      }
      //value == node.value (value already there)
      return null;
    }

    return insertHelper(currentRoot);
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
    bool findHelper(Node<num>? node) {
      if (node == null) return false;
      if (value < node.value) return findHelper(node.left);
      if (value > node.value) return findHelper(node.right);
      return true; //value == node.value (value has found)
    }

    return findHelper(root);
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

      expect(tree.root, isA<Node>().having((p) => p.value, 'value', 3));
      expect(tree.root?.right, isA<Node>().having((p) => p.value, 'value', 4));
      expect(tree.root?.left, isA<Node>().having((p) => p.value, 'value', 2));
      expect(tree.root?.left?.left,
          isA<Node>().having((p) => p.value, 'value', 1));
    });

    test('should not insert item if it is already there', () {
      final tree = BinarySearchTree();
      tree.insert(1);
      tree.insert(1);

      expect(tree.root, isA<Node>().having((p) => p.value, 'value', 1));
      expect(tree.root?.right, null);
      expect(tree.root?.left, null);
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
}
