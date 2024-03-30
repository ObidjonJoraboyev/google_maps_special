import 'package:flutter/material.dart';
import 'package:flutter_nt_ten/screens/addresses/addresses_screen.dart';
import 'package:flutter_nt_ten/screens/maps/google_maps_screen.dart';
import 'package:flutter_nt_ten/utils/colors/app_colors.dart';
import 'package:flutter_nt_ten/view_models/maps_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!context.mounted) return;
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
        title: const Text("Deafult"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text("LoTTIE QO"),
        ),
      ),
    );
  }
}
