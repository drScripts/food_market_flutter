part of './widgets.dart';

class RatingStars extends StatelessWidget {
  final double? stars;
  const RatingStars({Key? key, this.stars = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberOfStars = stars!.round();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List<Widget>.generate(
            5,
            (index) => index < numberOfStars
                ? const Icon(
                    MdiIcons.star,
                    color: lightYellow,
                    size: 18,
                  )
                : const Icon(
                    MdiIcons.star,
                    color: greyLight,
                    size: 18,
                  ),
          ) +
          [
            const SizedBox(
              width: 4,
            ),
            Text(
              stars.toString(),
              style: subTitleFontStyle,
            )
          ],
    );
  }
}
