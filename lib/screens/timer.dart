import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_controller.dart';

class Timer {
  static CountdownController controller;
  static countDownStart() {
    controller = CountdownController();
    Countdown(
      controller: controller,
      seconds: 50,
      interval: Duration(
        milliseconds: 100,
      ),
      onFinished: () {
        print('50 s completete codkcedkior!');
      },
    );
  }

  static void countDown() {}
}
