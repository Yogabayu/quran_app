import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/screen/dashboard.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const <Locale>[
      //   Locale('en'),
      //   Locale('zh'),
      //   Locale('fr'),
      //   Locale('es'),
      //   Locale('de'),
      //   Locale('ru'),
      //   Locale('ja'),
      //   Locale('ar'),
      //   Locale('fa'),
      //   Locale('es'),
      //   Locale('it'),
      // ],
      title: 'Quran App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Dashboard(),
    );
  }
}
