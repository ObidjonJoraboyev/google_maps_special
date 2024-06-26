import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/colors/app_colors.dart';
import '../../view_models/maps_view_model.dart';
import '../maps/google_maps_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const GoogleMapsScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MapsViewModel>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Default"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text(""),
        ),
      ),
    );
  }
}
