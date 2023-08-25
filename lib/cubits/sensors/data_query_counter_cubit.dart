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
    emit(_counter);
  }

  void resume() {
    _pauseFlag = false;
    emit(_counter);
    counting();
  }

  void reset() {
    _counter = resetValue;
    message = '開始同步';
    emit(_counter);
  }

  void counting() {
    message = '暫停同步';
    if (_pauseFlag) {
      return;
    }
    // decrease counter every 1 second
    Future.delayed(
      const Duration(seconds: 1),
      () {
        _counter--;
        // print('counter: $_counter');
        if (_counter == 0) {
          timesUp();
          return;
        }
        emit(_counter);
        counting();
      },
    );
  }

  void timesUp() {
    // send event
    emit(_counter);
    _counter = resetValue;
  }
}
