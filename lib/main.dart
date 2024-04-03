import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:creconobe_transformation/dashboard/dashboardBottom.dart';
import 'package:creconobe_transformation/prefManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'apiservices/api_interface.dart';
import 'authentication/login.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        //     iconTheme: const IconThemeData(color: Colors.black), // Set back button color to black
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();

  /* @override
  _MyHomePageState createState() => _MyHomePageState();*/
}

class _MyHomePageState extends State<MyHomePage> {
  final logger = Logger();
  late bool logged;

  @override
  void initState() {
    super.initState();
    //  WidgetsFlutterBinding.ensureInitialized();

    _initializeScreen();
  }

  Future<void> _initializeScreen() async {
    // await AppAudioService().init();
    if (await getToken()) {
      String name = await fullName();
      Timer(const Duration(seconds: 4),
          () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardBottom(name))));
    } else {
      logged = false;
      Timer(const Duration(seconds: 4), () async {
        makePostRequest().then((value) async {
          String name = await fullName();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardBottom(name)));
        });
      });

      // Timer(const Duration(seconds: 4),
      //     () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SecondScreen())));
    }
  }

  Future<void> makePostRequest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = Uri.parse('https://creconobehub.com/api/guest');
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        // Request successful, handle response
        var data = jsonDecode(response.body);
        log('data==========>>>>>${data["name"]}');
        print('Response: ${response.body}');
        PrefManager.saveString("name", data["name"].toString());
        prefs.setString("token", data["token"].toString());
      } else {
        // Request failed with an error code
        print('Failed with error code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      // Request failed due to an error
      print('Error: $e');
    }
    debugPrint("token :=== ${prefs.get("token").toString()}");
  }

  Future<String> fullName() async {
    String? token = await PrefManager.getString("name");

    return token.toString();
    // logger.d("full name======$name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/gradient_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/images/app_logo.png")],
        ),
      ),
    );
  }

// Assuming PrefManager.getString("token") returns a Future<String?>
  Future<bool> getToken() async {
    String? token = await PrefManager.getString("token");
    if (token != null) {
      logger.d("main dashboard  $token");
      return true;
    } else {
      logger.d("main dashboard  null");
      return false;
    }
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await makePostRequest();
    // });
    super.initState();
  }

  Future<void> makePostRequest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = Uri.parse('https://creconobehub.com/api/guest');
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        // Request successful, handle response
        var data = jsonDecode(response.body);
        log('data==========>>>>>${data["name"]}');
        print('Response: ${response.body}');
        PrefManager.saveString("name", data["name"].toString());
        prefs.setString("token", data["token"].toString());
      } else {
        // Request failed with an error code
        print('Failed with error code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      // Request failed due to an error
      print('Error: $e');
    }
    debugPrint("token :=== ${prefs.get("token").toString()}");
  }

  // Future<bool> loginUser(
  //     ApiInterface apiService, String email, String password) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   try {
  //     LoginSignupModel user = await apiService.getLogin(email, password);
  //     if (user.status == "true") {
  //       PrefManager.saveString("token", user.token.toString());
  //       //  prefs.setString("token", user.token);
  //
  //       name = user.name.toString();
  //       PrefManager.saveString("name", user.name.toString());
  //
  //       // tokenString(apiService,user.token);
  //
  //       debugPrint("token :=== ${prefs.get("token").toString()}");
  //       return true;
  //     } else {
  //       message = user.message.toString();
  //       debugPrint("error message in login == $message");
  //
  //       return false;
  //     }
  //
  //     //  LoginSignupModel model = user; // Store the UserModel for later use
  //     // Return true indicating successful login
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     message = e.toString();
  //
  //     return false; // Return false indicating login failure
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {},
      onHorizontalDragUpdate: (details) {
        if (details.delta.direction > 0) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
          // builder: (context) => Login(
          //           key: key,
          //         )));
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/gradient_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Image.asset("assets/images/welcome2.png"),
              ),
              Container(
                //apply margin and padding using Container Widget.
                margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: const Text(
                  "Swipe Right !",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
