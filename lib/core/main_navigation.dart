import 'package:acinema_flutter_project/core/widgets/LoadingScreen.dart';
import 'package:acinema_flutter_project/features/auth/cubit/auth_cubit.dart';
import 'package:acinema_flutter_project/features/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late AuthCubit authCubit;

  @override
  void initState() {
    authCubit = AuthCubit();
    authCubit.checkIfUserAuthorized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: authCubit,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AuthInitial) {
          return const LoadingScreen();
        } else if (state is NotAuthorized) {
          return const LoginPage();
        } else if (state is Authorized) {
          return const Center(
            child: Text(
              "YEAH WE DID IT!",
              style: TextStyle(
                  fontFamily: "FixelDisplay",
                  fontWeight: FontWeight.w700,
                  fontSize: 40),
            ),
          );
        } else if (state is ErrorAuthorization) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Error Authorization",
                style: TextStyle(fontFamily: "FixelText", color: Colors.white),
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Something went wrong!",
            style: TextStyle(fontFamily: "FixelText", color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ));
        return const Scaffold(
          body: Center(
            child: Text(
              "Error went unexpected",
              style: TextStyle(
                  fontFamily: "FixelText", fontWeight: FontWeight.w700),
            ),
          ),
        );
      },
    );
  }
}
