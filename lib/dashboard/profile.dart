import 'package:creconobe_transformation/dashboard/termsandcondition.dart';
import 'package:creconobe_transformation/models/profileModel.dart';
import 'package:creconobe_transformation/prefManager.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apiservices/api_interface.dart';
import '../authentication/login.dart';
import '../loadingScreen.dart';
import '../models/login_signup_model.dart';
import '../music/preview_music.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ProfileModel profileModel;
  late SharedPreferences prefs;
  final logger = Logger();
  ApiInterface apiInterface = ApiInterface(Dio());
  late TextEditingController controllerName = TextEditingController();
  late String fullName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Profile",
            style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 20,color: Colors.white),
          ),
          centerTitle: true,  backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: PreviewMusic(),
        body: FutureBuilder<ProfileModel>(
            future: tokenString(),
            // Your API call returning a Future<Profile>
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While the data is being fetched, show a loading indicator

                logger.d("profile connection ${snapshot.connectionState}");
                logger.d("profile token  ${tokenString()}");

                return const Center(child: CircularProgressIndicator(color: Colors.green));
              } else if (snapshot.hasData) {
                profileModel = snapshot.data!;
                logger.d("profile data ${snapshot.data}");
                controllerName.text = profileModel.fullname.toString();
                fullName = controllerName.text;
                return Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                      child: //profileModel != null ?
                          Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: CircleAvatar(
                                radius: 38, // Image radius
                                child: Image.asset("assets/images/login_img.png", height: 70, width: 70))),
                      ),

                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            fullName,
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: Text(
                          'Personal Info',
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      //full name
                      const SizedBox(
                        height: 10,
                      ),

                      /*   Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 0, 0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                height: 55,
                                width: 55,
                                child: const Icon(
                                  Icons.person_pin_outlined,
                                  color: Colors.grey,

                                ),
                              ),


                              //full name field
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text(
                                    "Full Name",
                                    style: TextStyle(
                                      fontFamily: GoogleFonts
                                          .poppins()
                                          .fontFamily,
                                      color: Colors.grey,
                                      fontSize: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.035,
                                    ),
                                  ),

                                  const SizedBox(height: 5,),


                                  Text(
                                     profileModel.fullname,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: GoogleFonts
                                            .poppins()
                                            .fontFamily,
                                        fontSize: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.040,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),


                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),

                        //email


                        //phone


                        //Subscription
                        const SizedBox(height: 1,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 0, 0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                height: 55,
                                width: 55,
                                child: const Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.grey,

                                ),
                              ),


                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text(
                                    "Subscription",
                                    style: TextStyle(
                                      fontFamily: GoogleFonts
                                          .poppins()
                                          .fontFamily,
                                      color: Colors.grey,
                                      fontSize: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.035,
                                    ),
                                  ),

                                  const SizedBox(height: 5,),

                                  Text(
                                    "Basic",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: GoogleFonts
                                            .poppins()
                                            .fontFamily,
                                        fontSize: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.040,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),


                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
*/

                      //logout
                      const SizedBox(
                        height: 10,
                      ),

                      /*  FilePicker(
                        context: context,
                        height: 100,
                        fileData: _fileData,
                        crop: true,
                        maxFileSizeInMb: 1,
                        document: false,
                        allowedExtensions: const [Files.png,Files.jpeg],
                        onSelected: (fileData) {
                          _fileData = fileData;
                          logger.d("fileData =====${_fileData.path}");
                        },
                        onCancel: (message, messageCode) {
                          logger.d("cancel message ==== [$messageCode] $message");
                        }
                    ),*/
                      TextFormField(
                          style: const TextStyle(color: Colors.black),
                          // Set the text color
                          controller: controllerName,
                          onFieldSubmitted: (value) {},
                          decoration: InputDecoration(
                            labelText: "Full Name",
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(
                              Icons.person_pin_outlined,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              // Use the same color as enabled state
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            return null;
                          }),

                      const SizedBox(height: 20),
                      //for email field
                      TextFormField(
                          enabled: false,
                          style: const TextStyle(color: Colors.black),
                          // Set the text color
                          initialValue: profileModel.email,
                          onFieldSubmitted: (value) {},
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              // Use the same color as enabled state
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            return null;
                          }),

                      const SizedBox(height: 20),
                      // for password field
                      TextFormField(
                        enabled: false,
                        initialValue: profileModel.subscription,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Subscription",
                          labelStyle: const TextStyle(color: Colors.black),
                          prefixIcon: const Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            // Use the same color as enabled state
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TermsAndCondition(
                                "https://sites.google.com/view/creconobe-the-meditation-hub/home?authuser=1");
                          }));
                        },
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: const EdgeInsets.fromLTRB(10, 8, 0, 8),
                          child: Text(
                            'Terms And Condition',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TermsAndCondition(
                                "https://sites.google.com/view/creconobe-privacy-policy/home?authuser=1");
                          }));
                        },
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: const EdgeInsets.fromLTRB(10, 8, 0, 8),
                          child: Text(
                            'Privacy Policy',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          logout();
                        },
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: const EdgeInsets.fromLTRB(10, 8, 0, 8),
                          child: Text(
                            'Delete Account',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                      ),

                      //edit and save btn
                      InkWell(
                        onTap: () async {
                          buildLoading(context);

                          if (await saveProfile()) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Profile Updated Successfully'),
                              backgroundColor: Colors.green,
                            ));
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Profile Not Updated '),
                              backgroundColor: Colors.red,
                            ));

                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                          padding: const EdgeInsets.fromLTRB(105, 8, 105, 8),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.black)),
                          child: Text(
                            'Save',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#283048")),
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          logout();
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.black)),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#283048")),
                          ),
                        ),
                      ),
                      /*  Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 0, 0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                height: 55,
                                width: 55,
                                child: const Icon(
                                  Icons.login_outlined,
                                  color: Colors.grey,

                                ),
                              ),


                              const SizedBox(width: 12),
                              Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        logout();
                                      },
                                      child: Text(
                                        "Log Out",
                                        maxLines: 1,

                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: GoogleFonts
                                                .poppins()
                                                .fontFamily,
                                            fontSize: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.040,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                      )
                                  ),


                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),*/
                    ],
                  ) //: buildLoading(context),
                      ),
                );
              } else if (snapshot.hasError) {
                // While the data is being fetched, show a loading indicator

                logger.d("profile connection ${snapshot.error}");
                logger.d("profile token  ${tokenString()}");

                return Center(child: Text('${snapshot.error.toString()}'));
              } else {
                logger.d("profile data ${snapshot.data}");

                // If the API call is completed, but no data is available, show an empty message
                return const Center(child: Text('No data available'));
              }
            }));
  }

  Future<ProfileModel> tokenString() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token") ?? ''; // Add a fallback value in case 'token' is not found

    String? token = await PrefManager.getString("token");

    logger.d(" token to String $token");

    return apiInterface.getProfile(token!);
  }

  void logout() {
    PrefManager.clearPref();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const Login();
        },
      ),
    );
  }

  Future<bool> saveProfile() async {
    String? token = await PrefManager.getString("token");
    if (token != null) {
      LoginSignupModel reposnse = await apiInterface.setProfile(token, controllerName.text);

      if (reposnse.status == "true") {
        PrefManager.saveString("name", controllerName.text);
        setState(() {
          fullName = controllerName.text;
        });
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
