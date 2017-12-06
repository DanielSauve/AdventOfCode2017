import 'dart:io';

void main() {
  new File('day4.txt').readAsString().then((String contents) {
    print(validCount(contents));
    print(validCountAnagram(contents));
  });
}

/**
 * I realized this could be turned into an anonymous function if I wanted to
 *
 * puzzle.split('\n').fold(
 *  0,
 *  (int prev, String line) =>
 *  line.split(' ').length == line.split(' ').toSet().length
 *  ? prev + 1
 *  : prev);
 */
int validCount(String puzzle) {
  int count = 0;
  for (String line in puzzle.split('\n')) {
    List<String> words = line.split(' ');
    if (words.length == words.toSet().length) {
      count += 1;
    }
  }
  return count;
}

int validCountAnagram(String puzzle) {
  int count = 0;
  for (String line in puzzle.split('\n')) {
    List<String> words = line.split(' ');
    List<String> sorted =
        words.map((String s) => (s.split('')..sort()).join('')).toList();
    if (sorted.length == sorted.toSet().length) {
      count += 1;
    }
  }
  return count;
}
