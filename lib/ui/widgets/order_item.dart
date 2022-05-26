part of './widgets.dart';

class OrderItem extends StatelessWidget {
  final Transaction transaction;
  final Function(Transaction)? onTap;
  const OrderItem({Key? key, required this.transaction, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("id_ID");
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(transaction);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(transaction.food!.imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 160,
                child: Text(
                  transaction.food!.name!,
                  style: formTitleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 160,
                child: Text(
                  "${transaction.qty} items • ${NumberFormat.currency(locale: "id-ID", decimalDigits: 0, symbol: "IDR ").format(transaction.total)}",
                  style: subTitleFontStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          (transaction.status != null)
              ? Column(
                  children: [
                    Text(
                      DateFormat("MMMM dd, HH:mm", "id_ID").format(
                        DateTime.fromMillisecondsSinceEpoch(1652993893 * 1000),
                      ),
                      style: subTitleFontStyle.copyWith(fontSize: 10),
                    ),
                    Text(
                      transaction.status!,
                      style: subTitleFontStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: transaction.status == "completed"
                            ? const Color(0xff1ABC9C)
                            : transaction.status == "canceled"
                                ? const Color(0xffD9435E)
                                : const Color(0xffFFC700),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
