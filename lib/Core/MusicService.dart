import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';


class MusicService {
  static final MusicService _instance = MusicService._internal();
  factory MusicService() => _instance;
  MusicService._internal();

  AudioPlayer? _player;

  static const String _defaultPath = 'Music/K FRESH MUSIC - BOUNCE WIT IT -MOD-.mp3';
  String _currentPath = _defaultPath;

  // Reactive boolean
  final RxBool _isPlaying = false.obs;

  /// Non-reactive getter (returns bool)
  bool get isPlaying => _isPlaying.value;

  /// Reactive getter (for Obx)
  RxBool get isPlayingRx => _isPlaying;

  /// Initialize player safely
  Future<void> _init(String? path) async {
    final newPath = (path ?? _defaultPath).replaceFirst('assets/', '');
    if (_player == null) {
      _player = AudioPlayer();
      await _player!.setReleaseMode(ReleaseMode.loop);
      _currentPath = newPath;
      await _player!.setSource(AssetSource(_currentPath));

      _player!.onPlayerStateChanged.listen((state) {
        _isPlaying.value = state == PlayerState.playing;
      });
    } else if (_currentPath != newPath) {
      _currentPath = newPath;
      await _player!.setSource(AssetSource(_currentPath));
    }
  }

  /// Play music
  Future<void> play([String? path]) async {
    await _init(path);
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
