import 'package:creconobe_transformation/models/subscriptionModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:hexcolor/hexcolor.dart';

class FreeSubscription extends StatefulWidget {
  final Datum data;
  const FreeSubscription(this.data, {super.key});

  @override
  State<FreeSubscription> createState() => _FreeSubscription();
}

class _FreeSubscription extends State<FreeSubscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Container(
        height: 480,
        margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      widget.data.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.w700,
                      ),
                    ))
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 20, 0, 0),
              width: double.infinity,
              height: 32,
              child: Text(
                'What You’ll Get',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: 249,
                      child: Text(
                        widget.data.description[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: 249,
                      child: Text(
                        widget.data.description[1],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: 249,
                      child: Text(
                        widget.data.description[2],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                )),
            /* Container(
                  margin: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                  child:Row(
                    children: [

                      const Icon(Icons.check_circle,color: Colors.white,),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        width: 249,
                        child: Text(
                          widget.data.description[3],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontWeight: FontWeight.w400,
                          ),
                        ) ,

                      )



                    ],


                  )
              ),*/

            const SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(25, 15, 25, 0),

                //  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: const DottedLine(
                  dashColor: Colors.white,
                )),
            const Spacer(),
            Container(
                margin: const EdgeInsets.fromLTRB(25, 20, 0, 35),
                child: Text(
                  'Free forever',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                )),

            /* Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),

                  child:
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 5,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ), onPressed: () {


                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const DashboardBottom();
                          },
                        ),
                      );
                      //

                    }, child: Text("Already Selected",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.athiti().fontFamily,color: Colors.green)),
                    )

              ),*/
          ],
        ),
      ),
    )));
  }
}
