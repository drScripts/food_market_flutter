part of './widgets.dart';

class QtyCounter extends StatelessWidget {
  final int qty;
  final Function(String)? onTap;
  const QtyCounter({Key? key, required this.qty, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (() {
            if (onTap != null) {
              onTap!("decrement");
            }
          }),
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(),
            ),
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.minus,
                size: 12,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            qty.toString(),
          ),
        ),
        GestureDetector(
          onTap: (() {
            if (onTap != null) {
              onTap!("increment");
            }
          }),
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(),
            ),
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                size: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
