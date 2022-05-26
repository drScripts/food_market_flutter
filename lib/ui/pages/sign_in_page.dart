part of './pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  bool isLoading = false;

  void onLogin() {}

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoading) {
          showDialog(
            context: context,
            builder: (_) {
              return const DialogLoading();
            },
            barrierDismissible: false,
            useSafeArea: false,
          );
        }

        if (state is UserLoaded) {
          Get.offAll(() => const MainPage());
        }

        if (state is UserFailed) {
          Get.snackbar(
            "Error",
            state.message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );

          Navigator.pop(context);
        }
      },
      child: GeneralPage(
        title: "Sign In",
        subTitle: "Find your best ever meal",
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(defaultMarginPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormControl(
                title: "Email Address",
                placeHolder: "Type your email address",
                controller: emailController,
                icon: const FaIcon(
                  FontAwesomeIcons.envelope,
                  color: Colors.black,
                ),
                marginBottom: 15,
              ),
              FormControl(
                title: "Password",
                placeHolder: "Type your password",
                controller: passwordController,
                obsecure: true,
                icon: const FaIcon(
                  FontAwesomeIcons.key,
                  color: Colors.black,
                ),
                marginBottom: defaultMarginPadding,
              ),
              GeneralBtn(
                onPressed: () {
                  String email = emailController.text;
                  String password = passwordController.text;

                  if (email != '' && password != '') {
                    context
                        .read<UserBloc>()
                        .add(Login(email: email, password: password));
                  } else {
                    Get.snackbar(
                      "error",
                      "Please fill all form!",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                title: "Sign In",
                marginBottom: 12,
              ),
              GeneralBtn(
                title: "Create New Account",
                backgroundColor: const Color(0xff8D92A3),
                textColor: Colors.white,
                onPressed: () {
                  Get.off(() => const SignUpPage());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
