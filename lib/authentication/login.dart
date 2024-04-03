// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';
import 'package:creconobe_transformation/apiservices/api_interface.dart';
import 'package:creconobe_transformation/authentication/signup.dart';
import 'package:creconobe_transformation/models/login_signup_model.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../dashboard/dashboardBottom.dart';
import '../loadingScreen.dart';
import '../models/forgotPasswordModel.dart';
import '../models/profileModel.dart';
import '../prefManager.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final GlobalKey<FormState> _formKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  bool _obscurePassword = true;
  bool isChecked = false;
  late String message, name;

  static Pattern pattern =
      "^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  RegExp regExp = RegExp(pattern.toString());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: Image.asset("assets/images/login_img.png"),
                ),
                Container(
                  //apply margin and padding using Container Widget.
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text("Login",
                      style: TextStyle(
                          color: HexColor("#0B4654"),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.athiti().fontFamily)),
                ),
                SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(children: [
                      const SizedBox(height: 20),
                      //for email field
                      TextFormField(
                          controller: controllerEmail,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) {},
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onEditingComplete: () =>
                              _focusNodePassword.requestFocus(),
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Enter a valid email!';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      // for password field
                      TextFormField(
                        controller: controllerPassword,
                        focusNode: _focusNodePassword,
                        obscureText: _obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock_person_rounded),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: _obscurePassword
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid password!';
                          }
                          return null;
                        },
                      ),

                      //terms and conditions check box
                      const SizedBox(
                        height: 1,
                      ),

                      /*  Checkbox(
                         value: isChecked,
                         onChanged: (value) {
                           isChecked = !isChecked;
                           setState(() {
                           });

                           const Text(
                             "Remember me",
                             style: TextStyle(
                                 fontSize: 5, color: Colors.black),
                           );
                         },
                       ),

                       TextButton(
                         onPressed: (){
                           forgotPassword();
                         },
                         child: Text(
                           "Forgot password?",
                           style: TextStyle(
                               fontSize: 15,
                               fontFamily: GoogleFonts.athiti().fontFamily,
                               color: HexColor("#07B464")
                           ),
                         ),
                       ),*/

                      Row(
                        children: [
                          /*  Checkbox(
                             value: isChecked,
                             onChanged: (value) {
                               isChecked = !isChecked;
                               setState(() {
                               });

                               const Text(
                                 "Remember me",
                                 style: TextStyle(
                                     fontSize: 5, color: Colors.black),
                               );
                             },
                           ),*/

                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              forgotPassword();
                            },
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: GoogleFonts.athiti().fontFamily,
                                  color: HexColor("#07B464")),
                            ),
                          ),
                        ],
                      ),

                      //login btn
                      const SizedBox(height: 15),
                      Column(children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor("#07B464"),
                            elevation: 2.5,
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            loginValidator();
                          },
                          child: Text("Log In",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.athiti().fontFamily)),
                        )
                      ]),

                      // sign with google btn

                      const SizedBox(
                        height: 10,
                      ),
                      /*    ElevatedButton(


                         style: ElevatedButton.styleFrom(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15),
                           ),

                           foregroundColor: Colors.black, backgroundColor: Colors.white,
                         ),
                         onPressed: () {

                         },
                         child: const Padding(
                           padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                           child: Row(
                             mainAxisSize: MainAxisSize.max,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Image(
                                 image: AssetImage("assets/images/googlesignin.png"),
                                 height: 18.0,
                                 width: 24,
                               ),
                               Padding(
                                 padding: EdgeInsets.only(left: 15, right: 8),
                                 child: Text(
                                   'Log In with Google',
                                   style: TextStyle(
                                     fontSize: 15,
                                     color: Colors.black54,

                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),

                       //sign in with facebook
                       const SizedBox(
                         height: 10,
                       ),
                       ElevatedButton(


                         style: ElevatedButton.styleFrom(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15),
                           ),

                           foregroundColor: Colors.black, backgroundColor: Colors.white,
                         ),
                         onPressed: () {

                         },
                         child: const Padding(
                           padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                           child: Row(
                             mainAxisSize: MainAxisSize.max,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Image(
                                 image: AssetImage("assets/images/facebookicon.png"),
                                 height: 18.0,
                                 width: 24,
                               ),
                               Padding(
                                 padding: EdgeInsets.only(left: 15, right: 5),
                                 child: Text(
                                   'Log In with Facebook',
                                   style: TextStyle(
                                     fontSize: 15,
                                     color: Colors.black54,

                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),*/

                      // dont have an account

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              _formKey.currentState?.reset();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Signup();
                                  },
                                ),
                              );
                            },
                            child: const Text("Signup"),
                          ),
                        ],
                      ),
                    ])),

                /*Container(

             margin:  const EdgeInsets.fromLTRB(20,10,20,0),
             decoration: BoxDecoration(
               color: Colors.deepOrange,
               borderRadius: BorderRadius.circular(200),


             ),



           )*/
              ],
            ),
          ),),
    );
  }

  Future<void> loginValidator() async {
    if (controllerEmail.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email is required'), backgroundColor: Colors.red));
    } else if (!regExp.hasMatch(controllerEmail.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Valid email is required'),
          backgroundColor: Colors.red));
    } else if (controllerPassword.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password is required'),
        backgroundColor: Colors.red,
      ));
    } else if (controllerPassword.text.trim().length < 7) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password is short,Minimum 7 characters required'),
        backgroundColor: Colors.red,
      ));
    } else {
      buildLoading(context);
      ApiInterface apiInterface = ApiInterface(Dio());

      loginUser(apiInterface, controllerEmail.text, controllerPassword.text)
          .then((success) async {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Login Successful'),
            backgroundColor: Colors.green,
          ));

          String? restoreSubscriptionId = await PrefManager.getString("subscriptionId");

          if(restoreSubscriptionId != null){
            restorePurchase(restoreSubscriptionId);
          }
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardBottom(name)),
          );
        } else {
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ));
        }
      });
    }
  }



  restorePurchase(String restoreSubscriptionId,) async {
    Map<String, String> header = {'Content-Type': 'application/json'};
    String? token = await PrefManager.getString("token");
    log('token========111111==>>>>>${token}');
    log('restoreSubscriptionId========111111==>>>>>${restoreSubscriptionId}');

    const String url = 'https://creconobehub.com/api/afterPaymentPost';
    final body = {"user_id": token, "subscription_id": restoreSubscriptionId};
    http.Response response = await http.post(Uri.parse(url), headers: header, body: jsonEncode(body));
    if (response.statusCode == 200) {
      log('response.statusCode>==========>>>>>${response.statusCode}');
      PrefManager.saveString("subscriptionId", "");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('SubScribed Successful'), backgroundColor: Colors.green));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Payment Unsuccessful.'), backgroundColor: Colors.red));
    }
  }

  Future<bool> loginUser(
      ApiInterface apiService, String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      LoginSignupModel user = await apiService.getLogin(email, password);
      if (user.status == "true") {
        PrefManager.saveString("token", user.token.toString());
        //  prefs.setString("token", user.token);

        name = user.name.toString();
        PrefManager.saveString("name", user.name.toString());

        // tokenString(apiService,user.token);

        debugPrint("token :=== ${prefs.get("token").toString()}");
        return true;
      } else {
        message = user.message.toString();
        debugPrint("error message in login == $message");

        return false;
      }

      //  LoginSignupModel model = user; // Store the UserModel for later use
      // Return true indicating successful login
    } catch (e) {
      debugPrint(e.toString());
      message = e.toString();

      return false; // Return false indicating login failure
    }
  }

  Future<void> forgotPassword() async {
    if (controllerEmail.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email is required'), backgroundColor: Colors.red));
    } else {
      buildLoading(context);
      ApiInterface apiInterface = ApiInterface(Dio());

      apiPassword(apiInterface, controllerEmail.text).then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Colors.green,
          ));

          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ));
          Navigator.of(context).pop();
        }
      });
    }
  }

  Future<bool> apiPassword(ApiInterface apiService, String email) async {
    try {
      ForgotPasswordModel user = await apiService.getForgotPassword(email);
      if (user.status == "true") {
        message = user.message;

        return true;
      } else {
        message = user.message;
        debugPrint("error message in login == $message");

        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      message = e.toString();

      return false; // Return false indicating login failure
    }
  }

  Future<void> tokenString(ApiInterface apiInterface, String token) async {
    // String? token = await PrefManager.getString("token");

    //   logger.d(" token to String $token");

    ProfileModel profile = await apiInterface.getProfile(token);
    // Strin name = profile.fullname.toString();
    String name = profile.fullname.toString();
    PrefManager.saveString("name", profile.fullname.toString());
  }
}
