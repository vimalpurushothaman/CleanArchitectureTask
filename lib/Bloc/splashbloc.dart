import 'dart:async';
class SplashBloc {
  final _splashController = StreamController<bool>();

  Stream<bool> get splashStream => _splashController.stream;

  void startTimer() async {
    Timer(const Duration(seconds: 1), () {
      _splashController.add(true);
    });
  }

  void dispose() {
    _splashController.close();
  }
}
class SplashState {
  const SplashState();
}

class Splashinitialstate extends SplashState{}
class Splashcompletestate extends SplashState{}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashComplete extends SplashState {
  const SplashComplete();
}

class SplashEvent {
  const SplashEvent();
}

class SplashStartedEvent extends SplashEvent {
  const SplashStartedEvent();
}
class SplashScreenLoaded extends SplashEvent {}
