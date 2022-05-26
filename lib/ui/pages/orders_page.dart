part of './pages.dart';

class OrdersPage extends StatefulWidget {
  final Function(int) jumpToPage;
  const OrdersPage({Key? key, required this.jumpToPage}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool isEmpty = false;
  int selectedIndex = 0;

  onTabPressed(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  onCardTap(Transaction transaction) {
    Get.to(() => HistoryOrderPage(transaction: transaction));
  }

  List<Transaction> _filteredTransaction(List<Transaction> transactions,
      {bool isProgress = false}) {
    List<Transaction> filtered = [];

    if (isProgress) {
      filtered = transactions
          .where((element) => element.status == 'in progress')
          .toList();
    } else {
      filtered = transactions
          .where((element) => element.status != 'in progress')
          .toList();
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? EmptyOrderPage(
            onPressed: () {
              widget.jumpToPage(0);
            },
          )
        : GeneralPage(
            title: "Your Orders",
            subTitle: "Wait for the best meal",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTabBar(
                  titles: const ["In Progress", "Post Orders"],
                  selectedIndex: selectedIndex,
                  onTap: onTabPressed,
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<TransactionBloc, TransactionState>(
                    builder: (_, state) {
                  if (state is TransactionLoaded) {
                    List<Transaction> transactions = [];

                    if (selectedIndex == 0) {
                      transactions = _filteredTransaction(state.transactions,
                          isProgress: true);
                    } else {
                      transactions = _filteredTransaction(state.transactions);
                    }

                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultMarginPadding,
                      ),
                      child: Column(
                        children: transactions
                                .map<Widget>(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: OrderItem(
                                      transaction: e,
                                      onTap: onCardTap,
                                    ),
                                  ),
                                )
                                .toList() +
                            [
                              const SizedBox(
                                height: defaultMarginPadding * 3,
                              ),
                            ],
                      ),
                    );
                  } else if (state is TransactionFailed) {
                    Get.snackbar(
                      "Error",
                      state.message,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return const SizedBox();
                  } else {
                    return Center(
                      child: Column(
                        children: const [CircularProgressIndicator()],
                      ),
                    );
                  }
                }),
              ],
            ),
          );
  }
}
