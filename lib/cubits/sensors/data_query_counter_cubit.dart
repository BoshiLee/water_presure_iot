import 'package:bloc/bloc.dart';

class DataQueryCounterCubit extends Cubit<int> {
  int _counter = 0;
  final int resetValue;
  String get displayString => '下次同步時間: $_counter';
  String message = '開使同步';
  bool _pauseFlag = false;
  DataQueryCounterCubit({required this.resetValue}) : super(0) {
    reset();
  }

  void pause() {
    _pauseFlag = true;
    message = '繼續同步';
  }

  void reset() {
    _counter = resetValue;
    message = '開始同步';
    emit(_counter);
  }

  void counting() {
    message = '暫停同步';
    // decrease counter every 1 second
    Future.delayed(const Duration(seconds: 1), () {
      _counter--;
      emit(_counter);
      if (_pauseFlag) {
        _pauseFlag = false;
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
    _counter = resetValue;
    emit(_counter);
  }
}
