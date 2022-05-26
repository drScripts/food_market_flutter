part of './widgets.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTap;
  const CustomBottomNavigation({
    Key? key,
    this.selectedIndex = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap!(0);
              }
            },
            child: Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icons/ic_home${(selectedIndex == 0) ? ".png" : "_normal.png"}',
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap!(1);
              }
            },
            child: Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icons/ic_order${(selectedIndex == 1) ? ".png" : "_normal.png"}',
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap!(2);
              }
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icons/ic_profile${(selectedIndex == 2) ? ".png" : "_normal.png"}',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
