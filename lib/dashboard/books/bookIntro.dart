import 'package:creconobe_transformation/dashboard/books/readBooks.dart';
import 'package:creconobe_transformation/models/booksDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

import '../../apiservices/api_interface.dart';
import '../../mediaPlayer/mediaPlayer.dart';
import '../../models/audioDataModel.dart';
import '../../models/audioPlayListModel.dart';
import 'package:dio/dio.dart';

import '../../prefManager.dart';

class BookIntro extends StatefulWidget {
  final BooksDataModel data;
  const BookIntro(this.data, {super.key});
  @override
  State<BookIntro> createState() => _BookIntro();
}

class _BookIntro extends State<BookIntro> {
  final logger = Logger();

  String imgUrl =
      "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.book_name.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: GoogleFonts.poppins.toString(),
              fontWeight: FontWeight.w500,
            )),
        backgroundColor: Colors.green,
        centerTitle: true,iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                // margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),

                width: double.infinity,
                height: 300, //MediaQuery.of(context).size.height,

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [HexColor("#DCD9FE"), Colors.white], // Define the colors for the gradient
                    begin: Alignment.topLeft, // Define the starting point of the gradient
                    end: Alignment.bottomRight, // Define the ending point of the gradient
                    // You can also provide other properties like stops, tileMode, etc.
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.data.book_cover.toString(),
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                )),
            SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10, left: 15),
                  height: 29,
                  child: Text(
                    widget.data.book_name.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: GoogleFonts.poppins.toString(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 10, left: 15),
                  height: 15,
                  child: Text(
                    'Introduction',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: GoogleFonts.poppins.toString(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                /* Container(
                   alignment: Alignment.topLeft,
                   margin: const EdgeInsets.only(top: 10,left: 15),
                   height: 29,
                   child: Text(
                     'I can never win with this body I live in. —Belly, “Star”',
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: 15,
                       fontFamily: GoogleFonts.poppins.toString(),
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                 ),*/
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Text(
                    widget.data.introduction.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontFamily: GoogleFonts.poppins.toString(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 20),
                    width: 154,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("#07B464"),
                          elevation: 2.5,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReadBooks(widget.data.book_pdf.toString(), widget.data.book_name.toString())),
                          );
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            const Icon(
                              Icons.menu_book_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text("Read",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: GoogleFonts.athiti().fontFamily)),
                          ],
                        )),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
