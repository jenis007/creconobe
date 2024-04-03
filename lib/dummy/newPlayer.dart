import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:creconobe_transformation/models/audioDataModel.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

/*void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: PlayerScreen(),
      debugShowCheckedModeBanner: false,
      title: "Music Player",
    );
  }
}*/


class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key, required  this.data});

  final Data data;
  @override
  _PlayerScreen createState() => _PlayerScreen();
}
class _PlayerScreen extends State<PlayerScreen>{

  late String thumbnailImgUrl; // Insert your thumbnail URL
  var player = AudioPlayer();
  bool loaded = false;
  bool playing = false;

  void loadMusic() async {
    String musicUrl = widget.data.audio_file.toString(); // Insert your music URL

    await player.setUrl(musicUrl);
    setState(() {
      loaded = true;
    });
  }

  void playMusic() async {
    setState(() {
      playing = true;
    });
    await player.play();
  }

  void pauseMusic() async {
    setState(() {
      playing = false;
    });
    await player.pause();
  }

  @override
  void initState() {

     thumbnailImgUrl = widget.data.cover_photo.toString(); // Insert your thumbnail URL



     player.dispose();


    loadMusic();

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music Player"),
      ),
      body: Container(
        color: Colors.teal,
        child:
        Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                thumbnailImgUrl,
                height: 350,
                width: 350,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: StreamBuilder(
                  stream: player.positionStream,
                  builder: (context, snapshot1) {
                    final Duration duration = loaded
                        ? snapshot1.data as Duration
                        : const Duration(seconds: 0);
                    return StreamBuilder(
                        stream: player.bufferedPositionStream,
                        builder: (context, snapshot2) {
                          final Duration bufferedDuration = loaded
                              ? snapshot2.data as Duration
                              : const Duration(seconds: 0);
                          return SizedBox(
                            height: 30,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: ProgressBar(
                                progress: duration,
                                total:
                                player.duration ?? const Duration(seconds: 0),
                                buffered: bufferedDuration,
                                timeLabelPadding: -1,
                                timeLabelTextStyle: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                                progressBarColor: Colors.red,
                                baseBarColor: Colors.grey[200],
                                bufferedBarColor: Colors.grey[350],
                                thumbColor: Colors.red,
                                onSeek: loaded
                                    ? (duration) async {
                                  await player.seek(duration);
                                }
                                    : null,
                              ),
                            ),
                          );
                        });
                  }),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: loaded
                        ? () async {
                      if (player.position.inSeconds >= 10) {
                        await player.seek(Duration(
                            seconds: player.position.inSeconds - 10));
                      } else {
                        await player.seek(const Duration(seconds: 0));
                      }
                    }
                        : null,
                    icon: const Icon(Icons.fast_rewind_rounded)),
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: IconButton(
                      onPressed: loaded
                          ? () {
                        if (playing) {
                          pauseMusic();
                        } else {

                          playMusic();
                        }
                      }
                          : null,
                      icon: Icon(
                        playing ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      )),
                ),
                IconButton(
                    onPressed: loaded
                        ? () async {
                      if (player.position.inSeconds + 10 <=
                          player.duration!.inSeconds) {
                        await player.seek(Duration(
                            seconds: player.position.inSeconds + 10));
                      } else {
                        await player.seek(const Duration(seconds: 0));
                      }
                    }
                        : null,
                    icon: const Icon(Icons.fast_forward_rounded)),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }



}