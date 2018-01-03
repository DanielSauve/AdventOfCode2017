import 'dart:io';

void main() {
  new File('day20.txt').readAsString().then((String contents) {
    print(closestToOrigin(contents));
  });
}

int closestToOrigin(String puzzle) {
  List<String> lines = puzzle.split('\n');
  int count = 0;
  double minAcc = double.INFINITY, minVel = double.INFINITY, minPos = double.INFINITY;
  int min = -1;
  for (String particle in lines) {
    List<String> c = particle
        .split(', ')
        .map((String s) => s.replaceAll(new RegExp('[pva=<>]'), ''))
        .toList();
    double pos = c[0].split(',').map(double.parse).reduce((double a, b) => a.abs() + b.abs());
    double vel = c[1].split(',').map(double.parse).reduce((double a, b) => a.abs() + b.abs());
    double acc = c[2].split(',').map(double.parse).reduce((double a, b) => a.abs() + b.abs());
    if (acc < minAcc) {
      minAcc = acc;
      minVel = double.INFINITY;
      minPos = double.INFINITY;
      min = count;
    } else if (acc == minAcc && vel < minVel) {
      minVel = vel;
      minPos = double.INFINITY;
      min = count;
    } else if (acc == minAcc && vel == minVel && pos < minPos) {
      minPos = pos;
      min = count;
    }
    count++;
  }
  return min;
}
