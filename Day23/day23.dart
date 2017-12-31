import 'dart:io';

void main() {
  new File('day23.txt').readAsString().then((String contents) {
    print(mulCount(contents));
    print(regH(contents));
  });
}

int mulCount(String puzzle) {
  Map<String, int> registers = new Map();
  List<String> instructions = puzzle.split('\n');
  int ip = 0, count = 0;
  while (ip < instructions.length) {
    List<String> ins = instructions[ip].split(' ');
    switch (ins[0]) {
      case 'set':
        try {
          registers[ins[1]] = int.parse(ins[2]);
        } catch (FormatException) {
          registers[ins[1]] = registers.putIfAbsent(ins[2], () => 0);
        }
        ip += 1;
        break;
      case 'sub':
        registers.putIfAbsent(ins[1], () => 0);
        try {
          registers[ins[1]] -= int.parse(ins[2]);
        } catch (FormatException) {
          registers[ins[1]] -= registers.putIfAbsent(ins[2], () => 0);
        }
        ip += 1;
        break;
      case 'mul':
        count += 1;
        registers.putIfAbsent(ins[1], () => 0);
        try {
          registers[ins[1]] *= int.parse(ins[2]);
        } catch (FormatException) {
          registers[ins[1]] *= registers.putIfAbsent(ins[2], () => 0);
        }
        ip += 1;
        break;
      case 'jnz':
        int comp;
        try {
          comp = int.parse(ins[1]);
        } catch (FormatException) {
          comp = registers.putIfAbsent(ins[1], () => 0);
        }
        if (comp != 0) {
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
  return count;
}

int regH(String puzzle) {
  Map<String, int> registers = new Map();
  List<String> instructions = puzzle.split('\n');
  int ip = 0;
  registers['a'] = 1;
  while (ip < instructions.length) {
    List<String> ins = instructions[ip].split(' ');
    switch (ins[0]) {
      case 'set':
        try {
          registers[ins[1]] = int.parse(ins[2]);
        } catch (FormatException) {
          registers[ins[1]] = registers.putIfAbsent(ins[2], () => 0);
        }
        ip += 1;
        break;
      case 'sub':
        registers.putIfAbsent(ins[1], () => 0);
        try {
          registers[ins[1]] -= int.parse(ins[2]);
        } catch (FormatException) {
          registers[ins[1]] -= registers.putIfAbsent(ins[2], () => 0);
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
      case 'jnz':
        int comp;
        try {
          comp = int.parse(ins[1]);
        } catch (FormatException) {
          comp = registers.putIfAbsent(ins[1], () => 0);
        }
        if (comp != 0) {
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
  return registers['h'];
}
