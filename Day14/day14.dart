void main() {
  String puzzle = 'wenycdww';
  print(countBits(puzzle));
  print(countRegions(puzzle));
}

int countBits(String puzzle) {
  int count = 0;
  for (int i = 0; i < 128; i++) {
    String hash = int
        .parse(knotHash(puzzle + '-' + i.toString()), radix: 16)
        .toRadixString(2);
    for (String n in hash.split('')) {
      if (n == '1') {
        count += 1;
      }
    }
  }
  return count;
}

int countRegions(String puzzle) {
  int regions = 1;
  Set reg = new Set();
  List<List<int>> disk = new List.generate(128, (int _) => new List());

  for (int i = 0; i < 128; i++) {
    String hash = int
        .parse(knotHash(puzzle + '-' + i.toString()), radix: 16)
        .toRadixString(2)
        .padLeft(128, '0');
    for (String n in hash.split('')) {
      disk[i].add(-int.parse(n));
    }
  }
  for (int i = 0; i < 128; i++) {
    for (int j = 0; j < 128; j++) {
      if (disk[i][j] == 0) {
        continue;
      }
      if (i != 0 && disk[i - 1][j] > 0) {
        disk[i][j] = disk[i - 1][j];
      }
      if (j != 0 && disk[i][j - 1] > 0) {
        if (disk[i][j] > 0) {
          replaceAll(disk, disk[i][j - 1], disk[i][j]);
        } else {
          disk[i][j] = disk[i][j - 1];
        }
      }
      if (j != 127 && disk[i][j + 1] > 0) {
        if (disk[i][j] > 0) {
          replaceAll(disk, disk[i][j + 1], disk[i][j]);
        } else {
          disk[i][j] = disk[i][j + 1];
        }
      }
      if (i != 127 && disk[i + 1][j] > 0) {
        if (disk[i][j] > 0) {
          replaceAll(disk, disk[i + 1][j], disk[i][j]);
        } else {
          disk[i][j] = disk[i + 1][j];
        }
      }
      if (disk[i][j] < 0) {
        disk[i][j] = regions;
        regions += 1;
      }
    }
  }
  for (List row in disk) {
    for (int item in row) {
      reg.add(item);
    }
  }
  return reg.length - 1;
}

void replaceAll(List<List<int>> disk, int from, int to) {
  for (int i = 0; i < 128; i++){
    for (int j = 0; j < 128; j++){
      if (disk[i][j] == from){
        disk[i][j] = to;
      }
    }
  }
}

String knotHash(String puzzle) {
  List<int> list = new List.generate(256, (int index) => index);
  int curr = 0, skip = 0;
  String ret = '';
  for (int j = 0; j < 64; j++) {
    for (int instruction in puzzle.codeUnits.toList()
      ..addAll([17, 31, 73, 47, 23])) {
      int end = curr + instruction;
      List<num> toReverse = new List();
      for (int i = curr; i < end; i++) {
        toReverse.add(list[i % 256]);
      }
      for (int i = curr; i < end; i++) {
        list[i % 256] = toReverse.removeLast();
      }
      curr = (curr + instruction + skip) % 256;
      skip += 1;
    }
  }
  int i = 0;
  while (i < list.length) {
    int end = i + 16;
    int chunk = 0;
    while (i < end) {
      chunk ^= list[i++];
    }
    ret += chunk.toRadixString(16).padLeft(2, '0');
  }
  return ret;
}
