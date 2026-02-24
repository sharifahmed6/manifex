import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class MusicService {
  static final MusicService _instance = MusicService._internal();
  factory MusicService() => _instance;
  MusicService._internal();

  AudioPlayer? _player;

  final String _assetPath =
      'Music/K FRESH MUSIC - BOUNCE WIT IT -MOD-.mp3';

  // Reactive boolean
  final RxBool _isPlaying = false.obs;

  /// Non-reactive getter (returns bool)
  bool get isPlaying => _isPlaying.value;

  /// Reactive getter (for Obx)
  RxBool get isPlayingRx => _isPlaying;

  /// Initialize player safely
  Future<void> _init() async {
    if (_player == null) {
      _player = AudioPlayer();
      await _player!.setReleaseMode(ReleaseMode.loop);
      await _player!.setSource(AssetSource(_assetPath));

      _player!.onPlayerStateChanged.listen((state) {
        _isPlaying.value = state == PlayerState.playing;
      });
    }
  }

  /// Play music
  Future<void> play() async {
    await _init();
    await _player!.resume();
    _isPlaying.value = true;
  }

  /// Stop music
  Future<void> stop() async {
    await _player?.stop();
    _isPlaying.value = false;
  }

  /// Dispose completely
  Future<void> dispose() async {
    await _player?.dispose();
    _player = null;
    _isPlaying.value = false;
  }
}