import 'dart:io';

void main() {
  new File('day25.txt').readAsString().then((String contents) {
    print(checksum(contents));
  });
}

int checksum(String puzzle) {
  List<int> tape = new List();
  tape.add(0);
  int curr = 0;
  List<String> lines = puzzle.split('\n');
  String state = lines[0].substring(15, 16);
  int loops = int.parse(lines[1].split(' ')[5]);
  Map<String, State> states = new Map();
  for (int i = 3; i < lines.length; i += 10) {
    String name = lines[i].substring(9, 10);
    int zeroWrite = int.parse(lines[i + 2].substring(22, 23));
    int oneWrite = int.parse(lines[i + 6].substring(22, 23));
    int zeroMove = lines[i + 3].contains('right') ? 1 : -1;
    int oneMove = lines[i + 7].contains('right') ? 1 : -1;
    String zeroNext = lines[i + 4].substring(26, 27);
    String oneNext = lines[i + 8].substring(26, 27);
    states[name] =
        new State(zeroMove, zeroWrite, zeroNext, oneMove, oneWrite, oneNext);
  }
  for (int i = 0; i < loops; i++) {
    if (tape[curr]== 0) {
      tape[curr] = states[state].zeroWrite;
      state = states[state].zeroNextState;
      if (curr == 0 && states[state].zeroMove == -1) {
        tape.insert(0, 0);
      } else if (curr == tape.length - 1 && states[state].zeroMove == 1) {
        tape.add(0);
        curr += 1;
      } else {
        curr += states[state].zeroMove;
      }
    } else {
      tape[curr] = states[state].oneWrite;
      state = states[state].oneNextState;
      if (curr == 0 && states[state].oneMove == -1) {
        tape.insert(0, 0);
      } else if (curr == tape.length - 1 && states[state].oneMove == 1) {
        tape.add(0);
        curr += 1;
      } else {
        curr += states[state].oneMove;
      }
    }
  }
  print(tape);
  return tape.reduce((int a, b) => a + b);
}

class State {
  int zeroMove, zeroWrite, oneMove, oneWrite;
  String zeroNextState, oneNextState;
  State(this.zeroMove, this.zeroWrite, this.zeroNextState, this.oneMove,
      this.oneWrite, this.oneNextState);
}
