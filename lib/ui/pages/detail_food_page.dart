part of './pages.dart';

class DetailFoodPage extends StatefulWidget {
  final Food food;
  const DetailFoodPage({Key? key, required this.food}) : super(key: key);

  @override
  State<DetailFoodPage> createState() => _DetailFoodPageState();
}

class _DetailFoodPageState extends State<DetailFoodPage> {
  int qty = 1;

  onCounterChange(type) {
    if (type == "increment") {
      setState(() {
        qty++;
      });
    } else {
      if (qty > 1) {
        setState(() {
          qty--;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 330,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.food.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 330,
              color: const Color(0xff000000).withAlpha(50),
            ),
            ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 300,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultMarginPadding + 2,
                          horizontal: defaultMarginPadding - 8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(18),
                          topLeft: Radius.circular(18),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      widget.food.name!,
                                      style: formTitleStyle,
                                    ),
                                  ),
                                  RatingStars(
                                    stars: widget.food.rating,
                                  ),
                                ],
                              ),
                              QtyCounter(
                                qty: qty,
                                onTap: onCounterChange,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            widget.food.description!,
                            style: subTitleFontStyle,
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Ingredients:",
                            style: formTitleStyle,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            widget.food.ingredients!,
                            style: subTitleFontStyle,
                          ),
                          const SizedBox(
                            height: 21,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Total Price:",
                                    style: subTitleFontStyle,
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                      symbol: "IDR ",
                                      locale: "id-ID",
                                      decimalDigits: 0,
                                    ).format(widget.food.price! * qty),
                                  ),
                                ],
                              ),
                              BlocBuilder<UserBloc, UserState>(
                                builder: (context, state) {
                                  if (state is UserLoaded) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        int totalFood =
                                            (qty * widget.food.price!).toInt();
                                        int tax = (totalFood * 0.1).toInt();
                                        int driver = 50000;
                                        int total = tax + driver + totalFood;

                                        Transaction transaction = Transaction(
                                          user: state.user,
                                          food: widget.food,
                                          qty: qty,
                                          driver: driver,
                                          tax: tax,
                                          total: total,
                                        );

                                        Get.to(
                                          () => TransactionPage(
                                            transaction: transaction,
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color(0xffFFC700),
                                        minimumSize: const Size(110, 45),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        "Order Now",
                                        style: subTitleFontStyle.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Column(
                                        children: const [
                                          SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator(),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 24),
              child: GestureDetector(
                child: const FaIcon(
                  FontAwesomeIcons.angleLeft,
                  color: Colors.white,
                  size: 28,
                ),
                onTap: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
