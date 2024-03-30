import 'package:flutter/material.dart';
import 'package:google_maps_special/screens/splash/splash_screen.dart';
import 'package:google_maps_special/view_models/addresses_view_model.dart';
import 'package:google_maps_special/view_models/maps_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MapsViewModel()),
      ChangeNotifierProvider(create: (_) => AddressesViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const SplashScreen(),
    );
  }
}
