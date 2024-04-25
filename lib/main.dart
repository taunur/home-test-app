import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_test_app/data/provider/data_mapping.dart';
import 'package:home_test_app/data/provider/data_visualitation.dart';
import 'package:home_test_app/ui/widgets/navbar.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataMappingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataVisualitationProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Colors.orange,
          secondary: Colors.grey,
        ),
        primaryColor: Colors.blue,
      ),
      home: const Navbar(),
    );
  }
}
