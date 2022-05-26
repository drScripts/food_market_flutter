part of './pages.dart';

List<DropDownModel> mockList = [
  const DropDownModel("Bandung", "bandung"),
  const DropDownModel("Jakarta", 'jakarta'),
  const DropDownModel("Bekasi", 'bekasi')
];

class AddAddressPage extends StatefulWidget {
  final User user;
  final File filePicture;
  const AddAddressPage({
    Key? key,
    required this.user,
    required this.filePicture,
  }) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  String? cityValue;

  TextEditingController phoneNumberController = TextEditingController(text: "");
  TextEditingController addressController = TextEditingController(text: "");
  TextEditingController houseNumberController = TextEditingController(text: "");

  onCityChange(value) {
    cityValue = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: "Address",
      subTitle: "Make sure it’s valid",
      onBack: () {
        Get.back();
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
                  Get.offAll(() => const MainPage());
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
                    context.read<UserBloc>().add(Register(
                          user: widget.user.copyWith(
                            phoneNumber: phoneNumberController.text,
                            address: addressController.text,
                            houseNumber: houseNumberController.text,
                            city: cityValue,
                          ),
                          file: widget.filePicture,
                        ));
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
