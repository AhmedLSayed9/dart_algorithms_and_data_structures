import 'package:test/test.dart';

/// Note: Hash Tables (Hash Maps) can be implemented as linear or non-linear data structure.
/// Often, they are implemented as a linear data structure using arrays.
///
/// Dart's different built-in hash maps and the default one:
/// https://stackoverflow.com/questions/49224999/does-dart-automatically-determine-which-map-type-to-use

/// The prime number in the hash is helpful in spreading out the keys more uniformly.
/// It's also helpful if the array that you're putting values into has a prime length.
/// You don't need to know why, but here are some sources:
/// https://computinglife.wordpress.com/2008/11/20/why-do-hash-functions-use-prime-numbers
/// https://www.quora.com/Does-making-array-size-a-prime-number-help-in-hash-table-implementation-Why
const _mapLength = 53;

/// Internal class to store each key-value pair
class Entry<K, V> {
  Entry(this.key, this.value);

  final K key;
  V value;
}

class HashMap<K, V> {
  /// Internal list to store the keys and values via separate chaining
  final _table = List<List<Entry<K, V>>?>.filled(_mapLength, null);

  /// Loops through the hash table array and returns an array of keys in the table
  List<K> keys() {
    List<K> keys = [];
    for (final entryList in _table) {
      entryList?.forEach((entry) {
        keys.add(entry.key);
      });
    }
    return keys;
  }

  /// Loops through the hash table array and returns an array of values in the table
  List<V> values() {
    List<V> values = [];
    for (final entryList in _table) {
      entryList?.forEach((entry) {
        values.add(entry.value);
      });
    }
    return values;
  }

  /// Pseudocode:
  /// - Accepts a key and a value.
  /// - Hashes the key.
  /// - Stores the key-value pair in the hash table array via separate chaining.
  /// - Note: If the key-value pair is already there, override the value and return.
  void set(K key, V value) {
    final index = _hash(key);
    final entry = Entry(key, value);

    if (_table[index] case final entryList?) {
      //check if any entry at that index has the same key.
      for (final entry in entryList) {
        if (entry.key == key) {
          entry.value = value;
          return;
        }
      }
      entryList.add(entry);
    } else {
      _table[index] = [entry];
    }
  }

  /// Pseudocode:
  /// - Accepts a key.
  /// - Hashes the key.
  /// - Retrieves the key-value pair in the hash table and return the value.
  /// - If the key isn't found, returns null.
  V? get(K key) {
    final index = _hash(key);
    if (_table[index] case final entryList?) {
      for (final entry in entryList) {
        if (entry.key == key) return entry.value;
      }
    }
    return null;
  }

  int _hash(K key) {
    return key.hashCode % _table.length;
    /*
    //Manual hash that works on strings only
    int total = 0;
    const prime = 31;
    for (int i = 0; i < math.min(key.length, 100); i++) {
      final value = key.codeUnitAt(i) - 96;
      total = ((total * prime) + value) % _table.length;
    }
    return total;
    */
  }
}

void main() {
  test('should add entries to the HashMap and retrieve with the key', () {
    final map = HashMap();

    map.set(1, 'Ahmed');
    map.set(2, 'ElSayed');
    map.set('stringKey', 'Dart');

    expect(map.get(1), 'Ahmed');
    expect(map.get(2), 'ElSayed');
    expect(map.get(3), null);
    expect(map.get('stringKey'), 'Dart');
  });

  test('should override the value when adding entry with an existing key', () {
    final map = HashMap();

    map.set(1, 'Ahmed');
    expect(map.get(1), 'Ahmed');

    map.set(1, 'ElSayed');
    expect(map.get(1), 'ElSayed');
    expect(map.keys(), [1]);
    expect(map.values(), ['ElSayed']);
  });

  test('should retrieve all keys/values of the map', () {
    final map = HashMap();

    map.set(1, 'Ahmed');
    map.set(2, 'ElSayed');
    map.set(3, 3);
    map.set('stringKey', 'Dart');

    expect(map.keys(), ['stringKey', 3, 2, 1]);
    expect(map.values(), ['Dart', 3, 'ElSayed', 'Ahmed']);
  });
}
