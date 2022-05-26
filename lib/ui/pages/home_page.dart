part of './pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  initState() {
    BlocProvider.of<TransactionBloc>(context).add(const LoadTransaction());
    BlocProvider.of<ProductBloc>(context).add(const LoadProuct());

    super.initState();
  }

  onCardTap(Food food) {
    Get.to(() => DetailFoodPage(food: food));
  }

  onTap(int index) {
    setState(
      () {
        selectedIndex = index;
      },
    );
  }

  Iterable<Food> _filterFood(String type, List<Food> foods) {
    return foods.where((element) => element.type == type);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: defaultMarginPadding,
          ),
          margin: const EdgeInsets.only(bottom: defaultMarginPadding - 12),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Food Market",
                    style: titleFontStyle,
                  ),
                  Text(
                    "Let’s get some foods",
                    style: subTitleFontStyle,
                  )
                ],
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoaded) {
                    ImageProvider image = const AssetImage(
                      'assets/images/default_profile.png',
                    );

                    if (state.user.profilePicture != null) {
                      image = NetworkImage(state.user.profilePicture!);
                    }

                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/default_profile.png',
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: defaultMarginPadding),
          width: double.infinity,
          height: 250,
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoaded) {
                List<Food> foods = _filterFood("none", state.products).toList();

                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: defaultMarginPadding),
                      child: Row(
                        children: foods
                            .map((e) => FoodCard(
                                  food: e,
                                  onTap: onCardTap,
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
        CustomTabBar(
          titles: const ["New Taste", "Popular", "Recommended"],
          selectedIndex: selectedIndex,
          onTap: onTap,
        ),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          if (state is ProductLoaded) {
            List<Food> products = state.products;
            List<Food> body = [];

            if (selectedIndex == 0) {
              body = _filterFood("new_taste", products).toList();
            } else if (selectedIndex == 1) {
              body = _filterFood("popular", products).toList();
            } else {
              body = _filterFood('recommended', products).toList();
            }

            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultMarginPadding,
              ),
              child: Column(
                children: body
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ListFoodItem(
                          food: e,
                          onTap: onCardTap,
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          } else {
            return Center(
              child: Column(
                children: const [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            );
          }
        }),
        const SizedBox(
          height: 80,
        ),
      ],
    );
  }
}
