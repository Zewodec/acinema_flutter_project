import 'package:acinema_flutter_project/features/login/data/repository/login_repository.dart';
import 'package:acinema_flutter_project/features/login/presentation/cubit/login_cubit.dart';
import 'package:acinema_flutter_project/features/movies/movies_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/interceptors/accept_language_interseptor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  late TextEditingController _phoneNumberFieldController;
  late LoginCubit loginCubit;
  final getIt = GetIt.instance;

  @override
  void initState() {
    _phoneNumberFieldController = TextEditingController();
    _phoneNumberFieldController.text = "+38";
    getIt.registerSingleton<LoginRepository>(
        LoginRepository(Dio()..interceptors.add(AcceptLanguageInterceptor())));
    loginCubit = LoginCubit(GetIt.I<LoginRepository>());
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Authorization",
          style: TextStyle(fontFamily: "FixelDisplay"),
        ),
      ),
      body: Center(
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Authorization",
                style: TextStyle(
                  fontFamily: "FixelDisplay",
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: _phoneNumberFieldController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: TextStyle(
                        fontFamily: "FixelDisplay",
                      ),
                      hintText: "Yours Phone Number",
                      hintStyle:
                          TextStyle(fontFamily: "FixelText", fontSize: 12),
                      errorStyle:
                          TextStyle(fontFamily: "FixelText", fontSize: 12)),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter phone number";
                    }
                    // Check if the phone number has the correct length and starts with the correct prefix
                    if (RegExp(r'^\+\d{1,3}\s?\d{6,14}$').hasMatch(value)) {
                      return null; // Return null if the input is valid
                    } else {
                      return 'Check entered phone number'; // Return an error message if the input is invalid
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () =>
                    {if (_loginFormKey.currentState!.validate()) {}},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        // Auth by Phone
                        Text(
                          "Sign in with ",
                          style: TextStyle(fontFamily: "FixelText"),
                        ),
                        Icon(Icons.phone)
                      ],
                    )),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 200,
                height: 35,
                child: OutlinedButton(
                  onPressed: () => {loginCubit.signIn()},
                  child: const Text(
                    "Sign in as guest ",
                    style: TextStyle(fontFamily: "FixelText", fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer(
                bloc: loginCubit,
                listener: (context, state) {
                  if (state is LoginError) {
                    String errorMessage = state.errorMessage;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Error on Sing in Process!\n$errorMessage",
                          style: const TextStyle(
                              fontFamily: "FixelDisplay", color: Colors.white),
                        ),
                      ),
                    );
                  } else if (state is LoginSuccess) {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const MoviesPage(),
                          type: PageTransitionType.rightToLeft),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoginSignIn) {
                    return const CircularProgressIndicator(
                      color: Colors.green,
                    );
                  }
                  return const Text("");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
