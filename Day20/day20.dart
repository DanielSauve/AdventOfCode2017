import 'dart:io';

void main() {
  new File('day20.txt').readAsString().then((String contents) {
    print(closestToOrigin(contents));
    print(remainingParticles(contents));
  });
}

int closestToOrigin(String puzzle) {
  List<String> lines = puzzle.split('\n');
  int count = 0;
  double minAcc = double.INFINITY,
      minVel = double.INFINITY,
      minPos = double.INFINITY;
  int min = -1;
  for (String particle in lines) {
    List<String> c = particle
        .split(', ')
        .map((String s) => s.replaceAll(new RegExp('[pva=<>]'), ''))
        .toList();
    double pos = c[0]
        .split(',')
        .map(double.parse)
        .reduce((double a, b) => a.abs() + b.abs());
    double vel = c[1]
        .split(',')
        .map(double.parse)
        .reduce((double a, b) => a.abs() + b.abs());
    double acc = c[2]
        .split(',')
        .map(double.parse)
        .reduce((double a, b) => a.abs() + b.abs());
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

int remainingParticles(String puzzle) {
  List<String> lines = puzzle.split('\n');
  List<List<List<int>>> particles = new List();
  for (String particle in lines) {
    List<String> c = particle
        .split(', ')
        .map((String s) => s.replaceAll(new RegExp('[pva=<>]'), ''))
        .toList();
    List<int> pos = c[0].split(',').map(int.parse).toList();
    List<int> vel = c[1].split(',').map(int.parse).toList();
    List<int> acc = c[2].split(',').map(int.parse).toList();
    particles.add([pos, vel, acc]);
  }
  for (int i = 0; i < 1000000; i++) {
    Set<List<int>> pos = new Set();
    Set<List<int>> doubles = new Set();
    for (int j = 0; j < particles.length; j++) {
      particles[j][1][0] += particles[j][2][0];
      particles[j][1][1] += particles[j][2][1];
      particles[j][1][2] += particles[j][2][2];
      particles[j][0][0] += particles[j][1][0];
      particles[j][0][1] += particles[j][1][1];
      particles[j][0][2] += particles[j][1][2];
    }
    int length = particles.length;
    for (int j = 0; j < length; j++) {
      bool dupes = false;
      for (int k = j + 1; k < length; k++) {
        if (particles[j][0][0] == particles[k][0][0] &&
            particles[j][0][1] == particles[k][0][1] &&
            particles[j][0][2] == particles[k][0][2]) {
          dupes = true;
          particles.removeAt(k);
          length--;
          k--;
        }
      }
      if (dupes) {
        particles.removeAt(j);
        j--;
        length--;
      }
    }
  }
  return particles.length;
}
