import 'dart:io';

void main() {
  new File('day10.txt').readAsString().then((String contents) {
    print(multiplyFirstTwo(contents));
    print(denseHash(contents));
  });
}

int multiplyFirstTwo(String puzzle) {
  List<num> list = new List.generate(256, (int index) => index);
  int curr = 0, skip = 0;
  for (int instruction in puzzle.split(',').map(int.parse)) {
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
  return list[0] * list[1];
}

String denseHash(String puzzle) {
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
