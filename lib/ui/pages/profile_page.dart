part of './pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedTab = 0;

  onTabPressed(index) {
    setState(() {
      selectedTab = index;
    });
  }

  accountTabList() {
    return [
      ProfileItem(
        title: "Edit Profile",
        onTap: () {
          Get.offAll(() => const EditProfilePage());
        },
      ),
      ProfileItem(
        title: "Home Address",
        onTap: () {
          Get.offAll(() => const EditAddressPage());
        },
      ),
      ProfileItem(
        title: "Security",
        onTap: () {},
      ),
      ProfileItem(
        title: "Payments",
        onTap: () {},
      ),
    ];
  }

  foodMarketList() {
    return [
      ProfileItem(
        title: "Rate App",
        onTap: () {},
      ),
      ProfileItem(
        title: "Help Center",
        onTap: () {},
      ),
      ProfileItem(
        title: "Privacy & Policy",
        onTap: () {},
      ),
      ProfileItem(
        title: "Terms & Conditions",
        onTap: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        User user = (state as UserLoaded).user;
        ImageProvider image = const AssetImage(
          'assets/images/default_profile.png',
        );

        if (user.profilePicture != null) {
          image = NetworkImage(user.profilePicture!);
        }

        return ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: defaultMarginPadding,
                ),
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/photo_border.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Text(
                      user.name,
                      style: titleFontStyle,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Text(
                      user.email,
                      style: subTitleFontStyle,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: defaultMarginPadding,
                  ),
                  width: double.infinity,
                  height: defaultMarginPadding,
                  color: defaultBackgroundColor,
                ),
                CustomTabBar(
                  titles: const ["Account", "FoodMarket"],
                  selectedIndex: selectedTab,
                  onTap: onTabPressed,
                ),
                const SizedBox(
                  height: 12,
                ),
                Builder(
                  builder: (_) {
                    return Column(
                        children: selectedTab == 0
                            ? accountTabList()
                            : foodMarketList());
                  },
                ),
                const SizedBox(
                  height: defaultMarginPadding * 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultMarginPadding,
                  ),
                  child: GeneralBtn(
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      Get.offAll(() => const SignInPage());
                      context.read<UserBloc>().add(Logout());
                    },
                    title: "Log Out",
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
