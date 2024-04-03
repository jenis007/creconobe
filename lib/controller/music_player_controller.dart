import 'dart:async';
import 'dart:developer';
import 'package:creconobe_transformation/models/just_audio_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../models/audioDataModel.dart';

class MusicPlayerCtr extends GetxController {
  AudioPlayer player = AudioPlayer();

  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;
  Rx<Duration> bufferedPosition = Duration.zero.obs;
  RxDouble dragValue = (-1.0).obs;
  String playListTitle = '';
  List<Data> currentList = [];

  final Rx<JustAudioModel> modelMusic = JustAudioModel(
          id: "",
          title: "",
          tag: "",
          isBuffer: false,
          isPlay: false,
          isPause: false,
          isStop: false,
          isStart: false,
          isIdle: true,
          isLoad: false,
          imgUrl: '',
          audiUrl: '')
      .obs;

  bool bottomMusicView = true;

  RxInt currentIndex = (-1).obs;

  StreamSubscription? indexStreamVar;
  StreamSubscription? playerStatusStream;
  StreamSubscription? playerPositionStream;
  StreamSubscription? playerPlayingStream;
  StreamSubscription? playerBufferedPositionStream;
  StreamSubscription? playerDurationStream;
  var audioSourcePlayList;
  RxList playList = [].obs;

  // stream controllers

  indexStream() {
    if (indexStreamVar != null) {
      log("indexStreamVar null");
      indexStreamVar!.cancel();
    }
    indexStreamVar = player.currentIndexStream.listen((element) async {
      if (player.previousIndex != null) {
        log("----======++== ${player.previousIndex}");
        closePlayer(player.previousIndex);
      }
      if (element != null) {
        log("----======++==????? ${element}");
        currentIndex.value = element;
        log("currentIndex--------------> ${currentIndex}");
      }
      if (currentList[currentIndex.value].playable == true) {
        checkPlayerStatus();
        positionStream();
        bufferedPositionStream();
        durationStream();
        checkPlayingStream();

        return;
      } else {
        await player.stop();
      }
    });
  }

  checkPlayingStream() {
    if (playerPlayingStream != null) {
      log("playerStatusStream null");
      playerPlayingStream!.cancel();
    }
    playerPlayingStream = player.playingStream.listen((event) {
      log("playerPlayingStream event ${event}");
      if (event) {
        log("playerPlayingStream event 111${event}");
        modelMusic.value = JustAudioModel(
          id: playList[player.currentIndex!].id.toString(),
          isStart: false,
          isStop: false,
          isPlay: true,
          isIdle: false,
          isPause: false,
          isBuffer: false,
          isLoad: false,
          title: playList[player.currentIndex!].audio_name,
          tag: playList[player.currentIndex!].tag,
          audiUrl: playList[player.currentIndex!].audio_file,
          imgUrl: playList[player.currentIndex!].cover_photo,
        );
      } else {
        log("playerPlayingStream event 222${event}");
        modelMusic.value = JustAudioModel(
          id: playList[player.currentIndex!].id.toString(),
          isStart: false,
          isStop: false,
          isPlay: false,
          isIdle: false,
          isPause: true,
          isBuffer: false,
          isLoad: false,
          title: playList[player.currentIndex!].audio_name,
          tag: playList[player.currentIndex!].tag,
          audiUrl: playList[player.currentIndex!].audio_file,
          imgUrl: playList[player.currentIndex!].cover_photo,
        );
      }
    });
  }

