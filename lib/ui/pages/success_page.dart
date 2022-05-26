part of './pages.dart';

class SuccessPage extends StatelessWidget {
  final Transaction currenTransaction;

  const SuccessPage({Key? key, required this.currenTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/images/success_payment.png"),
              width: 200,
              height: 177,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "You’ve Made Order",
              style: formTitleStyle.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Just stay at home while we are\npreparing your best foods",
              style: subTitleFontStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: defaultMarginPadding,
            ),
            GeneralBtn(
              title: "Pay Transaction",
              width: 200,
              onPressed: () async {
                try {
                  await launchUrlString(currenTransaction.paymentUrl ?? "");
                } catch (e) {
                  Get.snackbar(
                    "Error",
                    "Can't launch url!",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
            ),
            const SizedBox(
              height: 12,
            ),
            GeneralBtn(
              title: "View My Order",
              backgroundColor: const Color(0xff8D92A3),
              textColor: Colors.white,
              width: 200,
              onPressed: () {
                Get.to(() => HistoryOrderPage(transaction: currenTransaction));
              },
            ),
            const SizedBox(
              height: 12,
            ),
            GeneralBtn(
              title: "Order Another Food",
              backgroundColor: const Color(0xff8D92A3),
              textColor: Colors.white,
              width: 200,
              onPressed: () {
                Get.offAll(() => const MainPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
