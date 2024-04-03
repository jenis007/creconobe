import 'package:creconobe_transformation/generated/assets.dart';
import 'package:creconobe_transformation/models/audioDataModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../controller/music_player_controller.dart';
import 'music_player.dart';

class PreviewMusic extends StatelessWidget {
  PreviewMusic({super.key});

  final MusicPlayerCtr _ctr = Get.find<MusicPlayerCtr>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !_ctr.modelMusic.value.isIdle
          ? InkWell(
              onTap: () {
                Get.to(() => MusicPlayer());
              },
              child: Container(
                height: 70,
                margin: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50), boxShadow: [
                  BoxShadow(color: Colors.grey.shade400, blurRadius: 15, spreadRadius: 1, offset: const Offset(5, 5))
                ]),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(1.0, 1.0),
                          )
                        ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: FadeInImage(
                            image: NetworkImage(_ctr.modelMusic.value.imgUrl),
                            fit: BoxFit.cover,
                            placeholder: const AssetImage(Assets.placeHolder),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_ctr.modelMusic.value.title,
                                  style:
                                      const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                _ctr.modelMusic.value.tag,
                                style: const TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            _ctr.previousMusic(context);
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            color: Colors.black54,
                          )),
                      InkWell(
                        onTap: () {
                          if (_ctr.modelMusic.value.isPlay) {
                            _ctr.pauseMusic(context);
                          } else if (_ctr.modelMusic.value.isPause) {
                            _ctr.resumeMusic(context);
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                          child: _ctr.modelMusic.value.isLoad || _ctr.modelMusic.value.isBuffer
                              ? const SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(
                                  _ctr.modelMusic.value.isPlay ? Icons.pause : Icons.play_arrow,
                                  size: 20,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            _ctr.nextMusic(context);
                          },
                          icon: const Icon(
                            Icons.skip_next,
                            color: Colors.black54,
                          )),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
