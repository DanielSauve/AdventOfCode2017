void main() {
  int puzzle = 344;
  print(numberAfter(puzzle));
  print(numberAfterZero(puzzle));
}

int numberAfter(int puzzle) {
  List<int> cyclone = [0];
  int index = 0;
  for (int i = 1; i <= 2017; i++) {
    index = (index + puzzle) % i + 1;
    cyclone.insert(index, i);
  }
  return cyclone[index + 1];
}

int numberAfterZero(int puzzle) {
  int index = 0, last = -1;
  for (int i = 1; i <= 50000000; i++) {
    index = (index + puzzle) % i + 1;
    if (index == 1) {
      last = i;
    }
  }
  return last;
}
