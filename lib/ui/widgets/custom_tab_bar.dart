part of './widgets.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTap;
  final List<String> titles;
  const CustomTabBar({
    Key? key,
    this.selectedIndex = 0,
    required this.titles,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 48),
            height: 1,
            color: const Color(0xffF2F2F2),
          ),
          Row(
            children: titles
                .map(
                  (e) => GestureDetector(
                    onTap: (() {
                      if (onTap != null) {
                        onTap!(titles.indexOf(e));
                      }
                    }),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: defaultMarginPadding,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            e,
                            style: titles.indexOf(e) == selectedIndex
                                ? GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  )
                                : GoogleFonts.poppins(
                                    color: const Color(0xff8D92A3),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                          ),
                          Container(
                            width: 40,
                            height: 3,
                            margin: const EdgeInsets.only(top: 13),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.5),
                              color: (titles.indexOf(e) == selectedIndex)
                                  ? const Color(0xff020202)
                                  : Colors.transparent,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
