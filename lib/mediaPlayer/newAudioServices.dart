import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerService extends BaseAudioHandler {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<void> prepare() async {
    // Initialize your audio player here.
    await _audioPlayer.setUrl(''); // Set the initial URL or audio source.
  }

  @override
  Future<void> onPlay() async {
    await _audioPlayer.play();
    play();
  }

  @override
  Future<void> onPause() async {
    await _audioPlayer.pause();
    pause();
  }



}
