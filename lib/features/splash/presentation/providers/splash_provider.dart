import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/splash_model.dart';

/// State representation for the Splash screen.
class SplashState {
  const SplashState({
    required this.isInitialized,
    required this.canNavigate,
    required this.data,
  });

  final bool isInitialized;
  final bool canNavigate;
  final SplashModel data;

  SplashState copyWith({
    bool? isInitialized,
    bool? canNavigate,
    SplashModel? data,
  }) {
    return SplashState(
      isInitialized: isInitialized ?? this.isInitialized,
      canNavigate: canNavigate ?? this.canNavigate,
      data: data ?? this.data,
    );
  }
}

/// Riverpod notifier managing Splash lifecycle, dummy data initialization, and navigation trigger.
class SplashNotifier extends Notifier<SplashState> {
  Timer? _timer;

  @override
  SplashState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    return const SplashState(
      isInitialized: true,
      canNavigate: false,
      data: SplashModel.dummy,
    );
  }

  /// Starts the splash delay and marks navigation ready once duration elapsed.
  void initSplash() {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: state.data.delayMilliseconds), () {
      state = state.copyWith(canNavigate: true);
    });
  }
}

final splashProvider = NotifierProvider<SplashNotifier, SplashState>(
  SplashNotifier.new,
);
