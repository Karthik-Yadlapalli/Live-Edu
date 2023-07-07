import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_edu/screens/guide_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:live_edu/widgets/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool? isFirstTime;

  @override
  void initState() {
    isFirstTimeUser();
    // TODO: implement initState
    super.initState();
  }

  // *getting flag value from user
isFirstTimeUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
   isFirstTime = prefs.getBool('isFirstTime');
setState(() {});
}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isFirstTime ==false ?GuideScreen() :  const AuthPage(),
      ),
    );
  }
}
