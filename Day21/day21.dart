import 'dart:io';

void main() {
  new File('day21.txt').readAsString().then((String contents) {
    print(doTheThing(contents));
  });
}