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
  int reallocations = 0;
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
    reallocations += 1;
  }
  return reallocations;
}

int loopSize(String puzzle) {
  List<int> banks = puzzle.split('\t').map(int.parse).toList();
  int reallocations = 0;
  Map<String, int> seen = new Map();
  while (seen.putIfAbsent(banks.toString(), () => reallocations) == reallocations) {
    int val = banks.reduce(max);
    int index = banks.indexOf(val);
    banks[index] = 0;
    while (val > 0) {
      index = (index + 1) % banks.length;
      banks[index] += 1;
      val--;
    }
    reallocations += 1;
  }
  return reallocations - seen[banks.toString()];
}
