import 'package:test/test.dart';

import '../../../linear/queue/queue.dart' as q;
import 'binary_search_tree.dart';

extension BinaryTreeTraversalX on BinarySearchTree {
  /// Breadth-first Search (BFS) Pseudocode (Iteratively):
  /// - Create a queue (this can be an array) and a variable to store the values of nodes visited.
  /// - Place the root node in the queue.
  /// - Loop as long as there is anything in the queue:
  ///   - Dequeue a node from the queue and push the value of the node into the variable that stores the nodes.
  ///   - If there is a left property on the node dequeued - add it to the queue.
  ///   - If there is a right property on the node dequeued - add it to the queue.
  /// - Return the variable that stores the values.
  List<num> bfs() {
    final List<num> data = [];
    final queue = q.Queue<Node<num>>();
    if (root case final root?) queue.enqueue(root);

    Node<num> dequeuedNode;
    while (!queue.isEmpty) {
      dequeuedNode = queue.dequeue()!;
      data.add(dequeuedNode.value);
      if (dequeuedNode.left != null) queue.enqueue(dequeuedNode.left!);
      if (dequeuedNode.right != null) queue.enqueue(dequeuedNode.right!);
    }

    return data;
  }

  /// Depth-first Search (DFS) PreOrder Pseudocode (Recursively):
  /// - Create a variable to store the values of nodes visited.
  /// - Write a helper function which accepts a node:
  ///   - Push the value of the node to the variable that stores the values.
  ///   - If the node has a left property, call the helper function with the left property on the node.
  ///   - If the node has a right property, call the helper function with the right property on the node.
  /// - Invoke the helper function with the current root.
  /// - Return the array of values.
  List<num> dfsPreOrder() {
    final List<num> data = [];
    _dfsPreOrderRecursive(data, root);
    return data;
  }

  void _dfsPreOrderRecursive(List<num> data, Node<num>? node) {
    if (node == null) return;
    data.add(node.value);
    if (node.left != null) _dfsPreOrderRecursive(data, node.left);
    if (node.right != null) _dfsPreOrderRecursive(data, node.right);
  }

  /// Depth-first Search (DFS) PostOrder Pseudocode (Recursively):
  /// - Create a variable to store the values of nodes visited.
  /// - Write a helper function which accepts a node:
  ///   - If the node has a left property, call the helper function with the left property on the node.
  ///   - If the node has a right property, call the helper function with the right property on the node.
  ///   - Push the value of the node to the variable that stores the values.
  /// - Invoke the helper function with the current root.
  /// - Return the array of values.
  List<num> dfsPostOrder() {
    final List<num> data = [];
    _dfsPostOrderRecursive(data, root);
    return data;
  }

  void _dfsPostOrderRecursive(List<num> data, Node<num>? node) {
    if (node == null) return;
    if (node.left != null) _dfsPostOrderRecursive(data, node.left);
    if (node.right != null) _dfsPostOrderRecursive(data, node.right);
    data.add(node.value);
  }

  /// Depth-first Search (DFS) InOrder Pseudocode (Recursively):
  /// - Create a variable to store the values of nodes visited.
  /// - Write a helper function which accepts a node:
  ///   - If the node has a left property, call the helper function with the left property on the node.
  ///   - Push the value of the node to the variable that stores the values.
  ///   - If the node has a right property, call the helper function with the right property on the node.
  /// - Invoke the helper function with the current root.
  /// - Return the array of values.
  List<num> dfsInOrder() {
    final List<num> data = [];
    _dfsInOrderRecursive(data, root);
    return data;
  }

  void _dfsInOrderRecursive(List<num> data, Node<num>? node) {
    if (node == null) return;
    if (node.left != null) _dfsInOrderRecursive(data, node.left);
    data.add(node.value);
    if (node.right != null) _dfsInOrderRecursive(data, node.right);
  }
}

void main() {
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
}