  checkPlayerStatus() {
    if (playerStatusStream != null) {
      log("playerStatusStream null");
      playerStatusStream!.cancel();
    }

    playerStatusStream = player.playerStateStream.listen((state) {
      log("1111111111 ${player.currentIndex}");
      if (state.playing) {
        modelMusic.value = JustAudioModel(
          id: playList[player.currentIndex!].id.toString(),
          isStart: false,
          isStop: false,
          isPlay: true,
          isIdle: false,
          isPause: false,
          isBuffer: false,
          isLoad: false,
          title: playList[player.currentIndex!].audio_name,
          tag: playList[player.currentIndex!].tag,
          audiUrl: playList[player.currentIndex!].audio_file,
          imgUrl: playList[player.currentIndex!].cover_photo,
        );
        //playList[player.currentIndex!] = modelMusic.value;
      }
      log("----------- ${state.processingState}");
      switch (state.processingState) {
        case ProcessingState.idle:
          log("----------- idle");
          modelMusic.value = JustAudioModel(
            id: playList[player.currentIndex!].id.toString(),
            isStart: false,
            isStop: false,
            isPlay: false,
            isPause: false,
            isBuffer: false,
            isLoad: false,
            isIdle: true,
            title: playList[player.currentIndex!].audio_name,
            tag: playList[player.currentIndex!].tag,
            audiUrl: playList[player.currentIndex!].audio_file,
            imgUrl: playList[player.currentIndex!].cover_photo,
          );
          //playList[player.currentIndex!] = modelMusic.value;
          return;
        case ProcessingState.loading:
          log("----------- loading");
          modelMusic.value = JustAudioModel(
            id: playList[player.currentIndex!].id.toString(),
            isStart: false,
            isStop: false,
            isPause: false,
            isIdle: false,
            isPlay: false,
            isBuffer: false,
            isLoad: true,
            title: playList[player.currentIndex!].audio_name,
            tag: playList[player.currentIndex!].tag,
            audiUrl: playList[player.currentIndex!].audio_file,
            imgUrl: playList[player.currentIndex!].cover_photo,
          );
          //playList[player.currentIndex!] = modelMusic.value;
          return;
        case ProcessingState.buffering:
          log("----------- buffering");
          modelMusic.value = JustAudioModel(
            id: playList[player.currentIndex!].id.toString(),
            isStart: false,
            isStop: false,
            isPause: false,
            isIdle: false,
            isPlay: false,
            isBuffer: true,
            isLoad: false,
            title: playList[player.currentIndex!].audio_name,
            tag: playList[player.currentIndex!].tag,
            audiUrl: playList[player.currentIndex!].audio_file,
            imgUrl: playList[player.currentIndex!].cover_photo,
          );
          return;
        case ProcessingState.ready:
          log("----------- ready");
          return;
        case ProcessingState.completed:
          log("----------- completed");
          modelMusic.value = JustAudioModel(
            id: playList[player.currentIndex!].id.toString(),
            isStart: false,
            isStop: false,
            isPause: false,
            isPlay: false,
            isBuffer: false,
            isIdle: false,
            isLoad: false,
            title: playList[player.currentIndex!].audio_name,
            tag: playList[player.currentIndex!].tag,
            audiUrl: playList[player.currentIndex!].audio_file,
            imgUrl: playList[player.currentIndex!].cover_photo,
          );
          //playList[player.currentIndex!] = modelMusic.value;
          return;
      }
    });
  }

  positionStream() {
    playerPositionStream = player.positionStream.listen((event) {
      position.value = event;
      /*if(player.processingState == ProcessingState.idle){
         position.value = Duration.zero;
       }*/
    });
  }

  bufferedPositionStream() {
    playerBufferedPositionStream = player.bufferedPositionStream.listen((event) {
      bufferedPosition.value = event;
    });
  }

  durationStream() {
    playerDurationStream = player.durationStream.listen((event) {
      if (event != null) {
        duration.value = event;
      }
    });
  }

  dragPosition(double val) {
    dragValue.value = val;
  }

  dragPositionEnd(Duration duration) {
    seekMusic(duration);
  }

  // add playlist songs

