import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_market/bloc/product/product_bloc.dart';
import 'package:food_market/bloc/transaction/transaction_bloc.dart';
import 'package:food_market/bloc/user/user_bloc.dart';
import 'package:food_market/ui/pages/pages.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: ((context) => UserBloc()..add(CheckCredential())),
        ),
        BlocProvider<ProductBloc>(
          create: ((context) => ProductBloc()),
        ),
        BlocProvider<TransactionBloc>(
          create: ((context) => TransactionBloc()),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoaded) {
              Get.offAll(() => const MainPage());
            }

            if (state is UserInitial) {
              Get.offAll(() => const SignInPage());
            }
          },
          child: const SignInPage(),
        ),
      ),
    );
  }
}
