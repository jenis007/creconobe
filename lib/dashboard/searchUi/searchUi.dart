import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

import '../../apiservices/api_interface.dart';
import '../../colors/colors.dart';
import '../../controller/music_player_controller.dart';
import '../../mediaPlayer/mediaPlayer.dart';
import '../../models/albumById.dart';
import '../../models/audioDataModel.dart';
import '../../models/audioPlayListModel.dart';
import 'package:dio/dio.dart';

import '../../music/music_player.dart';
import '../../prefManager.dart';

class SearchUi extends StatefulWidget {
  List<Data> originalList;
  String type;
  SearchUi(this.originalList, this.type, {super.key});

  @override
  State<SearchUi> createState() => _SearchUi();
}

class _SearchUi extends State<SearchUi> {
  final TextEditingController _searchController = TextEditingController();
  final _ctr = Get.find<MusicPlayerCtr>();

  final logger = Logger();
  // late AlbumById filteredList;

  late List<Data> originalList;
  List<Data> filteredList = [];

  @override
  void initState() {
    super.initState();

    originalList = widget.originalList;
    filteredList = List.from(originalList);
  }

  void filterList(String query) {
    setState(() {
      filteredList = originalList
          .where((item) =>
              item.audio_name.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.singer.toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search...",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 40,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.textBoxColor,
              border: Border.all(color: AppColors.textBoxColor),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x21000000),
                  blurRadius: 5.73,
                  offset: Offset(0, 0.97),
                  spreadRadius: 0,
                )
              ],
            ),
            child: TextField(
              readOnly: false,
              controller: _searchController,
              onChanged: filterList,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: InputBorder.none,
                hintText: "Search in playlist....",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (BuildContext context, int index) {
                  final coverPhoto = filteredList[index].cover_photo;
                  return ListTile(
                    onTap: () {
                      playerMedia(index, filteredList, filteredList[index].playable);
                    },
                    title: Column(
                      children: [
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
                                        child: Text(filteredList[index].audio_name!,
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
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    height: 15,
                                    child: Text(
                                      "${filteredList[index].singer!}  ${filteredList[index].audio_episode!}",
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
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          height: 1.5,
                          color: HexColor("#07B464"),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  void playerMedia(int index, List<Data> data, bool playable) {
    if (playable) {
      //  NewAudioPlayerState().init(data);

      if (_ctr.modelMusic.value.id.isEmpty ||
          data[index].id.toString() != _ctr.modelMusic.value.id ||
          (data[index].id.toString() == _ctr.modelMusic.value.id) && (!_ctr.modelMusic.value.isPlay) ||
          _ctr.playListTitle != widget.type) {
        _ctr.playMusic(widget.type, data, index);
      }
      Get.to(() => MusicPlayer());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Subscription is required'), backgroundColor: Colors.red));
    }
  }
}
