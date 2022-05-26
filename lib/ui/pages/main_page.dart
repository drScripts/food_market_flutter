part of './pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  onNavTap(index) {
    setState(
      () {
        selectedIndex = index;
        pageController.jumpToPage(selectedIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              color: const Color(0xffFAFAFC),
            ),
          ),
          SafeArea(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) => {
                setState((() {
                  selectedIndex = index;
                }))
              },
              children: [
                const HomePage(),
                OrdersPage(
                  jumpToPage: (index) {
                    pageController.jumpToPage(index);
                  },
                ),
                const ProfilePage(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigation(
              onTap: onNavTap,
              selectedIndex: selectedIndex,
            ),
          )
        ],
      ),
    );
  }
}
