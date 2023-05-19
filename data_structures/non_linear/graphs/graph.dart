import 'package:test/test.dart';

import '../../linear/queue/queue.dart';

/// An undirected GRAPH using the adjacency list representation.
class Graph<T> {
  /// Creates an undirected GRAPH using the adjacency list representation.
  Graph();

  final Map<T, List<T>> _adjacencyList = {};

  /// Pseudocode:
  /// - Write a method called addVertex, which accepts a vertex.
  /// - It should add a key to the adjacency list with the vertex
  ///   and set its value to be an empty array (no neighbors).
  void addVertex(T vertex) {
    if (_adjacencyList[vertex] != null) {
      throw StateError('vertex already added!');
    }
    _adjacencyList[vertex] = [];
  }

  /// Pseudocode:
  /// - The function should accept a vertex to remove.
  /// - The function should iterate over the neighbors list of that vertex as long as there
  ///   is any vertices in the list.
  /// - Inside of the loop, call our removeEdge function with the vertex we are removing
  ///   and the current neighbor.
  /// - Eventually, Delete the key for that vertex at the adjacency list.
  removeVertex(T vertex) {
    final neighbors = _adjacencyList[vertex];
    if (neighbors == null) throw StateError('vertex does not exist!');

    while (neighbors.isNotEmpty) {
      removeEdge(vertex, neighbors.last);
    }
    _adjacencyList.remove(vertex);
  }

  /// Pseudocode:
  /// - This function should accept two vertices, we can call them vertex1 and vertex2.
  /// - The function should add vertex1 to the neighbors list of vertex2.
  /// - The function should add vertex2 to the neighbors list of vertex1.
  addEdge(T vertex1, T vertex2) {
    final v1Neighbors = _adjacencyList[vertex1];
    final v2Neighbors = _adjacencyList[vertex2];
    if (v1Neighbors == null || v2Neighbors == null) {
      throw StateError('Either vertex1 or vertex2 does not exist!');
    }
    v1Neighbors.add(vertex2);
    v2Neighbors.add(vertex1);
  }

  /// Pseudocode:
  /// - This function should accept two vertices, we'll call them vertex1 and vertex2.
  /// - The function should remove vertex2 from the neighbors list of vertex2.
  /// - The function should remove vertex1 from the neighbors list of vertex1.
  removeEdge(T vertex1, T vertex2) {
    final v1Neighbors = _adjacencyList[vertex1];
    final v2Neighbors = _adjacencyList[vertex2];
    if (v1Neighbors == null || v2Neighbors == null) {
      throw StateError('Either vertex1 or vertex2 does not exist!');
    }
    v1Neighbors.remove(vertex2);
    v2Neighbors.remove(vertex1);
  }

  /// Depth-first Search (DFS) Pseudocode (Recursively):
  /// - The function should accept a starting vertex.
  /// - The function should return early if the startingVertex doesn't exist.
  /// - Create a list to store the end result, to be returned at the very end.
  /// - Create a set or map to store the visited vertices.
  /// - Create a helper function which accepts a vertex:
  ///   - The helper function should place the vertex it accepts into the
  ///     visited set and push that vertex into the result list.
  ///   - Loop over all of the values in the neighbors list for that vertex (will end if it's empty).
  ///   - If any of those values have not been visited, recursively invoke the helper function with that vertex.
  /// - Invoke the helper function with the starting vertex.
  /// - Return the result array.
  List<T> dfs(T startingVertex) {
    // startingVertex vertex doesn't exist.
    if (_adjacencyList[startingVertex] == null) return [];

    final List<T> data = [];
    final Set<T> visited = {};

    _dfsRecursive(data, visited, startingVertex);
    return data;
  }

  void _dfsRecursive(List<T> data, Set<T> visited, T vertex) {
    visited.add(vertex);
    data.add(vertex);

    for (final neighbor in _adjacencyList[vertex]!) {
      if (!visited.contains(neighbor)) _dfsRecursive(data, visited, neighbor);
    }
  }

  /// Breadth-first Search (BFS) Pseudocode (Iteratively):
  /// - The function should accept a starting vertex.
  /// - The function should return early if the startingVertex doesn't exist.
  /// - Create a list to store the end result, to be returned at the very end.
  /// - Create a set or map to store the visited vertices.
  /// - Create a queue and place the starting vertex in it.
  /// - Mark the starting vertex as visited.
  /// - Loop as long as there is anything in the queue:
  ///   - Remove the first vertex from the queue and push it into the result list.
  ///   - Loop over all of the values in the neighbors list for that vertex (will end if it's empty).
  ///   - If any of those values have not been visited, mark it as visited and enqueue that vertex.
  /// - Return the result array.
  List<T> bfs(T startingVertex) {
    // startingVertex vertex doesn't exist.
    if (_adjacencyList[startingVertex] == null) return [];

    final List<T> data = [];
    final Set<T> visited = {};

    final queue = Queue<T>()..enqueue(startingVertex);
    visited.add(startingVertex);

    while (queue.isNotEmpty) {
      final vertex = queue.dequeue() as T;
      data.add(vertex);

      for (final neighbor in _adjacencyList[vertex]!) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.enqueue(neighbor);
        }
      }
    }

    return data;
  }
}

