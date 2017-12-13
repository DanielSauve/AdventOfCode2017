import 'dart:io';

void main() {
  new File('day12.txt').readAsString().then((String contents) {
    print(programCount(contents));
    print(groupCount(contents));
  });
}

int programCount(String puzzle) {
  Map<int, List<int>> programs = new Map();
  for (String line in puzzle.split('\n')) {
    List<String> prog = line.split('<->');
    programs.putIfAbsent(
        int.parse(prog[0]), () => prog[1].split(',').map(int.parse));
  }
  Set<int> connected = new Set()..add(0);
  List<int> toExplore = new List()..add(0);
  while (toExplore.isNotEmpty) {
    int item = toExplore.removeAt(0);
    List toAdd = programs[item].toList();
    for (int i in toAdd) {
      if (!connected.contains(i)) {
        toExplore.add(i);
        connected.add(i);
      }
    }
  }
  return connected.length;
}

int groupCount(String puzzle) {
  Map<int, List<int>> programs = new Map();
  for (String line in puzzle.split('\n')) {
    List<String> prog = line.split('<->');
    programs.putIfAbsent(
        int.parse(prog[0]), () => prog[1].split(',').map(int.parse));
  }
  int groupCount = 0;
  while (programs.isNotEmpty) {
    Set<int> connected = new Set()..add(programs.keys.first);
    List<int> toExplore = new List()..add(programs.keys.first);
    while (toExplore.isNotEmpty) {
      int item = toExplore.removeAt(0);
      List toAdd = programs[item].toList();
      for (int i in toAdd) {
        if (!connected.contains(i)) {
          toExplore.add(i);
          connected.add(i);
        }
      }
    }
    connected.forEach((int i) => programs.remove(i));
    groupCount += 1;
  }
  return groupCount;
}
