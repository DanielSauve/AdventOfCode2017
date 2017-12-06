void main() {
  int puzzle = 289326;
  print(manhattan(puzzle));
  print(largestPast(puzzle));
}

int manhattan(int input) {
  int lr = 0;
  int ud = 0;
  int width = 0;
  int height = 0;
  int curr = 1;
  while (curr < input) {
    width += 1;
    height += 1;
    while (lr != width) {
      if (curr == input) {
        break;
      }
      curr += 1;
      lr += 1;
    }
    while (ud != height) {
      if (curr == input) {
        break;
      }
      curr += 1;
      ud += 1;
    }
    while (-lr != width) {
      if (curr == input) {
        break;
      }
      curr += 1;
      lr -= 1;
    }
    while (-ud != height) {
      if (curr == input) {
        break;
      }
      curr += 1;
      ud -= 1;
    }
  }
  return lr.abs() + ud.abs();
}

int largestPast(int input) {
  List<List<int>> array =
      new List.generate(1024, (_) => new List<int>.filled(1024, 0));
  int x = 511;
  int y = 511;
  array[x][y] = 1;
  int height = 0, width = 0;
  while (true) {
    width += 1;
    height += 1;
    while (x - 511 != width) {
      x += 1;
      array[x][y] = array[x - 1][y - 1] +
          array[x][y - 1] +
          array[x + 1][y - 1] +
          array[x - 1][y] +
          array[x][y] +
          array[x + 1][y] +
          array[x - 1][y + 1] +
          array[x][y + 1] +
          array[x + 1][y + 1];
      if (array[x][y] > input){
        return array[x][y];
      }
    }
    while (y - 511 != height) {
      y += 1;
      array[x][y] = array[x - 1][y - 1] +
          array[x][y - 1] +
          array[x + 1][y - 1] +
          array[x - 1][y] +
          array[x][y] +
          array[x + 1][y] +
          array[x - 1][y + 1] +
          array[x][y + 1] +
          array[x + 1][y + 1];
      if (array[x][y] > input){
        return array[x][y];
      }
    }
    while (-x + 511 != width) {
      x -= 1;
      array[x][y] = array[x - 1][y - 1] +
          array[x][y - 1] +
          array[x + 1][y - 1] +
          array[x - 1][y] +
          array[x][y] +
          array[x + 1][y] +
          array[x - 1][y + 1] +
          array[x][y + 1] +
          array[x + 1][y + 1];
      if (array[x][y] > input){
        return array[x][y];
      }
    }
    while (-y + 511 != height) {
      y -= 1;
      array[x][y] = array[x - 1][y - 1] +
          array[x][y - 1] +
          array[x + 1][y - 1] +
          array[x - 1][y] +
          array[x][y] +
          array[x + 1][y] +
          array[x - 1][y + 1] +
          array[x][y + 1] +
          array[x + 1][y + 1];
      if (array[x][y] > input){
        return array[x][y];
      }
    }
  }
}
