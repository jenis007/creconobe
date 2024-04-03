import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:creconobe_transformation/models/audioDataModel.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class NewAudioPlayer extends  StatefulWidget{

 const NewAudioPlayer({super.key,
    required this.data
  });

  @override
  State<NewAudioPlayer> createState() => _NewAudioPlayer();
  final Data data;
}

class _NewAudioPlayer extends State<NewAudioPlayer> {



  late AudioPlayer _audioPlayer;



  Stream<PositionalData>get _positionDataStream =>Rx.combineLatest3<Duration,Duration,Duration?,PositionalData>(_audioPlayer.positionStream, _audioPlayer.bufferedPositionStream, _audioPlayer.durationStream, (position, bufferedPosition,duration) => PositionalData(
    position,bufferedPosition,duration??Duration.zero,
  ));



  late ConcatenatingAudioSource _playList;
  
  
  

  @override
  void initState(){
    super.initState();
    _audioPlayer = AudioPlayer();
     _playList = ConcatenatingAudioSource(children: [
      AudioSource.uri(
          Uri.parse("https://dazzingshadow.com/meditation_app/public/admin_asset/Podcast_Files/1693207208.meditation 12.mp3"
          ),
          tag: MediaItem(id: '0', title: 'Nature Song',artist: "public ",artUri: Uri.parse("https://dazzingshadow.com/meditation_app/public/admin_asset/Podcast_Images/1693207207.spiritualism-4552237_1920.jpg")
          )
      ),
      AudioSource.uri(
          Uri.parse(widget.data.audio_file.toString()
          ),
          tag: MediaItem(id: widget.data.id.toString(), title: widget.data.audio_name.toString(),artist: widget.data.audio_album.toString(),artUri: Uri.parse(widget.data.cover_photo.toString())
          )
      ),
    ]);
    _init();


  }


  Future<void>_init()async{
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(_playList);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body:
    Column(

      children: [


        StreamBuilder<SequenceState?>(
            stream: _audioPlayer.sequenceStateStream,
            builder: (context,snapshot)
            {
              final state = snapshot.data;
              if(state?.sequence.isEmpty??true)
                {
                  return const SizedBox();
                }
              final metaData = state!.currentSource!.tag as MediaItem;

              return MediaMetaData(imageUrl: metaData.artUri.toString(), title: metaData.title, artist: metaData.artist??'');
            }

        ),

        const SizedBox(height: 20),

        StreamBuilder<PositionalData>(
          stream: _positionDataStream,
          builder: (context,snapshot)
          {
            final positionData = snapshot.data;
            return ProgressBar(
              progress: positionData?.position??Duration.zero,
              buffered:positionData?.bufferedPosition??Duration.zero ,
              total: positionData?.duration??Duration.zero,
              onSeek: _audioPlayer.seek,
            );
          }

      ),

      const SizedBox(height: 20),


      Controls(audioPlayer: _audioPlayer)
      
    ],),);
  }
  
}
class Controls extends StatelessWidget{
  const Controls(
      {super.key,required this.audioPlayer}

      );

  final AudioPlayer audioPlayer;


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context,snapshot)
        {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing??false;


          if(!(playing??false)) {
            return IconButton(onPressed: audioPlayer.play,
                icon: const Icon(Icons.play_arrow,color: Colors.black,
                )
            );
          }
          else if(processingState != ProcessingState.completed)
            {
              return IconButton(onPressed: audioPlayer.pause, icon:const Icon(Icons.pause,color: Colors.black,));
            }
          return const Icon(
            Icons.play_arrow,
            color: Colors.black,
          );

        }

    );



  }


}
class PositionalData {
const PositionalData(
    this.position,
    this.bufferedPosition,
    this.duration
    );

final Duration position;
final Duration bufferedPosition;
final Duration duration;
}


class MediaMetaData  extends StatelessWidget{
  const MediaMetaData({
    super.key, required this.imageUrl, required this.title, required this.artist

  });

  final String imageUrl;
  final String title;
  final String artist;




  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          width: 300,
          height: 300,
        ),
        Text(title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),
        ),
        const SizedBox(height: 8,),

        Text(title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }


}



