part of './pages.dart';

class SuccessRegisterPage extends StatelessWidget {
  const SuccessRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/images/success_register.png"),
              width: 200,
              height: 289,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Yeay! Completed",
              style: formTitleStyle.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Now you are able to order\nsome foods as a self-reward",
              style: subTitleFontStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: defaultMarginPadding,
            ),
            GeneralBtn(
              title: "Find Foods",
              width: 200,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
