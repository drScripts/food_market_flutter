part of './widgets.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const ProfileItem({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultMarginPadding),
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: formTitleStyle,
          ),
          GestureDetector(
            onTap: onTap,
            child: const FaIcon(
              FontAwesomeIcons.angleRight,
            ),
          )
        ],
      ),
    );
  }
}
