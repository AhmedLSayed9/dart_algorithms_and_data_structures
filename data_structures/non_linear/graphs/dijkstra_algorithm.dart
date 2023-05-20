part of 'weighted_graph.dart';

extension BinaryTreeTraversalX<T> on WeightedGraph<T> {
  /// Dijkstra's Pseudocode:
  /// - The function should accept a starting and ending vertex.
  /// - Create a map (distanceFromStart) to store the distance for each vertex (from the start point)
  ///   and add the starting vertex with a value of 0.
  /// - Create a map (shortestPrev) to store the shortest previous for each vertex (How we got to it)
  ///   and add the starting vertex with a value of null (no previous).
  /// - Create a PriorityQueue (verticesQueue) to make sure we always start with the smallest
  ///   vertex at the queue "check tests for more details on why we start with the smallest one"
  ///   and add the starting vertex with a priority of 0 because that's where we begin.
  /// - Start looping as long as there is anything in the priority queue:
  ///   - dequeue a vertex from the priority queue.
  ///   - If that vertex is null (no path to the ending vertex) - break.
  ///   - If that vertex is the same as the ending vertex (we're done) - break.
  ///   - Otherwise loop through each neighbor in the neighbors list of that vertex:
  ///     - Calculate the distance (newDistance) to the neighbor from the starting vertex.
  ///     - If the newDistance is less than what is currently stored in our distanceFromStart map:
  ///       - Update the distanceFromStart for the neighbor with the new lower distance.
  ///       - Update the shortestPrev for the neighbor to contain that vertex.
  ///       - Enqueue the neighbor with the newDistance (total distance from the start point).
  /// - Eventually, If we were able to reach the endVertex (its shortestPrev not null), loop over the shortestPrev
  ///   map's chain starting from the endVertex to the startVertex to get the shortest path and return it (reversed).
  List<T> dijkstra(T startVertex, T endVertex) {
    // if startVertex or endVertex doesn't exist, return empty list.
    if (!_adjacencyList.containsKey(startVertex) ||
        !_adjacencyList.containsKey(endVertex)) return [];

    final verticesQueue = PriorityQueue<T>()..enqueue(startVertex, 0);
    final Map<T, num> distanceFromStart = {startVertex: 0};
    final Map<T, T?> shortestPrev = {startVertex: null};
    final Set<T> visited = {};

    late T? vertex;
    while (true) {
      vertex = verticesQueue.dequeue();
      if (vertex == null || vertex == endVertex) break;
      visited.add(vertex);

      for (final neighbor in _adjacencyList[vertex]!) {
        final neighborVertex = neighbor.$1;
        final neighborWeight = neighbor.$2;
        // Early exit to skip the calculations if it is found in the visited map.
        // This is an optimization and not necessary because we would not enter
        // the if condition anyway as the newDistance will be greater than currentDistance.
        if (visited.contains(neighborVertex)) continue;

        // Calculate the new distance of the current neighbor (from the start)
        final prevVertexDistance = distanceFromStart[vertex] ?? 0;
        final currentDistance = distanceFromStart[neighborVertex];
        final newDistance = neighborWeight + prevVertexDistance;

        if (currentDistance == null || newDistance < currentDistance) {
          // Update neighbor's distanceFromStart and its shortest previous (How we got to neighbor).
          distanceFromStart[neighborVertex] = newDistance;
          shortestPrev[neighborVertex] = vertex;
          // Enqueue the neighbor with its newDistance as the priority.
          verticesQueue.enqueue(neighborVertex, newDistance);
        }
      }
    }

    if (shortestPrev[endVertex] == null) return [];

    final shortestPath = [endVertex];
    T? prevVertex = shortestPrev[endVertex];
    while (prevVertex != null) {
      shortestPath.add(prevVertex);
      prevVertex = shortestPrev[prevVertex];
    }
    return shortestPath.reversed.toList();
  }
}
