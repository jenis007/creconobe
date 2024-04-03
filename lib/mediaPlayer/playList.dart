import 'dart:core';
import 'dart:ffi';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:creconobe_transformation/models/audioPlayListModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../../apiservices/api_interface.dart';
import '../../mediaPlayer/audioPlayer.dart';
import '../../notification.dart';
import '../../prefManager.dart';

class PlayList extends StatefulWidget{
  final String tag;

  final String title;

  const PlayList({required this.tag,required this.title, Key? key}) : super(key: key);



  @override
  State<PlayList> createState() => _PlayList ();


}

class _PlayList extends  State<PlayList>{
  final logger = Logger();
  ApiInterface apiInterface = ApiInterface(Dio());
  late AudioPlayListModel audioList;
  final NotificationHandler notificationHandler = NotificationHandler();
  String imgUrl ="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";




  @override
  Widget build(BuildContext context) {
    // TODO: implement build

      return Scaffold(
       appBar: AppBar(
         iconTheme: const IconThemeData(color: Colors.black), // Set back button color to black
         centerTitle: true, // Align the app bar title text in the center
         title: Text(widget.title,style: const TextStyle(color: Colors.black),),
         backgroundColor: Colors.white,
       ),
       body:Column(
         children: [
           Container(
               margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),

               height: 230,

               decoration: ShapeDecoration(

                 image: DecorationImage(

                   image: NetworkImage(imgUrl),
                   fit: BoxFit.fill,
                 ),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10),
                 ),
               ),

               child: Container(

                 alignment: Alignment.bottomLeft,
                 child:
                 BlurryContainer(
                   borderRadius: const BorderRadius.only(
                     bottomLeft: Radius.circular(10),
                     bottomRight: Radius.circular(10)

                   ),

                   blur: 5,
                   height: 60,
                   elevation: 0,
                   color: Colors.transparent,
                   child:  Row(children: [

                     Column(

                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Container(
                           margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                           child:  Text("Enjoy The Nature",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: GoogleFonts.manrope.toString(),fontWeight: FontWeight.bold),),


                         ),
                         Container(
                           margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                           child: const Text("Total episodes 12",style: TextStyle(color: Colors.white),),


                         ),



                       ],


                     ),


                     const Spacer(),

                     Column(
                       mainAxisAlignment: MainAxisAlignment.end,

                       children: [

                         Container(
                           margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                           width: 40,
                           height: 40,
                           decoration: ShapeDecoration(
                             color: Colors.white,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(20),
                             ),
                           ),

                           child: Center(
                             child: IconButton(onPressed: (){

                             }, icon: const Icon(Icons.play_arrow)),
                           ),

                         ),
                       ],

                     )





                   ],),
                 ),

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

                     return   SizedBox(
                       height: 150,
                       child: ListView.builder(


                           itemCount: audioList.data.length,
                           itemBuilder: (BuildContext context, int index){
                             final coverPhoto = audioList.data[index].cover_photo;
                             final coverName = audioList.data[index].audio_name;
                             return   ListTile(
                               onTap: (){

                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) => const PlayList( tag: 'Podcast',title:'Podcast'),
                                   ),
                                 );
                               },
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
                                       IconButton(icon:const Icon( Icons.play_circle_outline_sharp), onPressed: () {


                                         playAudio(audioList.data[index].audio_file,audioList.data[index].audio_name,audioList.data[index].audio_episode);

                                       },),
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

                                           const PopupMenuItem<int>(c
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




         ],
       )

    );

  }

  Future<AudioPlayListModel> getAudioFiles() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token") ?? ''; // Add a fallback value in case 'token' is not found
    NotificationHandler notificationHandler = NotificationHandler();

    await notificationHandler.initialize();
    String? token = await PrefManager.getString("token");



    logger.d(" title ==  ${widget.title}");

    logger.d(" tag ===  ${widget.tag}");
   // String title  = widget.title;

    return apiInterface.getAllPlaylist(token!,widget.tag.toString(),"");
  }

  void playAudio(String? audioFile, String? audio_name, String? audio_episode) {

    BackgroundMusicPlayer().setSongUrl(audioFile!);
    BackgroundMusicPlayer().play();
    notificationHandler.showNotification("Playing : ","${audio_name!} ${audio_episode!}");

  }

}

