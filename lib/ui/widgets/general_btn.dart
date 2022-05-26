part of './widgets.dart';

class GeneralBtn extends StatelessWidget {
  final void Function()? onPressed;
  final Color backgroundColor;
  final String title;
  final Color textColor;
  final double? marginTop;
  final double? marginBottom;
  final bool disabled;
  final double width;
  final double height;
  const GeneralBtn({
    Key? key,
    this.onPressed,
    this.backgroundColor = const Color(0xffFFC700),
    this.title = "Click Me!",
    this.textColor = Colors.black,
    this.marginTop,
    this.marginBottom,
    this.disabled = false,
    this.width = double.infinity,
    this.height = 45,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop ?? 0, bottom: marginBottom ?? 0),
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          primary: backgroundColor,
          onSurface: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide.none,
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: disabled ? Colors.black : textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
