import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const defaultBackgroundColor = Color(0xffFAFAFC);
const fontGreyColor = Color(0xff8D92A3);
const lightYellow = Color(0xffFFC700);
const greyLight = Color(0xffECECEC);

const double defaultMarginPadding = 24;

TextStyle titleFontStyle = GoogleFonts.poppins(
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontSize: 22,
);

TextStyle subTitleFontStyle = GoogleFonts.poppins(
  color: const Color(0xff8D92A3),
  fontWeight: FontWeight.w300,
  fontSize: 14,
);

TextStyle formTitleStyle = GoogleFonts.poppins(
  color: const Color(0xff020202),
  fontSize: 16,
  fontWeight: FontWeight.normal,
);

TextStyle formHintStyle = GoogleFonts.poppins(
  color: fontGreyColor,
  fontSize: 14,
  fontWeight: FontWeight.normal,
);

TextStyle foodNameStyle = GoogleFonts.poppins(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.normal,
);
