import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AudioManager {
  AudioManager._internal();

  late Box _pref;
  late ValueNotifier<bool> _sfx;
  late ValueNotifier<bool> _bgm;

  ValueNotifier<bool> get listenableSfx => _sfx;
  ValueNotifier<bool> get listenableBgm => _bgm;

  static AudioManager _instance = AudioManager._internal();

  static AudioManager get instance => _instance;

  init(List<String> files) async {
    FlameAudio.bgm.initialize();
    await FlameAudio.bgm.loadAll(files);

    _pref = await Hive.openBox('preferences');

    if (_pref.get('bgm') == null) {
      _pref.put('bgm', true);
    }
    if (_pref.get('sfx') == null) {
      _pref.put('sfx', true);
    }

    _sfx = ValueNotifier(_pref.get('sfx'));
    _bgm = ValueNotifier(_pref.get('bgm'));
  }

  void setSfx(bool flag) {
    _pref.put('sfx', flag);
    _sfx.value = flag;
  }

  void setBgm(bool flag) {
    _pref.put('bgm', flag);
    _bgm.value = flag;
  }

  void startBgm(String fileName) {
    if (_bgm.value) {
      FlameAudio.bgm.play(fileName, volume: 0.4);
    }
  }

  void pauseBgm() {
    if (_bgm.value) {
      FlameAudio.bgm.pause();
    }
  }

  void resumeBgm() {
    if (_bgm.value) {
      FlameAudio.bgm.resume();
    }
  }

  void stopBgm() {
    if (_bgm.value) {
      FlameAudio.bgm.stop();
    }
  }

  void playSfx(String fileName) {
    if (_sfx.value) {
      FlameAudio.play(fileName);
    }
  }
}
