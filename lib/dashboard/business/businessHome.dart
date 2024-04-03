import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

import '../../apiservices/api_interface.dart';
import '../../controller/music_player_controller.dart';
import '../../mediaPlayer/mediaPlayer.dart';
import '../../models/audioDataModel.dart';
import '../../models/audioPlayListModel.dart';
import 'package:dio/dio.dart';

import '../../music/music_player.dart';
import '../../prefManager.dart';
import '../allList.dart';
import '../allPodcasrList.dart';
import '../searchUi/searchUi.dart';

class BusinessHome extends StatefulWidget {
  const BusinessHome({super.key});

  @override
  State<BusinessHome> createState() => _BusinessHome();
}

class _BusinessHome extends State<BusinessHome> {
  final logger = Logger();
  ApiInterface apiInterface = ApiInterface(Dio());
  late AudioPlayListModel audioList;

  String imgUrl =
      "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";

  final _ctr = Get.find<MusicPlayerCtr>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text(
              'Explore Techniques',
              style:
                  TextStyle(color: const Color(0xFF4A4A4A), fontSize: 16, fontFamily: GoogleFonts.manrope().fontFamily),
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchUi(audioList.data, 'BusinessHome'), //const PlayList( tag: 'Playlists',title:'Podcast'),
                  ),
                );
              },
              child: Container(
                  width: double.maxFinite,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.82),
                    ),
                  ),
                  child: Text("Search..."))),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(20, 15, 0, 0),
            child: Text(
              "On Trending",
              style: TextStyle(
                  color: const Color(0xFF4A4A4A), fontSize: 17.81, fontFamily: GoogleFonts.manrope().fontFamily),
            ),
          ),
          FutureBuilder<AudioPlayListModel>(
              future: getAudioFiles(),
              // Your API call returning a Future<Profile>
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the data is being fetched, show a loading indicator

                  return const Center(child: CircularProgressIndicator(color: Colors.green));
                } else if (snapshot.hasData) {
                  audioList = snapshot.data!;
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: audioList.albums.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return AllList(
                                    audioList.albums[index].id.toString(), audioList.albums[index].name.toString());
                              }));
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              width: 160,
                              height: 150,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(audioList.albums[index].cover_photo),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                              ),
                            ));
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  logger.d("podcast list >>>> ${snapshot}");
                  //  profileModel = snapshot!;
                  logger.d("profile data == ${snapshot.error.toString()}");
                  return SizedBox(height: 100, child: Center(child: Text(snapshot.error.toString())));
                } else {
                  return const SizedBox(
                      height: 80, child: Center(child: Text("Something went wrong. Please try again !")));
                }
              }),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 25, 10, 20),
              child: Row(
                children: [
                  Text("What's New",
                      style: TextStyle(
                        color: const Color(0xFF3E3E3E),
                        fontSize: 16,
                        fontFamily: GoogleFonts.manrope.toString(),
                        fontWeight: FontWeight.w600,
                      )),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return AllPodcastList(audioList.data);
                      }));
                    },
                    child: Text(
                      'See All',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontFamily: GoogleFonts.manrope.toString(),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              )),
          FutureBuilder<AudioPlayListModel>(
              future: getAudioFiles(),
              // Your API call returning a Future<Profile>
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the data is being fetched, show a loading indicator

                  return const Center(child: CircularProgressIndicator(color: Colors.green));
                } else if (snapshot.hasData) {
                  audioList = snapshot.data!;
                  return SizedBox(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: audioList.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final coverPhoto = audioList.data[index].cover_photo;
                          final coverName = audioList.data[index].audio_name;
                          return ListTile(
                            onTap: () {
                              if (audioList.data[index].playable) {
                                if (_ctr.modelMusic.value.id.isEmpty ||
                                    audioList.data[index].id.toString() != _ctr.modelMusic.value.id ||
                                    (audioList.data[index].id.toString() == _ctr.modelMusic.value.id) &&
                                        (!_ctr.modelMusic.value.isPlay) ||
                                    _ctr.playListTitle != 'BusinessHome') {
                                  _ctr.playMusic('BusinessHome', audioList.data, index);
                                }
                                Get.to(() => MusicPlayer());
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('Subscription is required'), backgroundColor: Colors.red));
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
                                      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 180,
                                                height: 25, // Example fixed width
                                                child: Text(audioList.data[index].audio_name!,
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
                                              Container(
                                                margin: const EdgeInsets.only(left: 5, bottom: 6),
                                                alignment: Alignment.topCenter,
                                                child: Image.asset(
                                                  "assets/images/premiumIcon.png",
                                                  height: 14,
                                                  width: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            height: 15,
                                            child: Text(
                                              "${audioList.data[index].singer!}  ${audioList.data[index].audio_episode!}",
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
                        }),
                  );
                } else if (snapshot.hasError) {
                  //  profileModel = snapshot!;
                  logger.d("profile data == ${snapshot.error.toString()}");
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const SizedBox(
                      height: 80, child: Center(child: Text("Something went wrong. Please try again !")));
                }
              }),
        ],
      ),
    ));
  }

  Future<AudioPlayListModel> getAudioFiles() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token") ?? ''; // Add a fallback value in case 'token' is not found

    String? token = await PrefManager.getString("token");

    logger.d(" token to String $token");

    return apiInterface.getAllPlaylist(token!, "Techniques", "");
  }
}
