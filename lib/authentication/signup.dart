import 'dart:convert';
import 'dart:developer';

import 'package:creconobe_transformation/models/login_signup_model.dart';
import 'package:flutter/material.dart';
import 'package:creconobe_transformation/colors/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'dart:async';

import '../apiservices/api_interface.dart';
import '../dashboard/dashboardBottom.dart';
import '../loadingScreen.dart';
import '../models/profileModel.dart';
import '../prefManager.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  final ApiInterface apiInterface = ApiInterface(Dio());

  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  bool _obscurePassword = true;
  bool isChecked = false;
  static Pattern pattern = "^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regExp = RegExp(pattern.toString());
  //late LoginState _loginState;
  late String message, name;

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
                  child: Image.asset("assets/images/signup_img.png"),
                ),
                Container(
                  //apply margin and padding using Container Widget.
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text("Sign Up",
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
                      //for name field
                      TextFormField(
                          controller: controllerUsername,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Full Name",
                            prefixIcon: const Icon(Icons.account_circle_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onEditingComplete: () => _focusNodePassword.requestFocus(),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email.";
                            }
                            return null;
                          }),

                      const SizedBox(height: 20),
                      //for email field
                      TextFormField(
                          controller: controllerEmail,
                          keyboardType: TextInputType.emailAddress,
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
                          onEditingComplete: () => _focusNodePassword.requestFocus(),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email.";
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
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password.";
                          }

                          return null;
                        },
                      ),

                      //terms and conditions check box
                      const SizedBox(
                        height: 1,
                      ),

                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              isChecked = !isChecked;
                              setState(() {});
                            },
                          ),
                          Text(
                            "I agree with Terms and Privacy",
                            style: TextStyle(
                                fontSize: 15, color: Colors.green, fontFamily: GoogleFonts.athiti().fontFamily),
                          )
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
                          child: Text("Sign Up",
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

                      // dont have an account

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              _formKey.currentState?.reset();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const Login();
                                  },
                                ),
                              );
                            },
                            child: const Text("Login"),
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
          )),
    );
  }

  Future<void> loginValidator() async {
    if (controllerUsername.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Full name is required'), backgroundColor: Colors.red));
    } else if (controllerEmail.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Email is required'), backgroundColor: Colors.red));
    } else if (!regExp.hasMatch(controllerEmail.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Valid email is required'),
        backgroundColor: Colors.red,
      ));
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
    } else if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please accept the terms and conditions'),
        backgroundColor: Colors.red,
      ));
    } else {
      buildLoading(context);

      signupUser(widget.apiInterface, controllerUsername.text, controllerEmail.text, controllerPassword.text)
          .then((success) async {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('SignUp Successful'),
            backgroundColor: Colors.green,
          ));

          String? restoreSubscriptionId = await PrefManager.getString("subscriptionId");


          if(restoreSubscriptionId != null){
            restorePurchase(restoreSubscriptionId);
          }

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


  restorePurchase(String restoreSubscriptionId) async {
    log('restoreSubscriptionId========000000==>>>>>${restoreSubscriptionId}');

    Map<String, String> header = {'Content-Type': 'application/json'};
    String? token = await PrefManager.getString("token");
    const String url = 'https://creconobehub.com/api/afterPaymentPost';
    final body = {"user_id": token, "subscription_id": restoreSubscriptionId};
    http.Response response = await http.post(Uri.parse(url), headers: header, body: jsonEncode(body));
    if (response.statusCode == 200) {
      PrefManager.saveString("subscriptionId", "");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('SubScribed Successful'), backgroundColor: Colors.green));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Payment Unsuccessful.'), backgroundColor: Colors.red));
    }
  }

  Future<bool> signupUser(ApiInterface apiService, String username, String email, String password) async {
    try {
      LoginSignupModel user = await apiService.getSignup(username, email, password);
      // final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (user.status == "true") {
        name = user.name.toString();
        // prefs.setString("token", user.token);
        PrefManager.saveString("token", user.token.toString());
        PrefManager.saveString("name", user.name.toString());

        //  tokenString(apiService,user.token);
        return true;
      } else {
        message = user.message.toString();

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

  Future<void> tokenString(ApiInterface apiInterface, String token) async {
    // String? token = await PrefManager.getString("token");

    //   logger.d(" token to String $token");

    ProfileModel profile = await apiInterface.getProfile(token);
    name = profile.fullname.toString();
    PrefManager.saveString("name", profile.fullname.toString());
  }
}
