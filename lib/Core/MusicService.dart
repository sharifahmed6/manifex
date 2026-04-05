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
  
  // User preference flag (true = music should play by default)
  final RxBool _isPreferencePlay = true.obs;

  /// Non-reactive getter (returns bool)
  bool get isPlaying => _isPlaying.value;

  /// Reactive getter (for Obx)
  RxBool get isPlayingRx => _isPlaying;

  /// Getter for user preference
  bool get isPreferencePlay => _isPreferencePlay.value;

  /// Reactive getter for user preference
  RxBool get isPreferencePlayRx => _isPreferencePlay;

  /// Toggle music based on user manual interaction
  Future<void> toggleMusic([String? path]) async {
    if (isPlaying) {
      _isPreferencePlay.value = false;
      await stop();
    } else {
      _isPreferencePlay.value = true;
      await play(path);
    }
  }

  /// Initialize player safely
  Future<void> _init(String? path) async {
    try {
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
    } catch (e) {
      print("MusicService _init error: $e");
    }
  }

  /// Play music
  Future<void> play([String? path]) async {
    try {
      await _init(path);
      if (_player != null && !isPlaying) {
        await _player!.resume();
        _isPlaying.value = true;
      }
    } catch (e) {
      print("MusicService play error: $e");
    }
  }

  /// Stop music
  Future<void> stop() async {
    try {
      if (_player != null && isPlaying) {
        await _player?.stop();
        _isPlaying.value = false;
      }
    } catch (e) {
      print("MusicService stop error: $e");
    }
  }

  /// Dispose completely
  Future<void> dispose() async {
    try {
      await _player?.dispose();
      _player = null;
      _isPlaying.value = false;
    } catch (e) {
      print("MusicService dispose error: $e");
    }
  }
}
