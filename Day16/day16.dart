import 'dart:io';

void main() {
  new File('day16.txt').readAsString().then((String contents) {
    print(dance(contents, 'abcdefghijklmnop'.split('')));
    print(billionDances(contents));
  });
}

String dance(String puzzle, List<String> programs) {
  for (String instruction in puzzle.split(',')) {
    switch (instruction[0]) {
      case 's':
        List<String> newP = new List();
        int i = 16 - int.parse(instruction.split('s')[1]);
        int j = i;
        while (i < 16) {
          newP.add(programs[i]);
          i++;
        }
        for (int i = 0; i < j; i++) {
          newP.add(programs[i]);
        }
        programs = newP;
        break;
      case 'x':
        List<String> toSwap = instruction.split('x')[1].split('/');
        int first = int.parse(toSwap[0]);
        int second = int.parse(toSwap[1]);
        String temp = programs[first];
        programs[first] = programs[second];
        programs[second] = temp;
        break;
      case 'p':
        List<String> toSwap = instruction.substring(1).split('/');
        int i = programs.indexOf(toSwap[0]);
        int j = programs.indexOf(toSwap[1]);
        programs[i] = toSwap[1];
        programs[j] = toSwap[0];
        break;
    }
  }
  return programs.join('');
}

String billionDances(String puzzle) {
  String programs = 'abcdefghijklmnop';
  Map<String, int> seen = new Map();
  seen.putIfAbsent(programs, () => 0);
  int i = 1;
  while (i <= 1000000000) {
    programs = dance(puzzle, programs.split(''));
    if (seen.putIfAbsent(programs, () => i) != i) {
      break;
    }
    i++;
  }
  int val = 1000000000 % i;
  for (String key in seen.keys) {
    if (seen[key] == val) {
      return key;
    }
  }
  return programs;
}