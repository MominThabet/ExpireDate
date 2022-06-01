import 'package:expiration/page/items_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signin_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final user = await _auth.currentUser();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'الصلاحية';

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''), // English, no country code
          Locale('ar', ''), // arabic, no country code
        ],
        theme: ThemeData(
          primaryColor: Color(0xFF1321E0),
          // scaffoldBackgroundColor: Colors.blueGrey.shade900,
          appBarTheme: const AppBarTheme(
            color: Color(0xFF1321E0),
            elevation: 0,
          ),
        ),
        home: Directionality(
          // add this
          textDirection: TextDirection.rtl, // set this property
          child: SignInScreen(),
        ),
      );
}
