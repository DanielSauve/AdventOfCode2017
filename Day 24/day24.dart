import 'dart:io';
import 'dart:math';

void main() {
  new File('day24.txt').readAsString().then((String contents) {
    print(strongestBridge(contents));
    print(longestBridge(contents));
  });
}

int strongestBridge(String puzzle) {
  List<List<int>> l = puzzle
      .split('\n')
      .map((String line) => line.split('/').map(int.parse).toList())
      .toList();
  int strongest = 0;
  for (List<int> zero in l.where((List<int> pair) => pair.contains(0))) {
    strongest = max(strongest,
        recurseStrength([zero], zero.firstWhere((int item) => item != 0), l));
  }
  return strongest;
}

int recurseStrength(
    List<List<int>> bridge, int lookingFor, List<List<int>> pieces) {
  int strongest = 0;
  List<List<int>> possibilities = pieces
      .where((List<int> item) =>
          item.contains(lookingFor) && !bridge.contains(item))
      .toList();
  if (possibilities.length == 0) {
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
        recurseStrength(new List.from(bridge)..add(possibility), lf, pieces));
  }
  return strongest;
}

int longestBridge(String puzzle) {
  List<List<int>> l = puzzle
      .split('\n')
      .map((String line) => line.split('/').map(int.parse).toList())
      .toList();
  Map<int, int> possibilities = new Map();
  for (List<int> zero in l.where((List<int> pair) => pair.contains(0))) {
    recurseLength(
        [zero], zero.firstWhere((int item) => item != 0), l, possibilities);
  }
  return possibilities[possibilities.keys.reduce((int a, b) => max(a, b))];
}

void recurseLength(List<List<int>> bridge, int lookingFor,
    List<List<int>> pieces, Map<int, int> bridges) {
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
    return;
  }
  for (List<int> possibility in possibilities) {
    int lf;
    try {
      lf = possibility.firstWhere((int item) => item != lookingFor);
    } catch (IterableElementError) {
      lf = possibility.first;
    }
    recurseLength(new List.from(bridge)..add(possibility), lf, pieces, bridges);
  }
}
