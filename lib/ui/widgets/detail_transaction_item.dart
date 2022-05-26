part of './widgets.dart';

class DetailTransactionItem extends StatelessWidget {
  final String title;
  final String value;
  final Color valueTextColor;
  final EdgeInsets margin;
  const DetailTransactionItem({
    Key? key,
    required this.title,
    required this.value,
    this.valueTextColor = Colors.black,
    this.margin = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: subTitleFontStyle,
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              value,
              style: subTitleFontStyle.copyWith(
                color: valueTextColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }
}
