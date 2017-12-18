import 'dart:io';

void main() {
  new File('day18.txt').readAsString().then((String contents) {
    print(mostRecentFrequency(contents));
    print(sendCount(contents));
  });
}

int mostRecentFrequency(String puzzle) {
  Map<String, int> registers = new Map();
  List<String> instructions = puzzle.split('\n');
  int ip = 0, rec, lr;
  while (ip < instructions.length) {
    List<String> ins = instructions[ip].split(' ');
    switch (ins[0]) {
      case 'snd':
        rec = registers.putIfAbsent(ins[1], () => 0);
        ip += 1;
        break;
      case 'set':
        try {
          registers[ins[1]] = int.parse(ins[2]);
        } catch (FormatException) {
          registers[ins[1]] = registers.putIfAbsent(ins[2], () => 0);
        }
        ip += 1;
        break;
      case 'add':
        registers.putIfAbsent(ins[1], () => 0);
        try {
          registers[ins[1]] += int.parse(ins[2]);
        } catch (FormatException) {
          registers[ins[1]] += registers.putIfAbsent(ins[2], () => 0);
        }
        ip += 1;
        break;
      case 'mul':
        registers.putIfAbsent(ins[1], () => 0);
        try {
          registers[ins[1]] *= int.parse(ins[2]);
        } catch (FormatException) {
          registers[ins[1]] *= registers.putIfAbsent(ins[2], () => 0);
        }
        ip += 1;
        break;
      case 'mod':
        registers.putIfAbsent(ins[1], () => 0);
        try {
          registers[ins[1]] %= int.parse(ins[2]);
        } catch (FormatException) {
          registers[ins[1]] %= registers.putIfAbsent(ins[2], () => 0);
        }
        ip += 1;
        break;
      case 'rcv':
        if (registers.putIfAbsent(ins[1], () => 0) != 0) {
          registers[ins[1]] = rec;
          lr = rec;
          if (lr > 0) {
            return lr;
          }
        }
        ip += 1;
        break;
      case 'jgz':
        if (registers.putIfAbsent(ins[1], () => 0) > 0) {
          try {
            ip += int.parse(ins[2]);
          } catch (FormatException) {
            ip += registers.putIfAbsent(ins[2], () => 0);
          }
        } else {
          ip += 1;
        }
        break;
    }
  }
  return lr;
}

int sendCount(String puzzle) {
  Map<String, int> registers1 = new Map()..putIfAbsent('p', () => 0);
  Map<String, int> registers2 = new Map()..putIfAbsent('p', () => 1);
  List<String> instructions = puzzle.split('\n');
  int ip1 = 0, ip2 = 0, count = 0;
  List<int> rec1 = new List(), rec2 = new List();
  bool eq1 = false, eq2 = false;
  while (
      !(eq1 && eq2) && ip1 < instructions.length && ip2 < instructions.length) {
    List<String> ins1 = instructions[ip1].split(' ');
    List<String> ins2 = instructions[ip2].split(' ');
    switch (ins1[0]) {
      case 'snd':
        rec2.add(registers1.putIfAbsent(ins1[1], () => 0));
        ip1 += 1;
        break;
      case 'set':
        try {
          registers1[ins1[1]] = int.parse(ins1[2]);
        } catch (FormatException) {
          registers1[ins1[1]] = registers1.putIfAbsent(ins1[2], () => 0);
        }
        ip1 += 1;
        break;
      case 'add':
        registers1.putIfAbsent(ins1[1], () => 0);
        try {
          registers1[ins1[1]] += int.parse(ins1[2]);
        } catch (FormatException) {
          registers1[ins1[1]] += registers1.putIfAbsent(ins1[2], () => 0);
        }
        ip1 += 1;
        break;
      case 'mul':
        registers1.putIfAbsent(ins1[1], () => 0);
        try {
          registers1[ins1[1]] *= int.parse(ins1[2]);
        } catch (FormatException) {
          registers1[ins1[1]] *= registers1.putIfAbsent(ins1[2], () => 0);
        }
        ip1 += 1;
        break;
      case 'mod':
        registers1.putIfAbsent(ins1[1], () => 0);
        try {
          registers1[ins1[1]] %= int.parse(ins1[2]);
        } catch (FormatException) {
          registers1[ins1[1]] %= registers1.putIfAbsent(ins1[2], () => 0);
        }
        ip1 += 1;
        break;
      case 'rcv':
        if (rec1.isEmpty) {
          eq1 = true;
          break;
        }
        eq1 = false;
        registers1[ins1[1]] = rec1.removeAt(0);
        ip1 += 1;
        break;
      case 'jgz':
        int comp;
        try {
          comp = int.parse(ins1[1]);
        } catch (FormatException) {
          comp = registers1.putIfAbsent(ins1[1], () => 0);
        }
        if (comp > 0) {
          try {
            ip1 += int.parse(ins1[2]);
          } catch (FormatException) {
            ip1 += registers1.putIfAbsent(ins1[2], () => 0);
          }
        } else {
          ip1 += 1;
        }
        break;
    }
    switch (ins2[0]) {
      case 'snd':
        rec1.add(registers2.putIfAbsent(ins2[1], () => 0));
        count += 1;
        ip2 += 1;
        break;
      case 'set':
        try {
          registers2[ins2[1]] = int.parse(ins2[2]);
        } catch (FormatException) {
          registers2[ins2[1]] = registers2.putIfAbsent(ins2[2], () => 0);
        }
        ip2 += 1;
        break;
      case 'add':
        registers2.putIfAbsent(ins2[1], () => 0);
        try {
          registers2[ins2[1]] += int.parse(ins2[2]);
        } catch (FormatException) {
          registers2[ins2[1]] += registers2.putIfAbsent(ins2[2], () => 0);
        }
        ip2 += 1;
        break;
      case 'mul':
        registers2.putIfAbsent(ins2[1], () => 0);
        try {
          registers2[ins2[1]] *= int.parse(ins2[2]);
        } catch (FormatException) {
          registers2[ins2[1]] *= registers2.putIfAbsent(ins2[2], () => 0);
        }
        ip2 += 1;
        break;
      case 'mod':
        registers2.putIfAbsent(ins2[1], () => 0);
        try {
          registers2[ins2[1]] %= int.parse(ins2[2]);
        } catch (FormatException) {
          registers2[ins2[1]] %= registers2.putIfAbsent(ins2[2], () => 0);
        }
        ip2 += 1;
        break;
      case 'rcv':
        if (rec2.isEmpty) {
          eq2 = true;
          break;
        }
        eq2 = false;
        registers2[ins2[1]] = rec2.removeAt(0);
        ip2 += 1;
        break;
      case 'jgz':
        int comp;
        try {
          comp = int.parse(ins2[1]);
        } catch (FormatException) {
          comp = registers2.putIfAbsent(ins2[1], () => 0);
        }
        if (comp > 0) {
          try {
            ip2 += int.parse(ins2[2]);
          } catch (FormatException) {
            ip2 += registers2.putIfAbsent(ins2[2], () => 0);
          }
        } else {
          ip2 += 1;
        }
        break;
    }
  }
  return count;
}
