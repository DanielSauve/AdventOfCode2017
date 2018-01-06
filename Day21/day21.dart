import 'dart:io';

void main() {
  new File('day21.txt').readAsString().then((String contents) {
    print(doTheThing(contents));
  });
}

int doTheThing(String puzzle) {
  Map<String, List<List<String>>> input = new Map();
  for (String line in puzzle.split('\n')) {
    List<String> parts = line.split(' => ');
    List<List<String>> from =
        parts[0].split('/').map((String s) => s.split('')).toList();
    List<List<String>> to =
        parts[1].split('/').map((String s) => s.split('')).toList();
    input[listToString(from)] = to;
    input[listToString(horizontalFlip(from))] = to;
    input[listToString(verticalFlip(from))] = to;
    for (int i = 0; i < 3; i++) {
      from = rotate(from);
      input[listToString(from)] = to;
      input[listToString(horizontalFlip(from))] = to;
      input[listToString(verticalFlip(from))] = to;
    }
  }
  List<List<String>> start = [
    ['.', '#', '.'],
    ['.', '.', '#'],
    ['#', '#', '#']
  ];
  for (int i = 0; i < 5; i++) {
    if (start.length % 2 == 0) {
      int numChunks = start.length * start.length ~/ 4;
      int chunksPerRow = start.length ~/ 2;
      List<List<List<String>>> chunks = new List();
      while (chunks.length < numChunks) {
        for (int j = 0; j < start.length; j += 2) {
          for (int k = 0; k < start[j].length; k += 2) {
            List<List<String>> chunk = new List();
            chunk.add(start[j].getRange(k, k + 2));
            chunk.add(start[j + 1].getRange(k, k + 2));
            chunk = input[listToString(chunk)];
            chunks.add(chunk);
          }
        }
      }
    } else {
      int numChunks = start.length * start.length ~/ 9;
      int chunksPerRow = start.length ~/ 3;
      List<List<List<String>>> chunks = new List();
      while (chunks.length < numChunks) {
        for (int j = 0; j < start.length; j += 3) {
          for (int k = 0; k < start[j].length; k += 3) {
            List<List<String>> chunk = new List();
            chunk.add(start[j].getRange(k, k + 3));
            chunk.add(start[j + 1].getRange(k, k + 3));
            chunk.add(start[j + 2].getRange(k, k + 3));
            chunk = input[listToString(chunk)];
            chunks.add(chunk);
          }
        }
      }
    }
  }
  return start.fold(
      0,
      (int a, List<String> line) =>
          a + line.fold(0, (int b, String s) => s == '#' ? b + 1 : b));
}

List<List<String>> rotate(List<List<String>> toRotate) {
  if (toRotate.length == 2) {
    List<List<String>> ret = new List.generate(2, (_) => new List(2));
    ret[0][0] = toRotate[1][0];
    ret[0][1] = toRotate[0][0];
    ret[1][0] = toRotate[1][1];
    ret[1][1] = toRotate[0][1];
    return ret;
  } else {
    List<List<String>> ret = new List.generate(3, (_) => new List(3));
    ret[0][0] = toRotate[2][0];
    ret[0][1] = toRotate[1][0];
    ret[0][2] = toRotate[0][0];
    ret[1][0] = toRotate[2][1];
    ret[1][1] = toRotate[1][1];
    ret[1][2] = toRotate[0][1];
    ret[2][0] = toRotate[2][2];
    ret[2][1] = toRotate[1][2];
    ret[2][2] = toRotate[0][2];
    return ret;
  }
}

List<List<String>> verticalFlip(List<List<String>> toFlip) {
  return toFlip.reversed.toList();
}

List<List<String>> horizontalFlip(List<List<String>> toFlip) {
  return toFlip.map((List<String> row) => row.reversed.toList()).toList();
}

String listToString(List<List<String>> list) {
  if (list.length == 2) {
    return list[0].join('') + '/' + list[1].join('');
  } else {
    return list[0].join('') + '/' + list[1].join('') + '/' + list[2].join('');
  }
}
