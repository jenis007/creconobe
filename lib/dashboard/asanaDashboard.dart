import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

import '../apiservices/api_interface.dart';
import '../models/audioPlayListModel.dart';
import 'package:dio/dio.dart';

import '../prefManager.dart';
class Asana extends StatefulWidget{
  const Asana({super.key});

  @override
  State<Asana> createState() => _Asana();

}

class _Asana extends State<Asana>{
  final logger = Logger();
  ApiInterface apiInterface = ApiInterface(Dio());
  late AudioPlayListModel audioList;

  String imgUrl ="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";





  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return  Scaffold(

      body:  Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              'Explore Asana',
              style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: 19.81,
                  fontFamily: GoogleFonts.manrope().fontFamily

              ),
            ),

          ),

          Container(
              width: double.maxFinite,
              height: 50,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),


              child: TextFormField(
                  obscureText: true,

                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(

                    labelText: "Search your favorite Asana...",
                    suffixIcon: const Icon(Icons.search),
                    suffixIconColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onEditingComplete: () => {


                  },
                  validator: (String? value) {

                    return null;
                  }
              )


          ),


          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text("On Trending",style: TextStyle(
                color: Color(0xFF4A4A4A),
                fontSize: 17.81,
                fontFamily: GoogleFonts.manrope().fontFamily
            ),
            ),


          ),



          FutureBuilder<AudioPlayListModel>(
              future: getAudioFiles(),
              // Your API call returning a Future<Profile>
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the data is being fetched, show a loading indicator


                  return const Center(
                      child: CircularProgressIndicator(color: Colors.green));
                }

                else if (snapshot.hasData) {
                  audioList = snapshot.data!;
                  logger.d("podcast list ==== ${audioList.data.first.cover_photo}");
                  return   Container(

                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),

                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(10,10, 10 ,0),
                          width: 160,
                          height: 190,

                          decoration: ShapeDecoration(

                            image: DecorationImage(

                              image: NetworkImage(audioList.data.first.cover_photo??imgUrl),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                        ),






                      ],
                    ),
                  );


                }

                else if (snapshot.hasError) {
                  //  profileModel = snapshot!;
                  logger.d("profile data == ${snapshot.error.toString()}");
                  return  Center(child: Text(snapshot.error.toString()));

                }
                else
                {

                  return const Text("xcculcjhvkhlvluhlv ");
                }
              }
          ),

          Container(
              margin: const EdgeInsets.fromLTRB(10,10, 10 ,0),
              child:Row(
                children: [

                  Text("What's New",
                      style: TextStyle(
                        color: Color(0xFF3E3E3E),
                        fontSize: 15.84,
                        fontFamily: GoogleFonts.manrope.toString(),
                        fontWeight: FontWeight.w700,
                      )
                  ),

                  const Spacer(),

                  Opacity(

                    opacity: 0.70,
                    child: Text(
                      'See All',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF3E3E3E),
                        fontSize: 11.88,
                        fontFamily: GoogleFonts.manrope.toString(),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )


                ],

              )

          ),

          Expanded(

            child:  FutureBuilder<AudioPlayListModel>(
                future: getAudioFiles(),
                // Your API call returning a Future<Profile>
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While the data is being fetched, show a loading indicator


                    return const Center(
                        child: CircularProgressIndicator(color: Colors.green));
                  }

                  else if (snapshot.hasData) {
                    audioList = snapshot.data!;
                    logger.d("podcast list ==== ${audioList.data.first.cover_photo}");

                    return   Container(
                      height: 150,
                      child: ListView.builder(
                          itemExtent: 100.0,


                          itemCount: audioList.data.length,
                          itemBuilder: (BuildContext context, int index){
                            final coverPhoto = audioList.data[index].cover_photo;
                            final coverName = audioList.data[index].audio_name;
                            return   ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      /*   Container(
                                     height: 60,
                                     width: 56,
                                     child: Image.network(coverPhoto!,),
                                     decoration: ShapeDecoration(
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(26),
                                       ),
                                     ),

                                   ),*/
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

                                        child:  Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Row(
                                              children: [
                                                Text(audioList.data[index].audio_name!,style: TextStyle(
                                                  color: Color(0xFF3E3E3E),
                                                  fontSize: 13.88,
                                                  fontFamily:  GoogleFonts.manrope.toString(),
                                                  fontWeight: FontWeight.w600,
                                                )
                                                ),

                                                const SizedBox(width: 5,),
                                                Image.asset("assets/images/premiumIcon.png",height: 14, width: 14,)



                                              ],


                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),

                                              height: 15,
                                              child:  Text("${audioList.data[index].singer!}  ${audioList.data[index].audio_episode!}", style: TextStyle(
                                                color: Color(0xFF3E3E3E),
                                                fontSize: 11.88,
                                                fontFamily:  GoogleFonts.manrope.toString(),
                                                fontWeight: FontWeight.w400,
                                              ),),



                                            )



                                          ],



                                        ),


                                      ),


                                      const  Spacer(),
                                      const  Icon(Icons.play_circle_outline_sharp),
                                      PopupMenuButton(
                                        // add icon, by default "3 dot" icon
                                        // icon: Icon(Icons.book)
                                          itemBuilder: (context){
                                            return [
                                              const PopupMenuItem<int>(
                                                value: 0,
                                                child: Text("Download"),
                                              ),

                                              /*  const PopupMenuItem<int>(
                                             value: 1,
                                             child: Text("Settings"),
                                           ),

                                           const PopupMenuItem<int>(
                                             value: 2,
                                             child: Text("Logout"),
                                           ),*/
                                            ];
                                          },
                                          onSelected:(value){
                                            if(value == 0){
                                              debugPrint("My account menu is selected.");
                                            }else if(value == 1){
                                              debugPrint("Settings menu is selected.");
                                            }else if(value == 2){
                                              debugPrint("Logout menu is selected.");
                                            }
                                          }
                                      )












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





                          }


                      ),


                    );


                  }

                  else if (snapshot.hasError) {
                    //  profileModel = snapshot!;
                    logger.d("profile data == ${snapshot.error.toString()}");
                    return  Center(child: Text(snapshot.error.toString()));

                  }
                  else
                  {

                    return const Text("xcculcjhvkhlvluhlv ");
                  }
                }
            ),),



          /* FutureBuilder<AudioPlayListModel>(
              future: getAudioFiles(),
              // Your API call returning a Future<Profile>
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the data is being fetched, show a loading indicator


                  return const Center(
                      child: CircularProgressIndicator(color: Colors.green));
                }

                else if (snapshot.hasData) {
                  audioList = snapshot.data!;
                  logger.d("podcast list ==== ${audioList.data.first.cover_photo}");

                  return   ListView.builder(
                      itemCount: audioList.data.length,
                      itemBuilder: (BuildContext context, int index){
                        final coverPhoto = audioList.data[index].cover_photo;
                        return  ListTile(
                          leading: coverPhoto != null ? Image.network(
                            coverPhoto,
                            height: 56,
                            width: 56,
                          ) :Image.network(
                            imgUrl,
                            height: 56,
                            width: 56,
                          ),
                        );
                      }


                  );


                }

                else if (snapshot.hasError) {
                  //  profileModel = snapshot!;
                  logger.d("profile data == ${snapshot.error.toString()}");
                  return  Center(child: Text(snapshot.error.toString()));

                }
                else
                {

                  return const Text("xcculcjhvkhlvluhlv ");
                }
              }
          ),*/













        ],
      ),

    );

  }

  Future<AudioPlayListModel> getAudioFiles() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token") ?? ''; // Add a fallback value in case 'token' is not found

    String? token = await PrefManager.getString("token");



    logger.d(" token to String $token");

    return apiInterface.getAllPlaylist(token!,"Excercise Asana","");
  }
}