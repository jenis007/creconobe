
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:logger/logger.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ReadBooks extends StatefulWidget {
  String book_pdf,book_name;
   ReadBooks( this.book_pdf,this.book_name, {super.key});
  @override
  State<ReadBooks> createState() => _ReadBooks();

}
class _ReadBooks extends  State<ReadBooks> {

  final logger = Logger();
 // String pdfUrl = widget.book_pdf.toString();

  late PDFViewController pdfViewController;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
   appBar: AppBar(

        backgroundColor: Colors.green, // Make the app bar background transparent
        iconTheme: const IconThemeData(color: Colors.white), // Set back button color to black
        centerTitle: true,
        title:  Text(widget.book_name,style: const TextStyle(color: Colors.white),),
      //  backgroundColor: Colors.white,
      ),
      body: const PDF().fromUrl(
        widget.book_pdf.toString(),
        placeholder: (double progress) => Center(child: Text('Loading ....$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),




    );

  }

}