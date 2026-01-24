import 'package:flutter/material.dart';
import 'package:manifex/App/AppColors.dart';
import '../../Share/button_gradient.dart';
import '../../Share/manifex_logo.dart';
import '../../Share/scafold_background.dart';

class splash extends StatelessWidget {
  splash({super.key});

  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      child: Scaffold(
        body: ButtonGradient(
          onTap: (){

          },
        ),
      ),
    );
  }
}



