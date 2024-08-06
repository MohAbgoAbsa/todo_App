import 'package:flutter/material.dart';
import 'package:untitled/app_colors.dart';

class Loginscreen extends StatelessWidget {
  static const String routeName = 'Loginscreen';

  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgrounddark,
            ),
            child: Image.asset(
              'assets/images/signin.png',
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              'Login',
            ),
          ),
        )
      ],
    );
  }
}
