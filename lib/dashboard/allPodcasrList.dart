import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

import '../../apiservices/api_interface.dart';
import '../../mediaPlayer/mediaPlayer.dart';
import '../../models/audioDataModel.dart';
import '../../models/audioPlayListModel.dart';
import 'package:dio/dio.dart';

import '../../prefManager.dart';
import '../controller/music_player_controller.dart';
import '../models/albumById.dart';
import '../music/music_player.dart';
import '../music/preview_music.dart';

class AllPodcastList extends StatefulWidget {
  List<Data> data;
  AllPodcastList(this.data, {super.key});

  @override
  State<AllPodcastList> createState() => _AllPodcastList();
}

class _AllPodcastList extends State<AllPodcastList> {
  final logger = Logger();
  ApiInterface apiInterface = ApiInterface(Dio());
  String imgUrl =
      "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";

  final _ctr = Get.find<MusicPlayerCtr>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Playlist"),
        centerTitle: true,
      ),
      bottomNavigationBar: PreviewMusic(),
      body: SizedBox(
        child: ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (BuildContext context, int index) {
              final coverPhoto = widget.data[index].cover_photo;
              return ListTile(
                onTap: () {
                  log("widget.data[index].playable--------------> ${widget.data[index].playable}");

                  if (widget.data[index].playable) {
                    if (_ctr.modelMusic.value.id.isEmpty ||
                        widget.data[index].id.toString() != _ctr.modelMusic.value.id ||
                        (widget.data[index].id.toString() == _ctr.modelMusic.value.id) &&
                            (!_ctr.modelMusic.value.isPlay) ||
                        _ctr.playListTitle != 'AllPodcastList') {
                      _ctr.playMusic('AllPodcastList', widget.data, index);
                    }
                    Get.to(() => MusicPlayer());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Subscription is required'), backgroundColor: Colors.red));
                  }
                },
                title: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 56,
                          height: 60,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(coverPhoto!),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 180,
                                    height: 25, // Example fixed width
                                    child: Text(widget.data[index].audio_name!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: const Color(0xFF3E3E3E),
                                          fontSize: 13.88,
                                          fontFamily: GoogleFonts.manrope.toString(),
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    "assets/images/premiumIcon.png",
                                    height: 14,
                                    width: 14,
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                height: 15,
                                child: Text(
                                  "${widget.data[index].singer!}  ${widget.data[index].audio_episode!}",
                                  style: TextStyle(
                                    color: const Color(0xFF3E3E3E),
                                    fontSize: 11.88,
                                    fontFamily: GoogleFonts.manrope.toString(),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.play_circle_outline_sharp),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

/*  void playerMedia(int index,List list) {

    final page = MediaPlayer(index: index,audioList:list);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,//const PlayList( tag: 'Playlists',title:'Podcast'),
      ),
    );

  }*/
}
