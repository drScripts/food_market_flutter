part of './pages.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? imageFile;
  ImageProvider? imageProvider;

  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  Future _pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageFile = File.fromUri(Uri.parse(image.path));
      setState(() {
        imageProvider = FileImage(File.fromUri(Uri.parse(image.path)));
      });
    }
  }

  init(BuildContext context) {
    UserState state = context.read<UserBloc>().state;

    if (state is UserLoaded) {
      nameController.text = state.user.name;
      emailController.text = state.user.email;
      passwordController.text = "00000000";
      if (state.user.profilePicture != null && imageFile == null) {
        imageProvider = NetworkImage(state.user.profilePicture!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return GeneralPage(
      title: "Sign Up",
      subTitle: "Register and eat",
      onBack: () {
        Get.off(() => const MainPage());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMarginPadding,
          vertical: 20,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 16),
              width: 110,
              height: 110,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/photo_border.png"),
                ),
              ),
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: imageProvider == null
                      ? Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/photo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            FormControl(
              title: "Full Name",
              placeHolder: "Type your full name",
              controller: nameController,
              marginBottom: 16,
            ),
            FormControl(
              title: "Email Address",
              placeHolder: "Type your email address",
              controller: emailController,
              marginBottom: 16,
            ),
            FormControl(
              title: "Password",
              placeHolder: "Type your password",
              controller: passwordController,
              marginBottom: 16,
              obsecure: true,
              enabled: false,
            ),
            BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const DialogLoading(),
                  );
                }

                if (state is UserFailed) {
                  Get.snackbar(
                    "Error",
                    state.message,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  Navigator.pop(context);
                  Get.off(() => const EditProfilePage());
                }

                if (state is UserLoaded) {
                  Get.snackbar(
                    "Success",
                    "Success Update Profile",
                    backgroundColor: const Color(0xff4CAF50),
                    colorText: Colors.white,
                  );
                  Navigator.pop(context);
                  Get.off(() => const EditProfilePage());
                }
              },
              child: GeneralBtn(
                title: "Continue",
                onPressed: () {
                  if (emailController.text.isEmpty ||
                      nameController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please fill all form!",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else {
                    if (passwordController.text.length < 8) {
                      Get.snackbar(
                        "Error",
                        'Password length must be greather than equal 8 !',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else {
                      UserState state = context.read<UserBloc>().state;
                      if (state is UserLoaded) {
                        User user = state.user.copyWith(
                          name: nameController.text,
                          email: emailController.text,
                        );

                        context
                            .read<UserBloc>()
                            .add(Update(user: user, file: imageFile));
                      }
                    }
                  }
                },
                marginTop: 8,
              ),
            )
          ],
        ),
      ),
    );
  }
}