void main() {
  group('addVertex', () {
    test(
        'should add vertex to the graph with no neighboring vertices (no edges)',
        () {
      final graph = Graph<String>();
      graph.addVertex('Cairo');
      expect(graph._adjacencyList, {'Cairo': []});
    });

    test('should throw if the vertex already added', () {
      final graph = Graph<String>();
      graph.addVertex('Cairo');
      expect(
        () => graph.addVertex('Cairo'),
        throwsA(
          isA<StateError>()
              .having((e) => e.message, 'message', 'vertex already added!'),
        ),
      );
    });
  });

  group('removeVertex', () {
    test(
        'should remove the vertex and all the edges connected to it'
        '(remove the vertex from its neighboring vertices too)', () {
      final graph = Graph<String>();
      graph._adjacencyList.addAll({
        'Cairo': ['Alex', 'Giza'],
        'Alex': ['Cairo', 'Giza'],
        'Giza': ['Cairo', 'Alex']
      });

      graph.removeVertex('Cairo');
      expect(graph._adjacencyList, {
        'Alex': ['Giza'],
        'Giza': ['Alex']
      });
      graph.removeVertex('Alex');
      expect(graph._adjacencyList, {'Giza': []});
    });

    test('should throw if the vertex does not exist', () {
      final graph = Graph<String>();
      graph.addVertex('Cairo');
      expect(
        () => graph.removeVertex('Giza'),
        throwsA(
          isA<StateError>()
              .having((e) => e.message, 'message', 'vertex does not exist!'),
        ),
      );
    });
  });

  group('addEdge', () {
    test('should add an edge between two vertices (be neighbors to each other)',
        () {
      final graph = Graph<String>();

      graph.addVertex('Cairo');
      graph.addVertex('Alex');
      graph.addVertex('Giza');
      expect(graph._adjacencyList, {'Cairo': [], 'Alex': [], 'Giza': []});

      graph.addEdge('Cairo', 'Alex');
      expect(graph._adjacencyList, {
        'Cairo': ['Alex'],
        'Alex': ['Cairo'],
        'Giza': []
      });
      graph.addEdge('Cairo', 'Giza');
      expect(graph._adjacencyList, {
        'Cairo': ['Alex', 'Giza'],
        'Alex': ['Cairo'],
        'Giza': ['Cairo']
      });
    });

    test('should throw if either of the vertices does not exist', () {
      final graph = Graph<String>();
      graph.addVertex('Cairo');

      expect(
        () => graph.addEdge('Cairo', 'Alexandria'),
        throwsA(
          isA<StateError>().having((e) => e.message, 'message',
              'Either vertex1 or vertex2 does not exist!'),
        ),
      );
    });
  });

  group('removeEdge', () {
    test('should remove the edge between two vertices', () {
      final graph = Graph<String>();
      graph._adjacencyList.addAll({
        'Cairo': ['Alex', 'Giza'],
        'Alex': ['Cairo'],
        'Giza': ['Cairo']
      });

      graph.removeEdge('Cairo', 'Alex');
      expect(graph._adjacencyList, {
        'Cairo': ['Giza'],
        'Alex': [],
        'Giza': ['Cairo']
      });
      graph.removeEdge('Cairo', 'Giza');
      expect(graph._adjacencyList, {'Cairo': [], 'Alex': [], 'Giza': []});
    });

    test('should throw if either of the vertices does not exist', () {
      final graph = Graph<String>();
      graph.addVertex('Cairo');

      expect(
        () => graph.removeEdge('Cairo', 'Alexandria'),
        throwsA(
          isA<StateError>().having((e) => e.message, 'message',
              'Either vertex1 or vertex2 does not exist!'),
        ),
      );
    });
  });

  group('Graph Traversal', () {
    test('dfs', () {
      final emptyGraph = Graph<String>();
      expect(emptyGraph.dfs(''), []);

      ///       A
      ///    /     \
      ///  B         C
      ///  |         |
      ///  D ______ E
      ///   \      /
      ///      F
      final graph = Graph<String>();
      graph._adjacencyList.addAll({
        'A': ['B', 'C'],
        'B': ['A', 'D'],
        'C': ['A', 'E'],
        'D': ['B', 'E', 'F'],
        'E': ['C', 'D', 'F'],
        'F': ['D', 'E']
      });
      expect(graph.dfs('A'), ['A', 'B', 'D', 'E', 'C', 'F']);
    });

    test('bfs', () {
      final emptyGraph = Graph<String>();
      expect(emptyGraph.bfs(''), []);

      ///       A
      ///    /     \
      ///  B         C
      ///  |         |
      ///  D ______ E
      ///   \      /
      ///      F
      final graph = Graph<String>();
      graph._adjacencyList.addAll({
        'A': ['B', 'C'],
        'B': ['A', 'D'],
        'C': ['A', 'E'],
        'D': ['B', 'E', 'F'],
        'E': ['C', 'D', 'F'],
        'F': ['D', 'E']
      });
      expect(graph.bfs('A'), ['A', 'B', 'C', 'D', 'E', 'F']);
    });
  });
}
