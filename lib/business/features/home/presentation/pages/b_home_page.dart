import 'package:flutter/material.dart';
import 'package:koala/product/constants/app_colors.dart';

class BHomePage extends StatelessWidget {
  const BHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'KOALA',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
    );
  }
}
