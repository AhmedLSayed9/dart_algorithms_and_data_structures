import 'package:test/test.dart';

import '../trees/heaps/heap_based_priority_queue.dart';

part 'dijkstra_algorithm.dart';

typedef WeightedEdge<T> = (T vertex, num weight);

/// A Weighted Undirected Graph using the adjacency list representation.
class WeightedGraph<T> {
  /// Creates a Weighted Undirected Graph using the adjacency list representation.
  WeightedGraph();

  final Map<T, List<WeightedEdge<T>>> _adjacencyList = {};

  void addVertex(T vertex) {
    if (_adjacencyList[vertex] != null) {
      throw StateError('vertex already added!');
    }
    _adjacencyList[vertex] = [];
  }

  removeVertex(T vertex) {
    final neighbors = _adjacencyList[vertex];
    if (neighbors == null) throw StateError('vertex does not exist!');

    while (neighbors.isNotEmpty) {
      removeEdge(vertex, neighbors.last.$1);
    }
    _adjacencyList.remove(vertex);
  }

  addEdge(T vertex1, T vertex2, num weight) {
    final v1Neighbors = _adjacencyList[vertex1];
    final v2Neighbors = _adjacencyList[vertex2];
    if (v1Neighbors == null || v2Neighbors == null) {
      throw StateError('Either vertex1 or vertex2 does not exist!');
    }
    v1Neighbors.add((vertex2, weight));
    v2Neighbors.add((vertex1, weight));
  }

  removeEdge(T vertex1, T vertex2) {
    final v1Neighbors = _adjacencyList[vertex1];
    final v2Neighbors = _adjacencyList[vertex2];
    if (v1Neighbors == null || v2Neighbors == null) {
      throw StateError('Either vertex1 or vertex2 does not exist!');
    }
    v1Neighbors.removeWhere((r) => r.$1 == vertex2);
    v2Neighbors.removeWhere((r) => r.$1 == vertex1);
  }
}

