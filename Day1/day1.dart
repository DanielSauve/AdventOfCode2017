import 'dart:io';

void main() {
  new File('day1.txt').readAsString().then((String contents) {
    print(captcha(contents));
    print(captchaHalfway(contents));
  });
}

int captcha(text) {
  List l = text.split('');
  int i = 0;
  int sum = 0;
  if (l.first == l.last) {
    sum += int.parse(l.first);
  }
  while (i < l.length - 1) {
    if (l[i] == l[i + 1]) {
      sum += int.parse(l[i]);
    }
    i += 1;
  }
  return sum;
}

int captchaHalfway(text) {
  List l = text.split('');
  int curr = 0;
  int comp = l.length ~/ 2;
  int sum = 0;
  while (curr < l.length / 2) {
    if (l[curr] == l[comp]) {
      sum += 2 * int.parse(l[curr]);
    }
    curr += 1;
    comp += 1;
  }
  return sum;
}
