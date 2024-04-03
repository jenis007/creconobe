import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservices/api_interface.dart';
import '../../mediaPlayer/mediaPlayer.dart';
import '../../models/audioDataModel.dart';
import '../../models/audioPlayListModel.dart';
import 'package:dio/dio.dart';

import '../../prefManager.dart';
import '../controller/music_player_controller.dart';
import '../mediaPlayer/onlinePlayer.dart';
import '../models/albumById.dart';
import '../music/music_player.dart';
import '../music/preview_music.dart';

class AllList extends StatefulWidget {
  final String id;
  final String albumName;
  const AllList(this.id, this.albumName, {super.key});

  @override
  State<AllList> createState() => _AllList();
}

class _AllList extends State<AllList> {
  final logger = Logger();
  ApiInterface apiInterface = ApiInterface(Dio());
  late AlbumById audioList;
  String imgUrl =
      "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";

  String title = "Trending";

  final _ctr = Get.find<MusicPlayerCtr>();

  Future<void> getType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log("PrefManager--------------> ${prefs.getString('name')}");
  }

  @override
  void initState() {
    getType();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('rgvfrjnkv--');

    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      bottomNavigationBar: PreviewMusic(),
      body: FutureBuilder<AlbumById>(
          future: getAlbumFiles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: const Center(child: CircularProgressIndicator(color: Colors.green)),
              );
            } else if (snapshot.hasData) {
              audioList = snapshot.data!;
              log("snapshot.data--------------> ${snapshot.data}");

              return audioList.podcasts.isNotEmpty
                  ? ListView.builder(
                      itemCount: audioList.podcasts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final coverPhoto = audioList.podcasts[index].cover_photo;
                        return ListTile(
                          onTap: () {
                            //playerMedia(index,audioList.podcasts);
                            log("audioList.podcasts[index].playable--------------> ${audioList.podcasts[index].playable}");

                            if (audioList.podcasts[index].playable) {
                              if (_ctr.modelMusic.value.id.isEmpty ||
                                  audioList.podcasts[index].id.toString() != _ctr.modelMusic.value.id ||
                                  (audioList.podcasts[index].id.toString() == _ctr.modelMusic.value.id) &&
                                      (!_ctr.modelMusic.value.isPlay) ||
                                  _ctr.playListTitle != widget.albumName) {
                                _ctr.playMusic(widget.albumName, audioList.podcasts, index);
                              }
                              Get.to(() => MusicPlayer());
                            } else {
                              log("widget.albumName--------------> ${widget.albumName}");

                              // if (widget.albumName == "Relaxation Music" || widget.albumName == "Calm Music") {
                              //   if (_ctr.modelMusic.value.id.isEmpty ||
                              //       audioList.podcasts[index].id.toString() != _ctr.modelMusic.value.id ||
                              //       (audioList.podcasts[index].id.toString() == _ctr.modelMusic.value.id) &&
                              //           (!_ctr.modelMusic.value.isPlay) ||
                              //       _ctr.playListTitle != widget.albumName) {
                              //     _ctr.playMusic(widget.albumName, audioList.podcasts, index);
                              //   }
                              //   Get.to(() => MusicPlayer());
                              // } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('Subscription is required'), backgroundColor: Colors.red));
                              // }
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
                                              child: Text(audioList.podcasts[index].audio_name!,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    color: const Color(0xFF3E3E3E),
                                                    fontSize: 14,
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
                                            "${audioList.podcasts[index].singer!}  ${audioList.podcasts[index].audio_episode!}",
                                            style: TextStyle(
                                              color: const Color(0xFF3E3E3E),
                                              fontSize: 12,
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
                      })
                  : Center(child: Text("No Data".toString()));
            } else if (snapshot.hasError) {
              logger.d("error == ${snapshot.error.toString()}");
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(child: Text("Something went wrong. Please try again.".toString()));
            }
          }),
    );
  }

  Future<AlbumById> getAlbumFiles() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token") ?? ''; // Add a fallback value in case 'token' is not found

    String? token = await PrefManager.getString("token");

    logger.d(" token to String $token");
    logger.d(" id to String ${widget.id}");

    return apiInterface.getAlbumbyId(token!, widget.id);
  }
/*  void playerMedia(int index,List list) {
    final page = MediaPlayer(index: index,audioList:list);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>   page,//const PlayList( tag: 'Playlists',title:'Podcast'),
      ),
    );

  }*/
}
