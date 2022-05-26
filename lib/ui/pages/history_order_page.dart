part of './pages.dart';

class HistoryOrderPage extends StatefulWidget {
  final Transaction transaction;
  const HistoryOrderPage({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double driver = 50000;
    double totalFood =
        widget.transaction.qty! * widget.transaction.food!.price!;
    double tax = totalFood * 0.1;
    double total = totalFood + tax + driver;

    return GeneralPage(
      title: "Payment",
      subTitle: "You deserve better meal",
      onBack: () {
        Get.offAll(() => const MainPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultMarginPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Item Ordered",
                  style: formTitleStyle,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.transaction.food!.imageUrl!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenWidth -
                              defaultMarginPadding * 2 -
                              12 -
                              60 -
                              70,
                          child: Text(
                            widget.transaction.food!.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: formTitleStyle,
                          ),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: "id-ID",
                            symbol: "IDR ",
                            decimalDigits: 0,
                          ).format(widget.transaction.food!.price),
                          style: subTitleFontStyle,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      "${widget.transaction.qty} items",
                      style: subTitleFontStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Details Transaction",
                  style: subTitleFontStyle.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                DetailTransactionItem(
                  title: widget.transaction.food!.name!,
                  value: NumberFormat.currency(
                          locale: "id-ID", symbol: "IDR ", decimalDigits: 0)
                      .format(totalFood),
                ),
                DetailTransactionItem(
                  title: "Driver",
                  value: NumberFormat.currency(
                          locale: "id-ID", symbol: "IDR ", decimalDigits: 0)
                      .format(driver),
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                ),
                DetailTransactionItem(
                  title: "Tax 10%",
                  value: NumberFormat.currency(
                          locale: "id-ID", symbol: "IDR ", decimalDigits: 0)
                      .format(tax),
                  margin: const EdgeInsets.only(bottom: 5),
                ),
                DetailTransactionItem(
                  title: "Total Price",
                  value: NumberFormat.currency(
                          locale: "id-ID", symbol: "IDR ", decimalDigits: 0)
                      .format(total),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: defaultMarginPadding,
            color: defaultBackgroundColor,
            margin: const EdgeInsets.symmetric(vertical: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultMarginPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Details Transaction",
                  style: subTitleFontStyle.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                DetailTransactionItem(
                  title: "Name",
                  value: widget.transaction.user!.name,
                ),
                DetailTransactionItem(
                  title: "Phone Number",
                  value: widget.transaction.user!.phoneNumber ?? "Phone Number",
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                ),
                DetailTransactionItem(
                  title: "Address",
                  value: widget.transaction.user!.address ?? "Address",
                  margin: const EdgeInsets.only(bottom: 5),
                ),
                DetailTransactionItem(
                  title: "House No.",
                  value: widget.transaction.user!.houseNumber ?? "House Number",
                  margin: const EdgeInsets.only(bottom: 5),
                ),
                DetailTransactionItem(
                  title: "City",
                  value: widget.transaction.user!.city ?? "City",
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: defaultMarginPadding,
            color: defaultBackgroundColor,
            margin: const EdgeInsets.symmetric(vertical: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultMarginPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Status",
                  style: subTitleFontStyle.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#FM${DateFormat("yyyy").format(DateTime.now())}${widget.transaction.id}",
                      style: subTitleFontStyle,
                    ),
                    Text(
                      widget.transaction.status!,
                      style: subTitleFontStyle.copyWith(
                        color: widget.transaction.status! == 'completed'
                            ? const Color(0xff1ABC9C)
                            : widget.transaction.status! == 'in progress'
                                ? Colors.amber
                                : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                GeneralBtn(
                  disabled: (widget.transaction.status! == 'completed' ||
                      widget.transaction.status! == 'failed' ||
                      widget.transaction.status! == 'canceled'),
                  title: "Pay My Order",
                  width: double.infinity,
                  height: 45,
                  marginTop: defaultMarginPadding,
                  onPressed: () async {
                    await launchUrlString(widget.transaction.paymentUrl ?? "");
                  },
                ),
                BlocListener<TransactionBloc, TransactionState>(
                  listener: (context, state) {
                    if (state is TransactionFailed) {
                      Get.snackbar("Error", state.message,
                          backgroundColor: Colors.red, colorText: Colors.white);
                      Navigator.pop(context);
                    }

                    if (state is TransactionUpdated) {
                      context
                          .read<TransactionBloc>()
                          .add(const LoadTransaction());
                      Get.offAll(() => const MainPage());
                    }
                  },
                  child: GeneralBtn(
                    disabled: (widget.transaction.status! == 'completed' ||
                        widget.transaction.status! == 'failed' ||
                        widget.transaction.status! == 'canceled'),
                    title: "Cancel My Order",
                    width: double.infinity,
                    height: 45,
                    marginBottom: defaultMarginPadding,
                    marginTop: 12,
                    onPressed: () {
                      context.read<TransactionBloc>().add(
                            UpdateStatusCanceled(
                                transaction: widget.transaction),
                          );
                    },
                    textColor: Colors.white,
                    backgroundColor: const Color(0xffD9435E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
