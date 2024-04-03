import 'package:creconobe_transformation/apiservices/api_interface.dart';
import 'package:creconobe_transformation/dashboard/allHomepage.dart';
import 'package:creconobe_transformation/dashboard/books/booksHome.dart';
import 'package:creconobe_transformation/dashboard/business/businessHome.dart';
import 'package:creconobe_transformation/dashboard/mentalHealth/mentalHealth.dart';
import 'package:creconobe_transformation/dashboard/podcast/podcastHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

import '../controller/music_player_controller.dart';
import '../models/profileModel.dart';
import '../music/preview_music.dart';
import '../prefManager.dart';
import 'asana/asanaHome.dart';

class MainDashboard extends StatefulWidget {
  String name;
  MainDashboard(this.name, {super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final logger = Logger();
  ApiInterface apiInterface = ApiInterface(Dio());

  List<String> items = [
    "All",
    "Podcast",
    "Meditation",
    "Books",
    "Techniques",
  ];
  static const List<Widget> widgetOptions = <Widget>[
    AllHomePage(),
    PodcastHome(),
    MentalHealth(),
    BooksHome(),
    BusinessHome(),

    //  Asana()
  ];
  int current = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put((MusicPlayerCtr()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //${widget.name}
        appBar: AppBar(
          title: Text(
            "Hello ${widget.name}",
            style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: PreviewMusic(),
        body: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            width: 120,
                            height: 45,
                            decoration: BoxDecoration(
                              color: current == index ? Colors.green : Colors.white54,
                              borderRadius: current == index ? BorderRadius.circular(15) : BorderRadius.circular(10),
                              border: current == index ? Border.all(color: Colors.green, width: 2) : null,
                            ),
                            child: Center(
                              child: Text(
                                items[index],
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500, color: current == index ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Expanded(
              child: widgetOptions.elementAt(current),
            )
          ],
        ));
  }
}