void main() {
  group('addVertex', () {
    test(
        'should add vertex to the graph with no neighboring vertices (no edges)',
        () {
      final graph = WeightedGraph<String>();
      graph.addVertex('Cairo');
      expect(graph._adjacencyList, {'Cairo': []});
    });

    test('should throw if the vertex already added', () {
      final graph = WeightedGraph<String>();
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
      final graph = WeightedGraph<String>();
      graph._adjacencyList.addAll({
        'Cairo': [('Alex', 1), ('Giza', 2)],
        'Alex': [('Cairo', 1), ('Giza', 3)],
        'Giza': [('Cairo', 2), ('Alex', 3)]
      });

      graph.removeVertex('Cairo');
      expect(graph._adjacencyList, {
        'Alex': [('Giza', 3)],
        'Giza': [('Alex', 3)]
      });
      graph.removeVertex('Alex');
      expect(graph._adjacencyList, {'Giza': []});
    });

    test('should throw if the vertex does not exist', () {
      final graph = WeightedGraph<String>();
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
      final graph = WeightedGraph<String>();

      graph.addVertex('Cairo');
      graph.addVertex('Alex');
      graph.addVertex('Giza');
      expect(graph._adjacencyList, {'Cairo': [], 'Alex': [], 'Giza': []});

      graph.addEdge('Cairo', 'Alex', 1);
      expect(graph._adjacencyList, {
        'Cairo': [('Alex', 1)],
        'Alex': [('Cairo', 1)],
        'Giza': []
      });
      graph.addEdge('Cairo', 'Giza', 2);
      expect(graph._adjacencyList, {
        'Cairo': [('Alex', 1), ('Giza', 2)],
        'Alex': [('Cairo', 1)],
        'Giza': [('Cairo', 2)]
      });
    });

    test('should throw if either of the vertices does not exist', () {
      final graph = WeightedGraph<String>();
      graph.addVertex('Cairo');

      expect(
        () => graph.addEdge('Cairo', 'Alexandria', 1),
        throwsA(
          isA<StateError>().having((e) => e.message, 'message',
              'Either vertex1 or vertex2 does not exist!'),
        ),
      );
    });
  });

  group('removeEdge', () {
    test('should remove the edge between two vertices', () {
      final graph = WeightedGraph<String>();
      graph._adjacencyList.addAll({
        'Cairo': [('Alex', 1), ('Giza', 2)],
        'Alex': [('Cairo', 1)],
        'Giza': [('Cairo', 2)]
      });

      graph.removeEdge('Cairo', 'Alex');
      expect(graph._adjacencyList, {
        'Cairo': [('Giza', 2)],
        'Alex': [],
        'Giza': [('Cairo', 2)]
      });
      graph.removeEdge('Cairo', 'Giza');
      expect(graph._adjacencyList, {'Cairo': [], 'Alex': [], 'Giza': []});
    });

    test('should throw if either of the vertices does not exist', () {
      final graph = WeightedGraph<String>();
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

  group('dijkstra', () {
    test('should return the shortest path from startVertex to endVertex', () {
      final graph = WeightedGraph<String>();

      /// Find the shortest path from A to  E:
      ///     --- (A) ----
      ///  2/              \4
      ///  C --2-- D -3-    B
      ///   \     1|     \ |3
      ///    4---- F --1--(E)
      ///
      /// A -> B -> E = 7
      /// A -> C -> F -> E = 7
      /// A -> C -> D -> E = 7
      /// A -> C -> D -> F -> E = (6)
      graph.addVertex('A');
      graph.addVertex('B');
      graph.addVertex('C');
      graph.addVertex('D');
      graph.addVertex('E');
      graph.addVertex('F');
      graph.addEdge('A', 'B', 4);
      graph.addEdge('A', 'C', 2);
      graph.addEdge('B', 'E', 3);
      graph.addEdge('C', 'D', 2);
      graph.addEdge('C', 'F', 4);
      graph.addEdge('D', 'E', 3);
      graph.addEdge('D', 'F', 1);
      graph.addEdge('F', 'E', 1);

      expect(graph.dijkstra('A', 'E'), ['A', 'C', 'D', 'F', 'E']);
    });

    test(
        'should return the shortest path from startVertex to endVertex'
        '(A test case that pass when using a Priority Queue)', () {
      // A test case for https://stackoverflow.com/questions/12481256
      // & https://stackoverflow.com/questions/61315210/61315360#61315360
      // Without using a Priority Queue, the shortest path will be ['A', 'B', 'D'] which is wrong.
      // The reason is because we will visit both B and C from the path A->B->C first
      // and both will be marked as visited, so updating the shortest path for B to 3 (A->C->B) later
      // will not be possible.

      final graph = WeightedGraph<String>();

      /// Find the shortest path from A to D:
      ///       A
      ///   2/     \5
      ///   C --1-- B
      ///   7\    /3
      ///      D
      graph.addVertex('A');
      graph.addVertex('B');
      graph.addVertex('C');
      graph.addVertex('D');
      graph.addEdge('A', 'B', 5);
      graph.addEdge('A', 'C', 2);
      graph.addEdge('B', 'C', 1);
      graph.addEdge('B', 'D', 3);
      graph.addEdge('C', 'D', 7);

      expect(graph.dijkstra('A', 'D'), ['A', 'C', 'B', 'D']);
    });

    test('should return empty list if no path from startVertex to endVertex',
        () {
      ///        (A)
      ///
      ///  C --2-- D --3-- B
      final graph = WeightedGraph<String>();
      graph.addVertex('A');
      graph.addVertex('B');
      graph.addVertex('C');
      graph.addVertex('D');
      graph.addEdge('B', 'D', 3);
      graph.addEdge('C', 'D', 2);

      expect(graph.dijkstra('A', 'B'), []);
      expect(graph.dijkstra('A', 'D'), []);
      expect(graph.dijkstra('A', 'C'), []);
      expect(graph.dijkstra('B', 'C'), ['B', 'D', 'C']);
    });

    test(
        'should return empty list if either startVertex/endVertex does not exist',
        () {
      final graph = WeightedGraph<String>();
      graph.addVertex('A');
      graph.addVertex('B');
      graph.addVertex('C');
      graph.addEdge('A', 'B', 4);
      graph.addEdge('A', 'C', 2);

      expect(graph.dijkstra('A', 'E'), []);
      expect(graph.dijkstra('E', 'A'), []);
    });
  });
}
