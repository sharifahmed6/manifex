import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';

class TTSService {

  static final FlutterTts _flutterTts = FlutterTts();

  static Future<void> init() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);   // 0.0 - 1.0
    await _flutterTts.setVolume(1.0);       // 0.0 - 1.0
    await _flutterTts.setPitch(1.0);        // 0.5 - 2.0
    
    if (Platform.isIOS) {
      await _flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
      );
    }
  }

  static Future<void> speak(String text) async {
    if (text.isEmpty) return;

    await _flutterTts.stop(); // stop previous speech
    await _flutterTts.speak(text);
  }

  static Future<void> stop() async {
    await _flutterTts.stop();
  }
}
