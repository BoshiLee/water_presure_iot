import 'package:bloc/bloc.dart';

class DataQueryCounterCubit extends Cubit<int> {
  int _counter = 0;
  final int resetValue;
  String get displayString => '下次同步時間: $_counter';
  String message = '開使同步';
  bool stopFlag = false;
  DataQueryCounterCubit({required this.resetValue}) : super(0) {
    reset();
  }

  void stop() {
    stopFlag = true;
    reset();
  }

  void reset() {
    _counter = 60;
    message = '開始同步';
    emit(_counter);
  }

  void counting() {
    message = '停止同步';
    // decrease counter every 1 second
    Future.delayed(const Duration(seconds: 1), () {
      _counter--;
      emit(_counter);
      if (stopFlag) {
        stopFlag = false;
        reset();
        return;
      }
      if (_counter == 0) {
        timesUp();
      }
      counting();
    });
  }

  void timesUp() {
    // send event
    emit(_counter);
    reset();
  }
}
