/*
import 'dart:async';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:creconobe_transformation/mediaPlayer/position_seek.dart';
import 'package:creconobe_transformation/models/audioDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import 'audioPlayer.dart';


AssetsAudioPlayer _audioPlayer =AssetsAudioPlayer();

class MediaPlayer extends  StatefulWidget{

  final int index;
  final List<dynamic> audioList;

  const MediaPlayer({super.key, required this.index,required this.audioList});

  @override
  State<MediaPlayer> createState() => _MediaPlayer();

}

class _MediaPlayer extends State<MediaPlayer> {
 // late AssetsAudioPlayer _assetsAudioPlayer;
  final logger = Logger();
  String status = 'hidden';



  //double progress= 10;
  bool isPlaying = false;

  int current = 0;

  //Duration _currentPosition = Duration.zero;
  //Duration _totalDuration = Duration.zero;
  late Timer _timer;
  //late List <Audio> audios;

  List<dynamic> audioL = [];
  List<Audio> audioLists = [];



  @override
  void initState(){
    super.initState();

    AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
      //custom action
      return true; //true : handled, does not notify others listeners
      //false : enable others listeners to handle it
    });

    audioL = widget.audioList;
     _initAudioPlayer();


  }
  void _initAudioPlayer() async {

    if(_audioPlayer.isPlaying.value == true || _audioPlayer.isBuffering.value == true){
      await _audioPlayer.dispose();
      _audioPlayer = AssetsAudioPlayer();
    }

    await _audioPlayer.open(
      Playlist(audios: _getAudioList()),
      loopMode: LoopMode.playlist,
      showNotification: true,
      autoStart: false,
      notificationSettings: const NotificationSettings(
        prevEnabled: true,
        nextEnabled: true,
        playPauseEnabled: true,
        stopEnabled: false,
      )
    );
     await _audioPlayer.playlistPlayAtIndex(widget.index);
     setState(() {

     });

    _audioPlayer.playlistFinished.listen((finished) {
      // Handle the end of the playlist (optional).
      if (finished) {
        // You can perform actions here, like going to the next playlist.
        _audioPlayer.next();
      }
    });


    */
/*_audioPlayer.current.listen((playingAudio) {
      // Update the UI when the current audio changes (optional).
      if (playingAudio != null) {
        setState(() {
          //_totalDuration = playingAudio.audio.duration;
        });
      }
      // Update the progress bar every second.
      *//*
*/
/*_timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {});
      });*//*
*/
/*
    });*//*


    _audioPlayer.currentPosition.listen((position) {
      // Sync the progress bar with the audio position.
      // This will be called continuously as the audio plays.
     */
/* setState(() {
        _currentPosition = position;
      });*//*

    });
  }




  List<Audio> _getAudioList() {
    // Replace this with your list of songs containing audio URLs and names.

    audioLists = [];
    for (var element in audioL) {
      audioLists.add(
        Audio.network(
          element.audio_file,
          metas: Metas(
            id: element.id.toString(),
            title: element.audio_name!,
            artist: element.audio_episode,
            image:   MetasImage.network(
              element.cover_photo.toString(),
            ),
          ),
        ),
      );
    }
    return audioLists;
  }




  @override
  Widget build(BuildContext context) {
   */
/* final double progress = _totalDuration.inMilliseconds > 0
        ? _currentPosition.inMilliseconds / _totalDuration.inMilliseconds
        : 0.0;*//*

   return Scaffold(

      body:Container(
       // margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),

        width: double.infinity,
        height:  double.infinity,//MediaQuery.of(context).size.height,

        decoration: ShapeDecoration(

          */
/*image: DecorationImage(
            image: NetworkImage(widget.data.cover_photo!),
            fit: BoxFit.cover,

          ),*//*

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),

        child:  Stack(
          children: [
            StreamBuilder<Playing?>(
                stream: _audioPlayer.current,
                builder: (context, playing) {
                  if (playing.data != null) {
                    final myAudio = find(
                        audioLists, playing.data!.audio.assetAudioPath);
                    return Container(
                      width: double.infinity,
                      height:  double.infinity,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(myAudio.metas.image!.path),
                          fit: BoxFit.cover,

                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Text(myAudio.metas.title!, style: TextStyle(
                   color: Colors.white,
                   fontSize: 18.86,
                   fontFamily: GoogleFonts.manrope.toString(),
                   fontWeight: FontWeight.w600,
                 ),),
                 const SizedBox(
                   height: 20,
                 ),
                 Text(myAudio.metas.artist!,  style: TextStyle(
                   color: Colors.white,
                   fontSize: 15.86,
                   fontFamily: GoogleFonts.manrope.toString(),
                   fontWeight: FontWeight.w600,
                 ),),


                        ],


                      ),
                    );
                  }
                  return SizedBox.shrink();
                }),
            Column(
              children: [
                const  SizedBox(height: 40,),


                Container(
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);

                  }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),


                  ) ,

                ),



                Center(
                  child:
                  Column(
                    children: [
                      */
/*Text(widget.data.audio_name!, style: TextStyle(
                   color: Colors.white,
                   fontSize: 18.86,
                   fontFamily: GoogleFonts.manrope.toString(),
                   fontWeight: FontWeight.w600,
                 ),),
                 const SizedBox(
                   height: 20,
                 ),
                 Text(widget.data.audio_episode!,  style: TextStyle(
                   color: Colors.white,
                   fontSize: 15.86,
                   fontFamily: GoogleFonts.manrope.toString(),
                   fontWeight: FontWeight.w600,
                 ),),*//*



                    ],


                  )

                  ,

                ),


                const  Spacer(),

                */
