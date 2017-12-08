import 'dart:io';

void main() {
  new File('day7.txt').readAsString().then((String contents) {
    print(findBottom(contents));
    wrongWeight(contents);
  });
}

String findBottom(String puzzle) {
  List<String> input = puzzle.split('\n');
  List<String> programs = new List();
  List<String> onTop = new List();
  for (String line in input) {
    List<String> temp = line.split(' ');
    if (temp.length < 4) continue;
    programs.add(temp[0]);
    for (String item in temp.skip(3)) {
      onTop.add(item.replaceAll(',', ''));
    }
  }
  for (String program in programs) {
    if (!onTop.contains(program)) {
      return program;
    }
  }
}

wrongWeight(String puzzle) {
  List<String> input = puzzle.split('\n');
  Map<String, WeightedTree> nodes = buildTree(input);
  ensureBalanced(nodes, findBottom(puzzle));
}

int ensureBalanced(Map<String, WeightedTree> nodes, String start) {
  if (nodes[start].children.length == 0) {
    return nodes[start].weight;
  }
  for (String child in nodes[start].children) {
    nodes[start].weight += ensureBalanced(nodes, child);
  }
  print(nodes[start].weight);
  return nodes[start].weight;
}

Map<String, WeightedTree> buildTree(List<String> nodeList) {
  Map<String, WeightedTree> nodes = new Map();

  for (String line in nodeList) {
    List<String> temp = line.split(' ');
    if (temp.length < 4) {
      WeightedTree node = new WeightedTree(temp[0], new List(),
          int.parse(temp[1].substring(1, temp[1].indexOf(')'))));
      nodes.putIfAbsent(temp[0], () => node);
    } else {
      List<String> children = new List();
      for (String item in temp.skip(3)) {
        children.add(item.replaceAll(',', ''));
      }
      WeightedTree node = new WeightedTree(temp[0], children,
          int.parse(temp[1].substring(1, temp[1].indexOf(')'))));
      nodes.putIfAbsent(temp[0], () => node);
    }
  }
  return nodes;
}

class WeightedTree {
  String name;
  List<String> children;
  int weight;

  WeightedTree(this.name, this.children, this.weight);
}
