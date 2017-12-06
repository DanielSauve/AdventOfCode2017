import 'dart:io';

void main() {
  new File('day2.txt').readAsString().then((String contents) {
    print(checksum(contents));
    print(divideChecksum(contents));
  });
}

int checksum(String input) {
  int sum = 0;
  for (var row in input.split('\n')) {
    List<int> l = row.split('\t').map((String num) => int.parse(num)).toList();
    int max = l[0];
    int min = l[0];
    for (var n in l.skip(1)) {
      if (max == -1) {
        max = n;
      }
      if (min == -1) {
        min = n;
      }
      if (max < n) {
        max = n;
      }
      if (min > n) {
        min = n;
      }
    }
    sum += max - min;
  }
  return sum;
}

int divideChecksum(String input) {
  int sum = 0;
  for (var row in input.split('\n')) {
    List<int> l = row.split('\t').map((String num) => int.parse(num)).toList()
      ..sort();
    for (int i = 0; i < l.length - 1; i++) {
      bool found = false;
      for (int j = i + 1; j < l.length; j++) {
        if (l[j] % l[i] == 0) {
          sum += l[j] ~/ l[i];
          found = true;
          break;
        }
      }
      if (found) {
        break;
      }
    }
  }
  return sum;
}
