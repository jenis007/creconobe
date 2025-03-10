/*
import 'dart:developer';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

import '../models/audioDataModel.dart';

class AppAudioService {
  static final AppAudioService _appAudioService = AppAudioService._internal();

  late AudioPlayerHandler audioHandler;

  factory AppAudioService() {
    return _appAudioService;
  }

  Future<void> init() async {
    audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config:  const AudioServiceConfig(
        androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      ),
    );
  }

  AppAudioService._internal();
}

class AudioPlayerHandler extends BaseAudioHandler {
  final AudioPlayer _audioPlayer = AudioPlayer();

  String _episodeId = '';
  String _audioType = '';

  String get episodeId => _episodeId;
  set setEpisodeId(String state) {
    _episodeId = state;
  }

  String get audioType => _audioType;

  @override
  AudioPlayerHandler() {
    _notifyAudioHandlerAboutPlaybackEvents();
  }

  @override
  Future<void> play() async {
    // if (episode.id != _audioPlayer.audioSource?.sequence[0].tag.id) {
    //   log('DIFFERENT EPISODE');
    //   await _audioPlayer.stop();
    //   await loadEpisode(episode, isDownloaded);
    // }
    _audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
    return super.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Future<void> onTaskRemoved() async {
    await _audioPlayer.stop();
    return super.onTaskRemoved();
  }

  // @override
  // Future<void> playFromUri() async {}



  Future<void> loadEpisode(Data episode) async
  {
    try {
      MediaItem audioMediaItem = MediaItem(
        id: episode.id.toString(),
        title: episode.audio_name.toString(),
        album: episode.audio_album.toString(),
        artUri: Uri.parse(episode.cover_photo!),
      );

        await _audioPlayer.setAudioSource(
          AudioSource.uri(
            Uri.parse(episode.audio_file!),
            tag: audioMediaItem,
          ),
          preload: true,
        );

      await _audioPlayer.load();
      _audioType = 'episode';
      queue.add([audioMediaItem]);
      mediaItem.add(audioMediaItem);
    } catch (e) {
      log('Cannot play audio: $e');
    }
  }


  bool isPlaying(String src, {String? episodeId}) {
    if (src == 'podcast') {
      return _audioPlayer.playing &&
          _audioPlayer.audioSource?.sequence[0].tag.id == episodeId &&
          _audioType == 'episode';
    } else if (src == 'coderadio') {
      return _audioPlayer.playing && _audioType == 'coderadio';
    } else {
      return false;
    }
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    _audioPlayer.playbackEventStream.listen(
      (PlaybackEvent event) {
        final playing = _audioPlayer.playing;
        playbackState.add(
          playbackState.value.copyWith(
            controls: [
              if (playing) MediaControl.pause else MediaControl.play,
              MediaControl.stop,
            ],
            systemActions: const {
              MediaAction.seek,
              MediaAction.seekBackward,
              MediaAction.seekForward,
            },
            androidCompactActionIndices: const [0, 1], // CHECK
            processingState: const {
              ProcessingState.idle: AudioProcessingState.idle,
              ProcessingState.loading: AudioProcessingState.loading,
              ProcessingState.buffering: AudioProcessingState.buffering,
              ProcessingState.ready: AudioProcessingState.ready,
              ProcessingState.completed: AudioProcessingState.completed,
            }[_audioPlayer.processingState]!,
            repeatMode: AudioServiceRepeatMode.none,
            shuffleMode: AudioServiceShuffleMode.none,
            playing: playing,
            updatePosition: _audioPlayer.position,
            bufferedPosition: _audioPlayer.bufferedPosition,
            speed: _audioPlayer.speed,
            queueIndex: event.currentIndex,
          ),
        );
      },
    );
  }
}
*/
