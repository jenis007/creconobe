import 'dart:developer';
import 'dart:ffi';

import 'package:creconobe_transformation/dashboard/allList.dart';
import 'package:creconobe_transformation/dashboard/books/bookIntro.dart';
import 'package:creconobe_transformation/mediaPlayer/audio_service.dart';
import 'package:creconobe_transformation/models/album.dart';
import 'package:creconobe_transformation/models/dashboardModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dio/dio.dart';
import '../../apiservices/api_interface.dart';

import '../models/audioDataModel.dart';
import '../models/booksDataModel.dart';
import '../prefManager.dart';

class AllHomePage extends StatefulWidget {
  const AllHomePage({super.key});

  @override
  State<AllHomePage> createState() => _AllHomePage();
}

class _AllHomePage extends State<AllHomePage> {
  List<Album> recommended = [];
  List<Album> playlists = [];
  List<Album> brain_waves = [];
  List<Album> relax = [];
  List<BooksDataModel> pdf = [];

  List<String> growthplanString = <String>[
    "Specific goals",
    "Expand network",
    "Tips for Sleeping",
    "Business Strategy",
    "Business Strategy",
    "Tips for Sleeping"
  ];

  List<String> imageList = <String>[
    "assets/images/playlist1.png",
    "assets/images/nature1.png",
    "assets/images/mental_peace.png",
    "assets/images/nature1.png",
    "assets/images/playlist1.png",
    "assets/images/yoga.png"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        body: FutureBuilder<DashboardModel>(
      future: getDashboard(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the data is being fetched, show a loading indicator
          return const Center(child: CircularProgressIndicator(color: Colors.green));
        } else if (snapshot.hasData) {
          recommended = snapshot.data!.recommended;
          playlists = snapshot.data!.playlists;
          brain_waves = snapshot.data!.brain_waves;
          relax = snapshot.data!.relax;
          pdf = snapshot.data!.pdf;

          return SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text("Recommended",
                        style: TextStyle(
                            fontSize: 14, color: HexColor("#515979"), fontFamily: GoogleFonts.poppins().fontFamily)),
                  ),
                  const Spacer(),
                ],
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 15, 10, 0),
                height: 155,
                child: ListView.builder(
                  itemCount: recommended.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        log("recommended--------------> ${recommended[index]}");

                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return AllList(recommended[index].id.toString(), recommended[index].name.toString());
                        }));
                      },
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: 250,
                          height: 150,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(recommended[index].cover_photo),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 25, 25, 0),
                                child: Text(
                                  recommended[index].name!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.80,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                                child: Text(
                                  recommended[index].description!,
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    //fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(30, 0, 0, 20),
                                      child: const Icon(
                                        Icons.headphones,
                                        color: Colors.white,
                                      )),
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                                      child: const Icon(
                                        Icons.local_movies_sharp,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ],
                          )),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text("Playlist",
                        style: TextStyle(
                            fontSize: 14, color: HexColor("#515979"), fontFamily: GoogleFonts.poppins().fontFamily)),
                  ),
                  const Spacer(),
                ],
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 15, 10, 0),
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: playlists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return AllList(playlists[index].id.toString(), playlists[index].name.toString());
                        }));
                      },
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: 250,
                          height: 195,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(playlists[index].cover_photo),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 25, 25, 0),
                                child: Text(
                                  playlists[index].name!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.80,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                child: Text(
                                  playlists[index].description!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    //fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 50, 25),
                                alignment: Alignment.centerLeft,
                                width: 140,
                                height: 50,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Play Now',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: GoogleFonts.poppins().fontFamily,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.play_circle)
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),

              //Personal-Business Growth plan text
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text("Personal-Business Growth plan",
                        style: TextStyle(
                            fontSize: 14, color: HexColor("#515979"), fontFamily: GoogleFonts.poppins().fontFamily)),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 15, 10, 0),
                height: 140,
                child: ListView.builder(
                  itemCount: relax.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return AllList(relax[index].id.toString(), relax[index].name.toString());
                        }));
                      },
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          width: 155,
                          height: 140,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(relax[index].cover_photo),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),

                          // alignment: Alignment.center,
                          child: Column(
                            children: [
                              const Spacer(),
                              Container(
                                  margin: const EdgeInsets.fromLTRB(20, 10, 5, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Center(
                                    child: Text(
                                      relax[index].name.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: GoogleFonts.poppins().fontFamily),
                                    ),
                                  )),
                              const SizedBox(
                                height: 5,
                              )
                            ],
                          )),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),

              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                height: 140,
                child: ListView.builder(
                  itemCount: pdf.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return BookIntro(pdf[index]);
                        }));
                      },
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          width: 145,
                          height: 140,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(pdf[index].book_cover!),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),

                          // alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.fromLTRB(20, 10, 5, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Center(
                                    child: Text(
                                      pdf[index].book_name.toString(),
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: GoogleFonts.poppins().fontFamily),
                                    ),
                                  )),
                            ],
                          )),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),

              /*SafeArea(
          child: SizedBox(

          width: double.infinity,
          height: 270,
          child: GridView.builder(
          //    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(

          maxCrossAxisExtent: 150,
          childAspectRatio: 2 / 2,
          //  crossAxisSpacing: 10,
          // mainAxisSpacing:10
          ),
          itemBuilder: (context, index) {
          return GridTile(
          child: Container(
          margin:const EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: 145,
          height: 140,
          decoration: ShapeDecoration(
          gradient: const LinearGradient(
          begin: Alignment(0.90, 0.43),
          end: Alignment(-0.9, -0.43),
          colors: [Color(0xFFFC67A7), Color(0xFFF6815B)],
          ),

          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
          ),
          ),

          // alignment: Alignment.center,
          child: Column( children: [
          Container(

          margin:const EdgeInsets.fromLTRB(20, 10, 5, 0),

          alignment: Alignment.centerLeft,
          child:
          Center(child:Text(growthplanString[index],style: TextStyle(color: Colors.white, fontSize: 17,fontFamily: GoogleFonts.poppins().fontFamily),)
          ,)
          ),

          const Spacer(),

          Container(
          margin:const EdgeInsets.fromLTRB(20, 0, 0, 20),

          alignment: Alignment.centerLeft,
          child: const Icon(Icons.account_box,color: Colors.white,),

          )



          ],
          )
          )
          );
          },
          ),
          ),
          ),*/

              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text("Brain Waves",
                        style: TextStyle(
                            fontSize: 14, color: HexColor("#515979"), fontFamily: GoogleFonts.poppins().fontFamily)),
                  ),
                  const Spacer(),
                  /*Container(
                    margin: const EdgeInsets.fromLTRB(0,10, 20 ,0),
                    child:  Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.lightBlue,
                            fontFamily: GoogleFonts.poppins().fontFamily
                        )
                    ),
                  )*/
                ],
              ),

              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 15, 10, 20),
                height: 200,
                child: ListView.builder(
                  itemCount: brain_waves.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return AllList(brain_waves[index].id.toString(), brain_waves[index].name.toString());
                        }));
                      },
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: 250,
                          height: 195,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(brain_waves[index].cover_photo),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                                child: Text(
                                  brain_waves[index].name.toString(),
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.80,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                child: Text(
                                  brain_waves[index].description.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    //fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 50, 25),
                                alignment: Alignment.centerLeft,
                                width: 140,
                                height: 50,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Play Now',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: GoogleFonts.poppins().fontFamily,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.play_circle)
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),

              /*    //body exccrises asanas
          Row(
          children: [
          Container(
          margin: const EdgeInsets.fromLTRB(20,10, 0 ,0),
          child:  Text(
          "Body Exercises Asanas",
          style: TextStyle(
          fontSize: 14,
          color: HexColor("#515979"),
          fontFamily: GoogleFonts.poppins().fontFamily
          )
          ),
          ),
          const  Spacer(),
            Container(
                    margin: const EdgeInsets.fromLTRB(0,10, 20 ,0),
                    child:  Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.lightBlue,
                            fontFamily: GoogleFonts.poppins().fontFamily
                        )
                    ),
                  )*/

              /*



          ],

          ),


          //yoga
          Container(

          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 10, 10, 20),

          height: 200,
          child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
          Container(
          margin: const EdgeInsets.fromLTRB(10,0, 10 ,0),
          width: 250,
          height: 195,

          decoration: ShapeDecoration(

          image: DecorationImage(
          image: AssetImage(imageList[5]),
          fit: BoxFit.fill,
          ),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
          ),
          ),

          child:Column(
          children: [
          Container(
          margin: const EdgeInsets.fromLTRB(0, 25, 70, 0),
          child: Text(
          'Yog Asana',
          style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w600,

          letterSpacing: 0.80,
          ),
          ),
          ),
          Container(

          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Text(
          'Sometimes the most productive thing you can do is relax.',

          style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: GoogleFonts.poppins().fontFamily,
          //fontWeight: FontWeight.w600,
          ),
          ),
          ),
          const Spacer(),
          Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 50, 25),
          alignment: Alignment.centerLeft,
          width: 140,
          height: 50,
          decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          ),
          ),

          child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
          'Play Now',
          style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.bold

          ),


          ),

          const  SizedBox(width: 5),
          const Icon(Icons.play_circle)



          ],

          ),

          )

          ],

          )


          ),
          Container(
          margin: const EdgeInsets.fromLTRB(0,0, 10 ,0),
          width: 250,
          height: 195,

          decoration: ShapeDecoration(

          image: DecorationImage(
          image: AssetImage(imageList[5]),
          fit: BoxFit.fill,
          ),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
          ),
          ),

          child:Column(
          children: [
          Container(
          margin: const EdgeInsets.fromLTRB(0, 25, 70, 0),
          child: Text(
          'Relax Sounds ',
          style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w600,

          letterSpacing: 0.80,
          ),
          ),
          ),
          Container(

          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Text(
          'Sometimes the most productive thing you can do is relax.',

          style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: GoogleFonts.poppins().fontFamily,
          //fontWeight: FontWeight.w600,
          ),
          ),
          ),
          const Spacer(),
          Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 50, 25),
          alignment: Alignment.centerLeft,
          width: 140,
          height: 50,
          decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          ),
          ),

          child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
          'Play Now',
          style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.bold

          ),


          ),

          const  SizedBox(width: 5),
          const Icon(Icons.play_circle)



          ],

          ),

          )

          ],

          )


          ),
          Container(
          margin: const EdgeInsets.fromLTRB(0,0, 10 ,0),
          width: 250,
          height: 195,

          decoration: ShapeDecoration(

          image: DecorationImage(
          image: AssetImage(imageList[5]),
          fit: BoxFit.fill,
          ),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
          ),
          ),

          child:Column(
          children: [
          Container(
          margin: const EdgeInsets.fromLTRB(0, 25, 70, 0),
          child: Text(
          'Relax Sounds ',
          style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w600,

          letterSpacing: 0.80,
          ),
          ),
          ),
          Container(

          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Text(
          'Sometimes the most productive thing you can do is relax.',

          style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: GoogleFonts.poppins().fontFamily,
          //fontWeight: FontWeight.w600,
          ),
          ),
          ),
          const Spacer(),
          Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 50, 25),
          alignment: Alignment.centerLeft,
          width: 140,
          height: 50,
          decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          ),
          ),

          child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
          'Play Now',
          style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.bold

          ),


          ),

          const  SizedBox(width: 5),
          const Icon(Icons.play_circle)



          ],

          ),

          )

          ],

          )


          ),
          */

              /*       Container(
                        margin: const EdgeInsets.fromLTRB(0,0, 10 ,0),
                        width: 250,
                        height: 195,

                        decoration: ShapeDecoration(

                          image: DecorationImage(
                            image: AssetImage(imageList[5]),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),

                        child:Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 25, 70, 0),
                              child: Text(
                                'Relax Sounds ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w600,

                                  letterSpacing: 0.80,
                                ),
                              ),
                            ),
                            Container(

                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                              child: Text(
                                'Sometimes the most productive thing you can do is relax.',

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  //fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 50, 25),
                              alignment: Alignment.centerLeft,
                              width: 140,
                              height: 50,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Play Now',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                        fontWeight: FontWeight.bold

                                    ),


                                  ),

                                  const  SizedBox(width: 5),
                                  const Icon(Icons.play_circle)



                                ],

                              ),

                            )

                          ],

                        )


                    ),*/

              /*

          ],
          ),
          ),*/
            ],
          ));
        } else if (snapshot.hasError) {
          //  profileModel = snapshot!;
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const Center(child: Text("Something went wrong. Please try again !"));
        }
      },
    ));
  }

  Future<DashboardModel> getDashboard() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token") ?? ''; // Add a fallback value in case 'token' is not found

    String? token = await PrefManager.getString("token");

    ApiInterface apiInterface = ApiInterface(Dio());

    return apiInterface.getDashboard(token!);
  }
}
