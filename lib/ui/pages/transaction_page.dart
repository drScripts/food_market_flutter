part of './pages.dart';

class TransactionPage extends StatefulWidget {
  final Transaction transaction;
  const TransactionPage({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GeneralPage(
          title: "Payment",
          subTitle: "You deserve better meal",
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultMarginPadding,
                  ),
                  child: Text(
                    "Item Ordered",
                    style: subTitleFontStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultMarginPadding,
                  ),
                  child: Row(
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
                      const SizedBox(width: 12),
                      Column(
                        children: [
                          SizedBox(
                            width: 160,
                            child: Text(
                              widget.transaction.food!.name!,
                              style: formTitleStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 160,
                            child: Text(
                              NumberFormat.currency(
                                locale: "id-ID",
                                decimalDigits: 0,
                                symbol: "IDR ",
                              ).format(widget.transaction.food!.price!),
                              style: subTitleFontStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultMarginPadding,
                  ),
                  child: Text(
                    "Details Transaction",
                    style: subTitleFontStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                DetailTransactionItem(
                  title: widget.transaction.food!.name!,
                  value: NumberFormat.currency(
                    locale: "id-ID",
                    decimalDigits: 0,
                    symbol: "IDR ",
                  ).format(widget.transaction.qty! *
                      widget.transaction.food!.price!),
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: defaultMarginPadding,
                  ),
                ),
                DetailTransactionItem(
                  title: "Driver",
                  value: NumberFormat.currency(
                    locale: "id-ID",
                    decimalDigits: 0,
                    symbol: "IDR ",
                  ).format(widget.transaction.driver ?? 0),
                  margin: const EdgeInsets.only(
                    bottom: 5,
                    right: defaultMarginPadding,
                    left: defaultMarginPadding,
                  ),
                ),
                DetailTransactionItem(
                  title: "Tax 10%",
                  value: NumberFormat.currency(
                    locale: "id-ID",
                    decimalDigits: 0,
                    symbol: "IDR ",
                  ).format(widget.transaction.tax),
                  margin: const EdgeInsets.only(
                    bottom: 5,
                    right: defaultMarginPadding,
                    left: defaultMarginPadding,
                  ),
                ),
                DetailTransactionItem(
                  title: "Total Price",
                  value: NumberFormat.currency(
                    locale: "id-ID",
                    decimalDigits: 0,
                    symbol: "IDR ",
                  ).format(widget.transaction.total),
                  valueTextColor: const Color(0xff1ABC9C),
                  margin: const EdgeInsets.only(
                    right: defaultMarginPadding,
                    left: defaultMarginPadding,
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
                  child: Text(
                    "Deliver to:",
                    style: subTitleFontStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                DetailTransactionItem(
                  title: "Name",
                  value: widget.transaction.user!.name,
                  margin: const EdgeInsets.only(
                    left: defaultMarginPadding,
                    right: defaultMarginPadding,
                    bottom: 5,
                  ),
                ),
                DetailTransactionItem(
                  title: "Name",
                  value: widget.transaction.user!.phoneNumber ?? "00000000",
                  margin: const EdgeInsets.only(
                    left: defaultMarginPadding,
                    right: defaultMarginPadding,
                    bottom: 5,
                  ),
                ),
                DetailTransactionItem(
                  title: "Address",
                  value: widget.transaction.user!.address ?? "Address",
                  margin: const EdgeInsets.only(
                    left: defaultMarginPadding,
                    right: defaultMarginPadding,
                    bottom: 5,
                  ),
                ),
                DetailTransactionItem(
                  title: "House No.",
                  value: widget.transaction.user!.houseNumber ?? "House Number",
                  margin: const EdgeInsets.only(
                    left: defaultMarginPadding,
                    right: defaultMarginPadding,
                    bottom: 5,
                  ),
                ),
                DetailTransactionItem(
                  title: "City",
                  value: widget.transaction.user!.city ?? "City",
                  margin: const EdgeInsets.only(
                    left: defaultMarginPadding,
                    right: defaultMarginPadding,
                    bottom: 5,
                  ),
                ),
                const SizedBox(
                  height: defaultMarginPadding * 3,
                )
              ],
            ),
          ),
        ),
        BlocListener<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionLoading) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const DialogLoading();
                  });
            }

            if (state is TransactionSuccess) {
              Get.offAll(
                () => SuccessPage(currenTransaction: state.transaction),
              );
            }

            if (state is TransactionFailed) {
              Get.snackbar(
                "Error",
                state.message,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
              Navigator.pop(context);
            }
          },
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(defaultMarginPadding),
              child: GeneralBtn(
                title: "Checkout Now",
                onPressed: () {
                  context
                      .read<TransactionBloc>()
                      .add(TransactionSubmit(transaction: widget.transaction));
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
