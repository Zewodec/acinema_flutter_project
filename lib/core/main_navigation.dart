import 'package:acinema_flutter_project/core/widgets/loading_screen.dart';
import 'package:acinema_flutter_project/features/auth/cubit/auth_cubit.dart';
import 'package:acinema_flutter_project/features/login/login_page.dart';
import 'package:acinema_flutter_project/features/movies/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../features/movies_sessions/presentation/cubit/session_room_cubit.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late AuthCubit authCubit;

  @override
  void initState() {
    GetIt.I.registerSingleton<SessionRoomCubit>(SessionRoomCubit());
    authCubit = AuthCubit();
    authCubit.checkIfUserAuthorized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: authCubit,
      listener: (context, state) {
        if (state is NotAuthorized) {
          Future.delayed(const Duration(seconds: 1))
              .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.amber,
                      duration: Duration(seconds: 3),
                      content: Center(
                        child: Text(
                          "You need to sign in!",
                          style: TextStyle(
                              fontFamily: "FixelDisplay",
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ));
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
      },
      builder: (context, state) {
        if (state is AuthInitial) {
          return const LoadingScreen();
        } else if (state is NotAuthorized) {
          return const LoginPage();
        } else if (state is Authorized) {
          return const MoviesPage();
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
