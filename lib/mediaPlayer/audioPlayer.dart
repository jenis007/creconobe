import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import 'audio_service.dart';
import 'audio_service.dart';
import 'audio_service.dart';
class BackgroundMusicPlayer  {
  static final BackgroundMusicPlayer _instance = BackgroundMusicPlayer._internal();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String status = 'hidden';

  factory BackgroundMusicPlayer() {
    return _instance;
  }

  BackgroundMusicPlayer._internal() {
    _initAudioPlayer();

  }


  Future<void> _initAudioPlayer() async {
    // Set up the audio player configuration as needed
    await _audioPlayer.setUrl(''); // Empty URL to begin with
    // Add event listeners, set up looping, etc.



    // ...
  }





  Future<void> setSongUrl(String songUrl) async {
    await _audioPlayer.setUrl(songUrl);
  }

  @override
  Future<void> play() async {
    await _audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
  }


  Future<double> getLenght()async{
    Duration duration = _audioPlayer.duration!;
    double audioLengthInMinutes = duration.inSeconds / 60;
  return audioLengthInMinutes;
  }

  Future<void> forward() async {
    await _audioPlayer.seek(const Duration(seconds: 10));        // Jump to the 10 second position

  }

  Future<void> backward() async {
    await _audioPlayer.seek(const Duration(seconds: -10));        // Jump to the 10 second position
  }



}
