
class JustAudioModel{

  final String id;
  final String title;
  final String tag;
  final String audiUrl;
  final String imgUrl;
  final bool isStart;
  final bool isPlay;
  final bool isLoad;
  final bool isPause;
  final bool isBuffer;
  final bool isIdle;
  final bool isStop;

  JustAudioModel(
      {required this.id,
        required this.title,
        required this.tag,
        required this.audiUrl,
        required this.imgUrl,
        required this.isStart,
        required this.isPlay,
        required this.isLoad,
        required this.isIdle,
        required this.isPause,
        required this.isBuffer,
        required this.isStop});

}