  addPlayListToPlayer(List<Data> musicList) async {
    playList.value = musicList;
    log("playList.value--------------> ${playList}");

    List<AudioSource> list = [];
    for (var element in musicList) {
      AudioSource audioSource = AudioSource.uri(
        Uri.parse(element.audio_file.toString()),
        headers: {'id': element.id.toString()},
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: element.id.toString(),
          // Metadata to display in the notification:
          title: element.audio_name.toString(),
          album: element.tag.toString(),
          artUri: Uri.parse(element.cover_photo.toString()),
        ),
      );
      list.add(audioSource);
    }
    audioSourcePlayList = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: list,
    );

    update();
  }

  playAllMusic() async {
    log("asdasdas ${player.currentIndex}");
    playListTitle = playListTitle;
    if (player.playing) {
      closePlayer(currentIndex.value);
    }

    addPlayListToPlayer(currentList);
    startPlayer(player.currentIndex);

    await player.setAudioSource(
      audioSourcePlayList,
      initialIndex: player.currentIndex,
      initialPosition: Duration.zero,
    );
    indexStream();
    await player.play();
  }

  playMusic(String title, List<Data> list, index) async {
    playListTitle = title;
    currentList = list;
    if (player.playing) {
      closePlayer(currentIndex.value);
    }

    addPlayListToPlayer(list);
    startPlayer(index);

    await player.setAudioSource(
      audioSourcePlayList,
      initialIndex: index,
      initialPosition: Duration.zero,
    );
    indexStream();
    await player.play();
  }

  playerPlayBackEvent() {
    player.playbackEventStream.listen((event) {
      //log("<<<<<<>>>>>>>> ${event}");
    });
  }

  resumeMusic(BuildContext context) async {
    if (currentList[currentIndex.value].playable == true) {
      await player.play();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Subscription is required'), backgroundColor: Colors.red));
    }
  }

  pauseMusic(BuildContext context) async {
    await player.pause();
    modelMusic.value = JustAudioModel(
      id: playList[currentIndex.value].id.toString(),
      isStart: false,
      isStop: false,
      isPlay: false,
      isBuffer: false,
      isIdle: false,
      isPause: true,
      isLoad: false,
      title: playList[player.currentIndex!].audio_name,
      tag: playList[player.currentIndex!].tag,
      audiUrl: playList[player.currentIndex!].audio_file,
      imgUrl: playList[player.currentIndex!].cover_photo,
    );

    //playList[currentIndex.value] = modelMusic.value;
  }

  nextMusic(BuildContext context) async {
    if (currentList[player.currentIndex! + 1].playable == true) {
      await player.seekToNext();
      if (!player.playing) {
        await player.play();
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Subscription is required'), backgroundColor: Colors.red));
    }
  }

  previousMusic(BuildContext context) async {
    // if(playList[currentIndex.value].)
    if (currentList[player.currentIndex! - 1].playable == true) {
      modelMusic.value = JustAudioModel(
        id: playList[currentIndex.value].id.toString(),
        isStart: false,
        isStop: false,
        isPlay: false,
        isIdle: false,
        isBuffer: false,
        isPause: false,
        isLoad: false,
        title: playList[player.currentIndex!].audio_name,
        tag: playList[player.currentIndex!].tag,
        audiUrl: playList[player.currentIndex!].audio_file,
        imgUrl: playList[player.currentIndex!].cover_photo,
      );
      //playList[currentIndex.value] = modelMusic.value;
      await player.seekToPrevious();
      if (!player.playing) {
        await player.play();
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Subscription is required'), backgroundColor: Colors.red));
    }
  }

  seekMusic(Duration duration) async {
    await player.seek(duration);
    dragValue.value = (-1.0);
  }

  setSpeedMusic() async {
    await player.setSpeed(2.0);
  }

  setVolumeMusic() async {
    await player.setVolume(0.5);
  }

  stopMusic() async {
    await player.stop();
  }

  setLoopMode() async {
    await player.setLoopMode(LoopMode.all);
  }

  setShuffleMode() async {
    await player.setShuffleModeEnabled(true);
  }

  startPlayer(index) {
    log("start");
    modelMusic.value = JustAudioModel(
      id: playList[index].id.toString(),
      isStart: true,
      isStop: false,
      isPlay: false,
      isIdle: false,
      isBuffer: false,
      isPause: false,
      isLoad: true,
      title: playList[index].audio_name,
      tag: playList[index].tag,
      audiUrl: playList[index].audio_file,
      imgUrl: playList[index].cover_photo,
    );
  }

  closePlayer(index) {
    modelMusic.value = JustAudioModel(
      id: playList[index].id.toString(),
      isStart: false,
      isStop: false,
      isPlay: false,
      isBuffer: false,
      isIdle: false,
      isPause: false,
      isLoad: false,
      title: playList[index].audio_name,
      tag: playList[index].tag,
      audiUrl: playList[index].audio_file,
      imgUrl: playList[index].cover_photo,
    );
    //playList[index] = modelMusic.value;
  }

  cancelStreams() {
    if (indexStreamVar != null) {
      indexStreamVar!.cancel();
    }
    if (playerStatusStream != null) {
      playerStatusStream!.cancel();
    }
  }
}
