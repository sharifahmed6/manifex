import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manifex/App/AppColors.dart';
import 'package:manifex/App/assets_path.dart';

class scaffold_background extends StatelessWidget {
  Widget child;
  scaffold_background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Image.asset(
              assets_path.scafold_back,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              // decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
              decoration: BoxDecoration(color: AppColors.scaffold_background.withOpacity(0.5)),
            ),
            SizedBox.expand(child: SafeArea(child: child)),
          ],
        ),
      ),
    );
  }
}
