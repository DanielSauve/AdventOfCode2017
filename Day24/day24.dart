import 'dart:io';
import 'dart:math';

void main() {
  new File('day24.txt').readAsString().then(strongestBridge);
}

void strongestBridge(String puzzle) {
  List<List<int>> l = puzzle
      .split('\n')
      .map((String line) => line.split('/').map(int.parse).toList())
      .toList();
  int strongest = 0;
  Map<int, int> bridges = new Map();
  for (List<int> zero in l.where((List<int> pair) => pair.contains(0))) {
    strongest = max(strongest,
        recurse([zero], zero.firstWhere((int item) => item != 0), l, bridges));
  }
  int longest = bridges[bridges.keys.reduce((int a, b) => max(a, b))];
  print('Strongest: $strongest');
  print('Longest: $longest');
}

int recurse(
    List<List<int>> bridge, int lookingFor, List<List<int>> pieces, Map<int, int> bridges) {
  int strongest = 0;
  List<List<int>> possibilities = pieces
      .where((List<int> item) =>
          item.contains(lookingFor) && !bridge.contains(item))
      .toList();
  if (possibilities.length == 0) {
    bridges[bridge.length] = max(
        bridges.putIfAbsent(bridge.length, () => 0),
        bridge.fold(
            0,
                (int prev, List<int> item) =>
            prev += item.reduce((int a, b) => a + b)));
    return bridge.fold(0,
        (int prev, List<int> item) => prev += item.reduce((int a, b) => a + b));
  }
  for (List<int> possibility in possibilities) {
    int lf;
    try {
      lf = possibility.firstWhere((int item) => item != lookingFor);
    } catch (IterableElementError) {
      lf = possibility.first;
    }
    strongest = max(strongest,
        recurse(new List.from(bridge)..add(possibility), lf, pieces, bridges));
  }
  return strongest;
}