/* StreamBuilder<Duration>(
              stream: _audioPlayer.currentPosition,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  logger.d("media player null ==== ${snapshot.data.toString()}");

                  // Handle the case when there is no data yet (e.g., initial build).
                  return const CircularProgressIndicator(); // Replace with your loading indicator.
                }

                if (snapshot.hasData) {
                  logger.d("media player data ==== ${snapshot.data.toString()}");

                  final currentAudio = _audioPlayer.current.value;
                  final duration = currentAudio?.audio.duration ?? Duration.zero;
                  final position = snapshot.data ?? Duration.zero; // Current position

                  return Slider(
                    value: position.inMilliseconds.toDouble(),
                    onChanged: (value) {
                      // Seek to the selected position when dragging the slider.
                      _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                    },
                    min: 0,
                    max: duration.inMilliseconds.toDouble(),
                  );
                }
               else if (snapshot.hasError) {
                  logger.d("media player error ==== ${snapshot.error.toString()}");
                  return const CircularProgressIndicator(); // Replace with your loading indicator.
                }
               else
                 {
                   return const CircularProgressIndicator();
                 }
              },
            ),*//*

                _audioPlayer.builderCurrent(
                    builder: (context, Playing? playing) {
                      return _audioPlayer.builderRealtimePlayingInfos(
                          builder: (context, RealtimePlayingInfos? infos) {
                            if (infos == null) {
                              return PositionSeekWidget(
                                currentPosition: Duration.zero,
                                duration: _audioPlayer.currentPosition.value,
                                seekTo: (to) {
                                  _audioPlayer.seek(to);
                                },
                              );
                            }
                            return Container(
                              child: PositionSeekWidget(
                                currentPosition: _audioPlayer.currentPosition.value,
                                duration: _audioPlayer.current.value!.audio.duration,
                                seekTo: (to) {
                                  _audioPlayer.seek(to);
                                },
                              ),
                            );}
                      );
                    }),
                */
/*ValueListenableBuilder(
                valueListenable: _progress,
                builder: (builder,val,child){
                  logger.d("val $val");
                  return Slider(
                    value: val,
                    onChanged: (value) {
                      final newPosition = Duration(milliseconds: (value * _totalDuration.inMilliseconds).toInt());
                      _audioPlayer.seek(newPosition);
                    },
                    min: 0,
                    max: 1,
                  );
                }
            ),*//*





                */
/*  Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: Text("${_currentPosition.inSeconds}",style: const TextStyle(color: Colors.white),),
                ),

               const Spacer(),
                Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: Text("${_totalDuration.inMinutes}",style: const TextStyle(color: Colors.white),),
                ),
              ],

            ),*//*




                StreamBuilder(
                  stream: _audioPlayer.isPlaying,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        IconButton(onPressed: (){

                          //  rewind(10);
                          _audioPlayer
                              .seekBy(const Duration(seconds: -10));

                        }, icon: const Icon(Icons.replay_10_outlined,color: Colors.white,)),

                        IconButton(onPressed: () async{


                          await _audioPlayer.previous(keepLoopMode: true);
                        }, icon: const Icon(Icons.skip_previous,color: Colors.white)),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                          child: Center(
                            child:
                            IconButton(
                              icon: snapshot.data == true
                                  ? const Icon(Icons.pause)
                                  : const Icon(Icons.play_arrow),
                              onPressed: () {
                                if (snapshot.data == true) {
                                  _audioPlayer.pause();
                                  isPlaying=false;
                                } else {
                                  _audioPlayer.play();
                                  isPlaying=true;
                                }
                              },
                            ),
                          ),

                        ),
                        IconButton(onPressed: () async{
                          await _audioPlayer.next(keepLoopMode: true);
                        }, icon: const Icon(Icons.skip_next,color: Colors.white)),
                        IconButton(onPressed: (){
                          //  fastForward(10);

                          _audioPlayer
                              .seekBy(const Duration(seconds: 10));

                        }, icon: const Icon(Icons.forward_10_outlined,color: Colors.white)),



                      ],


                    );
                  },
                ),


                const  SizedBox(height: 40,),


                InkWell(
                  onTap:()  {
                    String url = "https://youtube.com/@Creconobe?si=W5zJL36-lq_dH8yP";
                    Uri uri = Uri.parse(url);

                    _launchInBrowser(uri);

                  } ,
                  child:  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    alignment: Alignment.center,
                    width: 140,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Icon(Icons.play_circle,color: Colors.white,),
                        const  SizedBox(width: 5),

                        Text(
                          'Youtube',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.bold

                          ),


                        ),

                        const  SizedBox(width: 5),
                        // const Icon(Icons.play_circle,color: Colors.white,)



                      ],

                    ),

                  ),),
                const  SizedBox(height: 20,),
              ],
            )

          ],
        ),


      ),






    );


  }



  Future<double> getTotalLength() {



  return  BackgroundMusicPlayer().getLenght();

  }
  Future<void> _launchInBrowser(Uri url) async {


    //  didChangeAppLifecycleState(AppLifecycleState as AppLifecycleState );
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }




  }



  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

}
*/
