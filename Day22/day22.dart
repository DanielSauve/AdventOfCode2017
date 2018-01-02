import 'dart:io';

void main() {
  new File('day22.txt').readAsString().then((String contents) {
    print(countInfections(contents));
    print(countInfectionsEvolved(contents));
  });
}

int countInfections(String puzzle) {
  List<List<int>> map = puzzle
      .split('\n')
      .map((String line) =>
          line.split('').map((String c) => c == '.' ? 0 : 1).toList())
      .toList();
  int i = map.length ~/ 2, j = map[i].length ~/ 2, count = 0, dir = 0;
  for (int z = 0; z < 10000; z++) {
    if (map[i][j] % 2 == 0) {
      count += 1;
    }
    dir = map[i][j] % 2 == 0 ? (dir - 1) % 4 : (dir + 1) % 4;
    map[i][j] += 1;
    switch (dir) {
      case 0:
        i -= 1;
        break;
      case 1:
        j += 1;
        break;
      case 2:
        i += 1;
        break;
      case 3:
        j -= 1;
        break;
    }
    if (i == map.length) {
      map.add(new List.generate(map[0].length, (int _) => 0));
    } else if (i < 0) {
      map.insert(0, new List.generate(map[0].length, (int _) => 0));
      i = 0;
    }
    if (j == map[i].length) {
      map.forEach((List<int> l) => l.add(0));
    } else if (j < 0) {
      map.forEach((List<int> l) => l.insert(0, 0));
      j = 0;
    }
  }
  return count;
}

int countInfectionsEvolved(String puzzle) {
  List<List<int>> map = puzzle
      .split('\n')
      .map((String line) =>
          line.split('').map((String c) => c == '.' ? 0 : 2).toList())
      .toList();
  int i = map.length ~/ 2, j = map[i].length ~/ 2, count = 0, dir = 0;
  for (int z = 0; z < 10000000; z++) {
    switch (map[i][j]) {
      case 0:
        dir = (dir - 1) % 4;
        break;
      case 1:
        count += 1;
        break;
      case 2:
        dir = (dir + 1) % 4;
        break;
      case 3:
        dir = (dir + 2) % 4;
        break;
    }
    map[i][j] = (map[i][j] + 1) % 4;
    switch (dir) {
      case 0:
        i -= 1;
        break;
      case 1:
        j += 1;
        break;
      case 2:
        i += 1;
        break;
      case 3:
        j -= 1;
        break;
    }
    if (i == map.length) {
      map.add(new List.generate(map[0].length, (int _) => 0));
    } else if (i < 0) {
      map.insert(0, new List.generate(map[0].length, (int _) => 0));
      i = 0;
    }
    if (j == map[i].length) {
      map.forEach((List<int> l) => l.add(0));
    } else if (j < 0) {
      map.forEach((List<int> l) => l.insert(0, 0));
      j = 0;
    }
  }
  return count;
}
