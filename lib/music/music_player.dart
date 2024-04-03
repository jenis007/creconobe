import 'dart:math';
import 'dart:developer' as d;
import 'package:creconobe_transformation/models/audioDataModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/music_player_controller.dart';
import '../generated/assets.dart';

class MusicPlayer extends StatelessWidget {
  MusicPlayer({
    super.key,
  });

  final _ctr = Get.find<MusicPlayerCtr>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,  backgroundColor: Colors.green,iconTheme: IconThemeData(color: Colors.white),
          title: const Text("Playing Music",
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
        ),
        body: Obx(
          () => _ctr.modelMusic.value.id.isNotEmpty
              ? Container(
                  color: Colors.grey.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Container(
                                height: 5,
                              ),

                              //backbutton

                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(5.0, 5.0),
                                  )
                                ]),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FadeInImage(
                                    image: NetworkImage(_ctr.modelMusic.value.imgUrl),
                                    fit: BoxFit.cover,
                                    placeholder: const AssetImage(Assets.placeHolder),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(_ctr.modelMusic.value.title,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(_ctr.modelMusic.value.tag,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
                      Expanded(
                          child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Column(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          SliderTheme(
                                            data: SliderTheme.of(context)
                                                .copyWith(
                                                  trackHeight: 2.0,
                                                )
                                                .copyWith(
                                                  thumbShape: HiddenThumbComponentShape(),
                                                  activeTrackColor: Colors.green,
                                                  inactiveTrackColor: Colors.grey.shade300,
                                                  valueIndicatorTextStyle: Theme.of(context).textTheme.caption,
                                                ),
                                            child: ExcludeSemantics(
                                              child: Slider(
                                                min: 0.0,
                                                activeColor: Colors.grey.shade400,
                                                max: _ctr.duration.value.inMilliseconds.toDouble(),
                                                value: min(_ctr.bufferedPosition.value.inMilliseconds.toDouble(),
                                                    _ctr.duration.value.inMilliseconds.toDouble()),
                                                onChanged: (value) {
                                                  _ctr.dragPosition(value);
                                                },
                                                onChangeEnd: (value) {
                                                  _ctr.dragPositionEnd(Duration(milliseconds: value.round()));
                                                },
                                              ),
                                            ),
                                          ),
                                          SliderTheme(
                                            data: SliderTheme.of(context).copyWith(
                                              activeTrackColor: Colors.green,
                                              inactiveTrackColor: Colors.transparent,
                                              thumbColor: Colors.green,
                                            ),
                                            child: Slider(
                                              min: 0.0,
                                              max: _ctr.duration.value.inMilliseconds.toDouble(),
                                              value: min(
                                                  _ctr.dragValue.value < 0
                                                      ? _ctr.position.value.inMilliseconds.toDouble()
                                                      : _ctr.dragValue!.value,
                                                  _ctr.duration.value.inMilliseconds.toDouble()),
                                              onChanged: (value) {
                                                _ctr.dragPosition(value);
                                              },
                                              onChangeEnd: (value) {
                                                _ctr.dragPositionEnd(Duration(milliseconds: value.round()));
                                              },
                                            ),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Text(printDuration(_ctr.position.value), style: TextStyle(fontSize: 14)),
                                        const Spacer(),
                                        Text(printDuration(_ctr.duration.value), style: TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(15),
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                        child: const Icon(
                                          Icons.replay,
                                          color: Colors.transparent,
                                          size: 25,
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _ctr.previousMusic(context);
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(15),
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                        child: const Icon(
                                          Icons.skip_previous_outlined,
                                          color: Colors.green,
                                          size: 35,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (_ctr.modelMusic.value.isPlay) {
                                        _ctr.pauseMusic(context);
                                      } else {
                                        _ctr.resumeMusic(context);
                                      }
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(22),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade400,
                                                  offset: Offset(2.0, 2.0),
                                                  blurRadius: 10,
                                                  spreadRadius: 1)
                                            ]),
                                        child: _ctr.modelMusic.value.isLoad || _ctr.modelMusic.value.isBuffer
                                            ? const SizedBox(
                                                height: 25,
                                                width: 25,
                                                child: CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : Icon(
                                                _ctr.modelMusic.value.isPlay ? Icons.pause : Icons.play_arrow,
                                                color: Colors.white,
                                                size: 26,
                                              )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      d.log("player.currentIndex!--------------> ${_ctr.player.currentIndex! + 1}");

                                      _ctr.nextMusic(context);
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(15),
                                        decoration:
                                            const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                                        child: const Icon(
                                          Icons.skip_next_outlined,
                                          color: Colors.green,
                                          size: 35,
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _ctr.seekMusic(Duration.zero);
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(15),
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                        child: const Icon(
                                          Icons.replay,
                                          color: Colors.green,
                                          size: 25,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )),
                      InkWell(
                        onTap: () {
                          String url = "https://youtube.com/@Creconobe?si=W5zJL36-lq_dH8yP";
                          Uri uri = Uri.parse(url);

                          _launchInBrowser(uri);
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: 50,
                          margin: const EdgeInsets.only(left: 120, right: 120, bottom: 10, top: 10),
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFF0000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              Text(
                                'Youtube',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        ));
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

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours) == "00" ? "" : "${twoDigits(duration.inHours)}:"}$twoDigitMinutes:$twoDigitSeconds";
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}
