import 'dart:io';

void main() {
  new File('day5.txt').readAsString().then((String contents) {
    print(countJumps(contents));
    print(countJumps2(contents));
  });
}

int countJumps(String puzzle) {
  List<int> li = puzzle.split('\n').map((String s) => int.parse(s)).toList();
  int pc = 0, jumps = 0;
  while (pc >= 0 && pc < li.length) {
    int temp = li[pc];
    li[pc] += 1;
    pc += temp;
    jumps += 1;
  }
  return jumps;
}

int countJumps2(String puzzle) {
  List<int> li = puzzle.split('\n').map((String s) => int.parse(s)).toList();
  int pc = 0, jumps = 0;
  while (pc >= 0 && pc < li.length) {
    int temp = li[pc];
    temp < 3 ? li[pc] += 1 : li[pc] -= 1;
    pc += temp;
    jumps += 1;
  }
  return jumps;
}
