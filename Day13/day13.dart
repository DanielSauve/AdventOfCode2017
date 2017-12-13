import 'dart:io';
import 'dart:math';

void main() {
  new File('day13.txt').readAsString().then((String contents) {
    print(severity(contents));
    print(delay(contents));
  });
}

int severity(String puzzle) {
  Map<int, int> firewall = new Map();
  int end = -1;
  for (String line in puzzle.split('\n')) {
    List<int> layer = line.split(':').map(int.parse).toList();
    firewall[layer[0]] = layer[1];
    end = max(end, layer[0]);
  }
  int severity = 0;
  firewall.forEach((int key, int val) {
    if (key % (2 * (val - 1)) == 0) {
      severity += key * val;
    }
  });
  return severity;
}

int delay(String puzzle) {
  Map<int, int> firewall = new Map();
  int end = -1;
  for (String line in puzzle.split('\n')) {
    List<int> layer = line.split(':').map(int.parse).toList();
    firewall[layer[0]] = layer[1];
    end = max(end, layer[0]);
  }
  int delay = 0;
  bool caught = true;
  while (caught) {
    delay += 1;
    caught = false;
    firewall.forEach((int key, int val) {
      if ((delay + key) % (2 * (val - 1)) == 0) {
        caught = true;
      }
    });
  }
  return delay;
}
