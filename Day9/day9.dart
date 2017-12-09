import 'dart:io';

void main() {
  new File('day9.txt').readAsString().then((String contents) {
    print(calculateScore(contents));
    print(countGarbage(contents));
  });
}

int calculateScore(String puzzle) {
  puzzle = puzzle.replaceAll(new RegExp(r'!.'), '');
  int current = 0;
  int total = 0;
  bool garbage = false;
  for (String c in puzzle.split('')) {
    if (garbage) {
      if (c == ">") {
        garbage = false;
      }
      continue;
    }
    switch (c) {
      case "{":
        current += 1;
        total += current;
        break;
      case "}":
        current -= 1;
        break;
      case "<":
        garbage = true;
        break;
    }
  }
  return total;
}

int countGarbage(String puzzle) {
  puzzle = puzzle.replaceAll(new RegExp(r'!.'), '');
  int total = 0;
  bool garbage = false;
  for (String c in puzzle.split('')) {
    if (garbage) {
      if (c == ">") {
        garbage = false;
      } else {
        total += 1;
      }
      continue;
    }
    if (c == "<") {
      garbage = true;
    }
  }
  return total;
}
