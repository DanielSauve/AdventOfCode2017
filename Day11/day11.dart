import 'dart:io';
import 'dart:math';

void main() {
  new File('day11.txt').readAsString().then((String contents) {
    print(shortestDistance(contents));
    print(furthestAway(contents));
  });
}

int shortestDistance(String puzzle) {
  Map<String, int> count = new Map();
  for (String step in puzzle.split(',')) {
    count.putIfAbsent(step, () => 0);
    count[step] += 1;
  }
  return balance(count['n'] - count['s'], count['ne'] - count['sw'],
      count['nw'] - count['se']);
}

int furthestAway(String puzzle) {
  int furthest = 0;
  int n = 0, nw = 0, ne = 0;
  for (String step in puzzle.split(',')) {
    switch (step) {
      case 'n':
        n += 1;
        break;
      case 'ne':
        ne += 1;
        break;
      case 'nw':
        nw += 1;
        break;
      case 's':
        n -= 1;
        break;
      case 'se':
        nw -= 1;
        break;
      case 'sw':
        ne -= 1;
        break;
    }
    furthest = max(balance(n, ne, nw), furthest);
  }
  return furthest;
}

/**
 * Cancel out logic for directions
 */
int balance(int n, int ne, int nw) {
  while (ne > 0 && nw > 0) {
    ne -= 1;
    nw -= 1;
    n += 1;
  }
  while (ne < 0 && nw < 0) {
    ne += 1;
    nw += 1;
    n -= 1;
  }
  while (ne < 0 && n > 0) {
    nw += 1;
    ne += 1;
    n -= 1;
  }
  while (ne > 0 && n < 0) {
    nw -= 1;
    ne -= 1;
    n += 1;
  }
  while (nw < 0 && n > 0) {
    nw += 1;
    ne += 1;
    n -= 1;
  }
  while (nw > 0 && n < 0) {
    nw -= 1;
    ne -= 1;
    n += 1;
  }
  return n.abs() + ne.abs() + nw.abs();
}
