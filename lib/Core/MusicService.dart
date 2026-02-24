import 'package:audioplayers/audioplayers.dart';

class MusicService {
  static final MusicService _instance = MusicService._internal();
  factory MusicService() => _instance;

  MusicService._internal();

  final AudioPlayer _player = AudioPlayer();

  bool _isInitialized = false;

  Future<void> _init() async {
    if (_isInitialized) return;

    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setSource(AssetSource(
      'Music/K FRESH MUSIC - BOUNCE WIT IT -MOD-.mp3',
    ));

    _isInitialized = true;
  }

  Future<void> play() async {
    await _init();
    await _player.resume();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}