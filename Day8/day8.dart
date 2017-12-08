import 'dart:io';

void main() {
  new File('day8.txt').readAsString().then((String contents) {
    findMax(contents);
  });
}

void findMax(String puzzle) {
  num maxDuring = 0;
  Map<String, num> registers = new Map();
  for (String line in puzzle.split('\n')) {
    List<String> command = line.split(' ');
    registers.putIfAbsent(command[0], () => 0);
    int comp = registers.putIfAbsent(command[4], () => 0);
    bool cond = false;
    switch (command[5]) {
      case "<":
        if (comp < num.parse(command[6])) {
          cond = true;
        }
        break;
      case ">":
        if (comp > num.parse(command[6])) {
          cond = true;
        }
        break;
      case "<=":
        if (comp <= num.parse(command[6])) {
          cond = true;
        }
        break;
      case ">=":
        if (comp >= num.parse(command[6])) {
          cond = true;
        }
        break;
      case "==":
        if (comp == num.parse(command[6])) {
          cond = true;
        }
        break;
      case "!=":
        if (comp != num.parse(command[6])) {
          cond = true;
        }
        break;
    }
    if (cond) {
      if (command[1] == "inc") {
        registers[command[0]] += num.parse(command[2]);
        if (registers[command[0]] > maxDuring) {
          maxDuring = registers[command[0]];
        }
      } else {
        registers[command[0]] -= num.parse(command[2]);
      }
    }
  }
  num max = 0;
  registers.forEach((String reg, num val) {
    if (val > max) {
      max = val;
    }
  });
  print("Max During = $maxDuring");
  print("Max Final = $max");
}
