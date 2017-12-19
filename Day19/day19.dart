import 'dart:io';

void main() {
  new File('day19.txt').readAsString().then((String contents) {
    passedSteps(contents);
  });
}

void passedSteps(String puzzle) {
  List<String> seen = new List();
  List<List<String>> map = puzzle.split('\n').map((String line) => line.split('')).toList();
  int steps = 0;
  int i = 0;
  int j = map[i].indexOf('|');
  int lr = 0, ud = 1;
  while (true) {
    steps += 1;
    i += ud;
    j += lr;
    String curr = map[i][j];
    if (curr == '+') {
      if (lr != 0) {
        lr = 0;
        if (i != map.length - 1 && j < map[i + 1].length && map[i + 1][j] != ' ') {
          ud = 1;
        } else {
          ud = -1;
        }
      }
      else if (ud != 0) {
        ud = 0;
        if (j != map[i].length - 1 && map[i][j + 1] != ' ') {
          lr = 1;
        } else {
          lr = -1;
        }
      }
    } else if (curr == '|' || curr == '-') {
      continue;
    } else if (curr == ' ') {
      break;
    } else {
      seen.add(curr);
    }
  }
  String s = seen.join('');
  print('Seen nodes $s');
  print('Steps taken: $steps');
}