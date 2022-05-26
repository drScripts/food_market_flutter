part of './widgets.dart';

class ListFoodItem extends StatelessWidget {
  final Food food;
  final Function(Food)? onTap;
  const ListFoodItem({
    Key? key,
    required this.food,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        if (onTap != null) {
          onTap!(food);
        }
      }),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(food.imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          SizedBox(
            width: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  food.name!,
                  style: formTitleStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  NumberFormat.currency(
                    symbol: "IDR ",
                    locale: "id-ID",
                    decimalDigits: 0,
                  ).format(food.price!),
                  style: formHintStyle.copyWith(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          RatingStars(
            stars: food.rating,
          ),
        ],
      ),
    );
  }
}
