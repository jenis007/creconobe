/*
import 'dart:async';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:creconobe_transformation/models/audioDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import 'audioPlayer.dart';
import 'audio_service.dart';

class OnlinePlayer extends  StatefulWidget{

  final Data data;

  const OnlinePlayer({super.key, required this.data});

  @override
  State<OnlinePlayer> createState() => _OnlinePlayer();

}

class _OnlinePlayer extends State<OnlinePlayer> {
  // late AssetsAudioPlayer _assetsAudioPlayer;
  final logger = Logger();

  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();

  double progress= 10;
  bool isPlaying = false;

  int current = 0;

  String status = 'hidden';
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  late Timer _timer;
  late List <Audio>audios;
  late Data data;

  final _audioService = AppAudioService().audioHandler;






  */
/* @override
  void initState() {
    super.initState();
    data = widget.data;


    //  _audioPlayer.dispose();

    _audioPlayer.stop();

    _initAudioPlayer();



  }
  void _initAudioPlayer() async {
    await _audioPlayer.open(
      Playlist(audios: _getAudioList()),
      loopMode: LoopMode.playlist,
      showNotification: true,
    );

    _audioPlayer.playlistFinished.listen((finished) {
      // Handle the end of the playlist (optional).
      if (finished) {
        // You can perform actions here, like going to the next playlist.
        _audioPlayer.next();
      }
    });

    _audioPlayer.current.listen((playingAudio) {
      // Update the UI when the current audio changes (optional).
      if (playingAudio != null) {
        setState(() {
          _totalDuration = playingAudio.audio.duration;
        });
      }
      // Update the progress bar every second.
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {});
      });
    });







    _audioPlayer.currentPosition.listen((position) {
      // Sync the progress bar with the audio position.
      // This will be called continuously as the audio plays.
      setState(() {
        _currentPosition = position;
      });
    });
  }




  List<Audio> _getAudioList() {
    // Replace this with your list of songs containing audio URLs and names.
    return [
      Audio.network(
        data.audio_file!,
        metas: Metas(
          id: data.audio_file!,
          title: data.audio_name!,
          image:   MetasImage.network(
            data.cover_photo.toString(),
          ),
        ),
      ),
      Audio.network(
        'https://dazzingshadow.com/meditation_app/public/admin_asset/Podcast_Files/1693203220.meditation 2 .mp3',
        metas: Metas(
          title: 'Song 2',
          artist: 'Artist 2',
          album: 'Album 2',
          image: const MetasImage.network('URL_OF_ALBUM_ART_2'),
        ),
      ),
      // Add more songs as needed.
    ];
  }
*//*




  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:Container(
        // margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),

        width: double.infinity,
        height:  double.infinity,//MediaQuery.of(context).size.height,

        decoration: ShapeDecoration(

          image: DecorationImage(

            image: NetworkImage(widget.data.cover_photo!),
            fit: BoxFit.cover,

          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),

        child:  Column(
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
                  Text(widget.data.audio_name!, style: TextStyle(
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
                  ),),


                ],


              )

              ,

            ),


            const  Spacer(),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                IconButton(onPressed: (){

                  //  rewind(10);
                  _audioPlayer
                      .seekBy(const Duration(seconds: -10));

                }, icon: const Icon(Icons.replay_10_outlined,color: Colors.white,)),

                IconButton(onPressed: (){


                  _audioPlayer.previous();
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
                      icon: isPlaying
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow),
                      onPressed: () async {
                        if (isPlaying) {

                          _audioService.pause();

                         // _audioPlayer.pause();
                          isPlaying=false;
                        } else {

                          await _audioService.loadEpisode(data);


                          _audioService.play();
                          isPlaying=true;
                        }
                      },
                    ),
                  ),

                ),
                IconButton(onPressed: (){
                  _audioPlayer.next();
                }, icon: const Icon(Icons.skip_next,color: Colors.white)),
                IconButton(onPressed: (){
                  //  fastForward(10);

                  _audioPlayer
                      .seekBy(const Duration(seconds: 10));

                }, icon: const Icon(Icons.forward_10_outlined,color: Colors.white)),



              ],


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








}
*/
