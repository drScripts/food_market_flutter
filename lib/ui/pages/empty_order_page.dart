part of './pages.dart';

class EmptyOrderPage extends StatelessWidget {
  final Function() onPressed;
  const EmptyOrderPage({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            width: 200,
            height: 210,
            image: AssetImage('assets/images/empty_transactions.png'),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Ouch! Hungry",
            style: formTitleStyle.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Seems like you have not\nordered any food yet",
            style: subTitleFontStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: defaultMarginPadding,
          ),
          GeneralBtn(
            title: "Find Foods",
            width: 200,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
