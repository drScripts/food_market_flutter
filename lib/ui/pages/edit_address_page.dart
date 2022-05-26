part of './pages.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  String? cityValue;

  TextEditingController phoneNumberController = TextEditingController(text: "");
  TextEditingController addressController = TextEditingController(text: "");
  TextEditingController houseNumberController = TextEditingController(text: "");

  onCityChange(value) {
    cityValue = value;
    setState(() {});
  }

  init(BuildContext context) {
    UserState state = context.read<UserBloc>().state;

    if (state is UserLoaded) {
      phoneNumberController.text = state.user.phoneNumber ?? '';
      addressController.text = state.user.address ?? '';
      houseNumberController.text = state.user.houseNumber ?? '';
      cityValue = state.user.city;
    }
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return GeneralPage(
      title: "Address",
      subTitle: "Make sure it’s valid",
      onBack: () {
        Get.offAll(() => const MainPage());
      },
      child: Container(
        padding: const EdgeInsets.all(defaultMarginPadding),
        child: Column(
          children: [
            FormControl(
              placeHolder: "Type your phone number",
              title: "Phone No.",
              controller: phoneNumberController,
              marginBottom: 15,
              type: TextInputType.phone,
            ),
            FormControl(
              placeHolder: "Type your address",
              title: "Address",
              controller: addressController,
              marginBottom: 15,
              type: TextInputType.streetAddress,
            ),
            FormControl(
              placeHolder: "Type your house number",
              title: "House No.",
              controller: houseNumberController,
              marginBottom: 15,
              type: TextInputType.text,
            ),
            FormSelect(
              listItems: mockList,
              placeHolder: "Select your city",
              title: "City",
              onChange: onCityChange,
              value: cityValue,
            ),
            BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return const DialogLoading();
                    },
                  );
                }

                if (state is UserFailed) {
                  Navigator.pop(context);
                  Get.snackbar(
                    "Error",
                    state.message,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }

                if (state is UserLoaded) {
                  Navigator.pop(context);
                  Get.offAll(() => const EditAddressPage());
                }
              },
              child: GeneralBtn(
                marginTop: defaultMarginPadding,
                onPressed: () {
                  if (phoneNumberController.text.isEmpty ||
                      addressController.text.isEmpty ||
                      houseNumberController.text.isEmpty ||
                      cityValue == null) {
                    Get.snackbar("Error", "Please fill all form!",
                        backgroundColor: Colors.red, colorText: Colors.white);
                  }

                  if (phoneNumberController.text.isNotEmpty &&
                      addressController.text.isNotEmpty &&
                      houseNumberController.text.isNotEmpty &&
                      cityValue != null) {
                    UserState state = context.read<UserBloc>().state;
                    if (state is UserLoaded) {
                      User user = state.user.copyWith(
                          phoneNumber: phoneNumberController.text,
                          address: addressController.text,
                          houseNumber: houseNumberController.text,
                          city: cityValue);

                      context.read<UserBloc>().add(Update(user: user));
                    }
                  }
                },
                title: "Sign Up Now!",
              ),
            )
          ],
        ),
      ),
    );
  }
}
