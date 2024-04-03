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

import '../../models/booksDataModel.dart';
import '../../music/music_player.dart';
import '../../prefManager.dart';
import 'bookIntro.dart';

class BookSearchUi extends StatefulWidget {

  List<BooksDataModel> originalList;
  String type;
  BookSearchUi(this.originalList,this.type,{super.key});

  @override
  State<BookSearchUi> createState() => _SearchUi();

}

class _SearchUi extends  State<BookSearchUi>{

  final TextEditingController _searchController = TextEditingController();
  final _ctr = Get.find<MusicPlayerCtr>();


  final logger = Logger();
  // late AlbumById filteredList;

  late List<BooksDataModel> originalList;
  List<BooksDataModel> filteredList = [];


  @override
  void initState() {
    super.initState();

    originalList = widget.originalList;
    filteredList = List.from(originalList);
  }

  void filterList(String query) {
    setState(() {
      filteredList = originalList.where((item) =>
      item.book_name.toString().toLowerCase().contains(query.toLowerCase())
          ||   item.authorname.toString().toLowerCase().contains(query.toLowerCase())

      ).toList();
    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: const Text("Search...",),centerTitle: true,),

      body:Column(
        children: [

          Container(
            alignment: Alignment.center,
            height: 40,
            margin: const EdgeInsets.only(top: 20,bottom: 20),
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
                hintText: "Search....",
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
                itemBuilder: (BuildContext context, int index){
                  final coverPhoto = filteredList[index].book_cover;
                  final coverName = filteredList[index].book_name;
                  return   ListTile(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  BookIntro(filteredList[index]),
                        ),
                      );                              },
                    title: Column(
                      children: [
                        const SizedBox(height: 10,),
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

                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Row(
                                    children: [

                                      SizedBox(
                                        width: 180, // Example fixed width
                                        child:  Text(filteredList[index].book_name.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,

                                            style: TextStyle(
                                              color: const Color(0xFF3E3E3E),
                                              fontSize: 14,
                                              fontFamily:  GoogleFonts.manrope.toString(),
                                              fontWeight: FontWeight.w600,
                                            )
                                        ),),


                                      const SizedBox(width: 5,),
                                      Image.asset("assets/images/premiumIcon.png",height: 14, width: 14,)



                                    ],


                                  ),
                                  Container(
                                    width: 180,
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),

                                    height: 15,
                                    child:  Text("${filteredList[index].book_name.toString()}  ${filteredList[index].tag.toString()}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: const Color(0xFF3E3E3E),
                                        fontSize: 12,
                                        fontFamily:  GoogleFonts.manrope.toString(),
                                        fontWeight: FontWeight.w400,
                                      ),),



                                  )



                                ],



                              ),


                            ),











                          ],

                        ),


                        const SizedBox(height: 15,),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey.shade200,
                        ),






                      ],
                    ),



                  );





                }


            ),


          )
        ],
      ),
    );

  }








/*
  void playerMedia(int index,List<Data> data, bool playable) {
    if (playable) {
      //  NewAudioPlayerState().init(data);



      if(_ctr.modelMusic.value.id.isEmpty || data[index].id.toString() != _ctr.modelMusic.value.id  || (data[index].id.toString() == _ctr.modelMusic.value.id) && (!_ctr.modelMusic.value.isPlay) || _ctr.playListTitle != widget.type){
        _ctr.playMusic(widget.type,data,index);
      }
      Get.to(() => MusicPlayer());

    }

    else {

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Subscription is required'),backgroundColor: Colors.red));



    }
  }
*/

}













/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    home: MyHomePage(),
    debugShowCheckedModeBanner: false,
  );
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_cached_pdfview Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => const PDFViewerFromUrl(
                  url: 'https://dazzingshadow.com/meditation_app/public/admin_asset/Ebook_Files/1689406241_file-example_PDF_1MB.pdf',
                ),
              ),
            ),
            child: const Text('PDF From Url'),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => const PDFViewerCachedFromUrl(
                  url: 'https://dazzingshadow.com/meditation_app/public/admin_asset/Ebook_Files/1689406241_file-example_PDF_1MB.pdf',
                ),
              ),
            ),
            child: const Text('Cashed PDF From Url'),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => PDFViewerFromAsset(
                  pdfAssetPath: 'assets/pdf/file-example.pdf',
                ),
              ),
            ),
            child: const Text('PDF From Asset'),
          ),
        ],
      ),
    );
  }
}

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF From Url'),
      ),
      body: const PDF().fromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cached PDF From Url'),
      ),
      body: const PDF().cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({Key? key, required this.pdfAssetPath}) : super(key: key);
  final String pdfAssetPath;
  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF From Asset'),
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[900],
                      ),
                      child: Text(snapshot.data!),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: '-',
                  child: const Text('-'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  heroTag: '+',
                  child: const Text('+'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! + 1;
                    final int numberOfPages =
                        await pdfController.getPageCount() ?? 0;
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}*/




