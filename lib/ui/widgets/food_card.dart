part of './widgets.dart';

class FoodCard extends StatelessWidget {
  final Food? food;
  final Function(Food)? onTap;
  const FoodCard({Key? key, this.food, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (onTap != null) {onTap!(food!)}
      },
      child: Container(
        margin: const EdgeInsets.only(right: defaultMarginPadding),
        width: 200,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 1,
              color: Color(0xffc5c5c5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(food!.imageUrl!),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food?.name ?? "",
                    style: foodNameStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 6),
                  RatingStars(
                    stars: food?.rating,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
