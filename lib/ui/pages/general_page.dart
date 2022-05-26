part of './pages.dart';

class GeneralPage extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Function()? onBack;
  final Widget? child;
  final Color? backgroundColor;

  const GeneralPage({
    Key? key,
    required this.title,
    this.subTitle = "",
    this.onBack,
    this.child,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          SafeArea(
            child: Container(
              color: backgroundColor ?? Colors.white,
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 100,
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultMarginPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          onBack != null
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    right: defaultMarginPadding,
                                  ),
                                  child: GestureDetector(
                                    onTap: onBack,
                                    child: const FaIcon(
                                      FontAwesomeIcons.angleLeft,
                                      size: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: titleFontStyle,
                              ),
                              Text(
                                subTitle!,
                                style: subTitleFontStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: defaultMarginPadding,
                  width: double.infinity,
                  color: defaultBackgroundColor,
                ),
                child ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
