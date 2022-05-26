part of './pages.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? imageFile;

  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  Future _pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageFile = File.fromUri(Uri.parse(image.path));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: "Sign Up",
      subTitle: "Register and eat",
      onBack: () {
        Get.off(() => const SignInPage());
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
                  child: imageFile == null
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
                              image: FileImage(imageFile!),
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
            ),
            GeneralBtn(
              title: "Continue",
              onPressed: () {
                if (imageFile == null) {
                  Get.snackbar(
                    "Error",
                    "Please add profile image!",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
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
                      User user = User(
                          id: 0,
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text);

                      Get.to(
                        () => AddAddressPage(
                          user: user,
                          filePicture: imageFile!,
                        ),
                      );
                    }
                  }
                }
              },
              marginTop: 8,
            )
          ],
        ),
      ),
    );
  }
}
