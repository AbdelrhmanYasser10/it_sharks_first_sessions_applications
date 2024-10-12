import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyle{

  static TextStyle _baseFont ({required TextStyle style}){
    return GoogleFonts.rubik(
      textStyle:style
    );
  }

  static titleStyle ()=> _baseFont(
      style: const TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
      ),
  );
  static buttonTextStyle ()=> _baseFont(
      style:const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
  );

  static subTitle ()=> _baseFont(
      style:const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
  );

}