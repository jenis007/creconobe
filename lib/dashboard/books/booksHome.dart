import 'package:creconobe_transformation/dashboard/books/bookIntro.dart';
import 'package:creconobe_transformation/dashboard/books/dummy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

import '../../apiservices/api_interface.dart';
import '../../models/audioPlayListModel.dart';
import 'package:dio/dio.dart';

import '../../models/booksDataModel.dart';
import '../../models/booksMainModel.dart';
import '../../prefManager.dart';

class BooksHome extends StatefulWidget {
  const BooksHome({super.key});

  @override
  State<BooksHome> createState() => _BooksHome();
}

class _BooksHome extends State<BooksHome> {
  final logger = Logger();
  ApiInterface apiInterface = ApiInterface(Dio());
  late List<BooksDataModel> audioList;

  late List<BooksDataModel> originalList;

  String imgUrl =
      "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: Column(
        children: [

          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text(
              'Explore Books',
              style:
                  TextStyle(color: const Color(0xFF4A4A4A), fontSize: 16, fontFamily: GoogleFonts.manrope().fontFamily),
            ),
          ),

          /*    Container(
              width: double.maxFinite,
              height: 50,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),


              child:  TextField(
                controller: _searchController,
                onChanged: filterList,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  // Add a clear button to the search bar
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    //  filterJobs(_searchController.text);

                    },
                  ),
                  // Add a search icon or button to the search bar
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                   //   filterJobs(_searchController.text);


                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),

              ),


          ),*/

          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BookSearchUi(originalList, "PodcastHome"), //const PlayList( tag: 'Playlists',title:'Podcast'),
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
                  child: const Text("Search..."))),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder<BooksMainModel>(
                future: getAudioFiles(),
                // Your API call returning a Future<Profile>
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While the data is being fetched, show a loading indicator

                    return const Center(child: CircularProgressIndicator(color: Colors.green));
                  } else if (snapshot.hasData) {
                    // logger.d("book list list ==== ${audioList.data.first.book_name}");

                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                          itemCount: audioList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final coverPhoto = audioList[index].book_cover;
                            final coverName = audioList[index].book_name;

                            return ListTile(
                              onTap: () {
                                if (audioList[index].playable == false) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text('Subscription is required'), backgroundColor: Colors.red));
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookIntro(audioList[index]),
                                    ),
                                  );
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
                                            image: NetworkImage(coverPhoto.toString()),
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
                                                  width: 180, // Example fixed width
                                                  child: Text(audioList[index].book_name.toString(),
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
                                              width: 180,
                                              alignment: Alignment.centerLeft,
                                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                              height: 15,
                                              child: Text(
                                                "${audioList[index].book_name.toString()}  ${audioList[index].tag.toString()}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
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
                    Object? exception = snapshot.error;
                    //  print("exception $exception");
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(child: Text("Something went wrong. Please try again !"));
                  }
                }),
          ),
        ],
      ),
    );
  }

  Future<BooksMainModel> getAudioFiles() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token") ?? ''; // Add a fallback value in case 'token' is not found

    String? token = await PrefManager.getString("token");
    logger.d(" token to String $token");

    var model = await apiInterface.getAlleBooks(token!, "");

    audioList = model.data;

    originalList = model.data;

    return apiInterface.getAlleBooks(token, "");
  }
}
