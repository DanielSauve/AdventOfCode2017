void main() {
  int a = 116;
  int b = 299;
  print(part1(a, b));
  print(part2(a, b));
}

int part1(int a, int b) {
  int count = 0;
  for (int i = 0; i < 40000000; i++) {
    a = (a * 16807) % 2147483647;
    b = (b * 48271) % 2147483647;
    if (a & 0xffff == b & 0xffff) {
      count += 1;
    }
  }
  return count;
}

int part2(int a, int b) {
  int count = 0;
  for (int i = 0; i < 5000000; i++) {
    a = (a * 16807) % 2147483647;
    b = (b * 48271) % 2147483647;
    while (a % 4 != 0) {
      a = (a * 16807) % 2147483647;
    }
    while (b % 8 != 0) {
      b = (b * 48271) % 2147483647;
    }
    if (a & 0xffff == b & 0xffff) {
      count += 1;
    }
  }
  return count;
}
