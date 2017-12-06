import 'dart:io';

void main() {
  new File('day6.txt').readAsString().then((String contents) {
    print(reallocate(contents));
  });
}

int reallocate(String puzzle){
  List<int> banks = puzzle.split('\t').map(int.parse).toList();
  int reallocations = 0;
  Set<String> seen = new Set();
  while (seen.add(banks.toString())) {

  }
}