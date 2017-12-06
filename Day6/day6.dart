import 'dart:io';
import 'dart:math';

void main() {
  new File('day6.txt').readAsString().then((String contents) {
    print(reallocate(contents));
    print(loopSize(contents));
  });
}

int reallocate(String puzzle) {
  List<int> banks = puzzle.split('\t').map(int.parse).toList();
  Set<String> seen = new Set();
  while (seen.add(banks.toString())) {
    int val = banks.reduce(max);
    int index = banks.indexOf(val);
    banks[index] = 0;
    while (val > 0) {
      index = (index + 1) % banks.length;
      banks[index] += 1;
      val--;
    }
  }
  return seen.length;
}

int loopSize(String puzzle) {
  List<int> banks = puzzle.split('\t').map(int.parse).toList();
  Map<String, int> seen = new Map();
  while (seen.putIfAbsent(banks.toString(), () => seen.length) == seen.length - 1) {
    int val = banks.reduce(max);
    int index = banks.indexOf(val);
    banks[index] = 0;
    while (val > 0) {
      index = (index + 1) % banks.length;
      banks[index] += 1;
      val--;
    }
  }
  return seen.length - seen[banks.toString()];
}
