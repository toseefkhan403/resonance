import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_service.g.dart';

@Riverpod(keepAlive: true)
class AudioService extends _$AudioService {
  late AudioPlayer _bgPlayer;
  late AudioPlayer _sfxPlayer;

  @override
  bool build() {
    _bgPlayer = AudioPlayer();
    _sfxPlayer = AudioPlayer();
    _init();
    return false;
  }

  Future<void> _init() async {
    await _bgPlayer.setReleaseMode(ReleaseMode.loop);
    await _bgPlayer.setSource(AssetSource('audio/bg_music.mp3'));
    await _bgPlayer.setVolume(0.2);
  }

  Future<void> toggleMusic() async {
    if (state) {
      await _bgPlayer.pause();
      state = false;
    } else {
      await _bgPlayer.resume();
      state = true;
    }
  }

  Future<void> playClickSound() async {
    if (_sfxPlayer.state == PlayerState.playing) {
      await _sfxPlayer.stop();
    }
    await _sfxPlayer.play(
      AssetSource('audio/click.wav'),
      mode: PlayerMode.lowLatency,
      volume: 0.1,
    );
  }
}
