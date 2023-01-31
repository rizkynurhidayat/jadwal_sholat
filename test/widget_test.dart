import 'dart:async';

void main() {
  const oneSec = Duration(seconds: 1);
  Timer.periodic(oneSec, (Timer t) {
    print("hi");
  });
}
