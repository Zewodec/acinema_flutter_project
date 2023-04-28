import 'package:acinema_flutter_project/features/login/presentation/bloc/login_cubit.dart';
import 'package:acinema_flutter_project/features/movies/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  late TextEditingController _phoneNumberFieldController;
  late LoginCubit loginCubit;

  @override
  void initState() {
    _phoneNumberFieldController = TextEditingController();
    _phoneNumberFieldController.text = "+38";
    loginCubit = LoginCubit();
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
          "Авторизація",
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
                "Авторизація",
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
                      labelText: "Номер телефону",
                      labelStyle: TextStyle(
                        fontFamily: "FixelDisplay",
                      ),
                      hintText: "Ваш номер телефону",
                      hintStyle:
                      TextStyle(fontFamily: "FixelText", fontSize: 12),
                      errorStyle:
                      TextStyle(fontFamily: "FixelText", fontSize: 12)),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Введіть номер телефону, будь ласка";
                    }
                    // Check if the phone number has the correct length and starts with the correct prefix
                    if (RegExp(r'^\+\d{1,3}\s?\d{6,14}$').hasMatch(value)) {
                      return null; // Return null if the input is valid
                    } else {
                      return 'Введіть коректно номер телефону'; // Return an error message if the input is invalid
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
                          "Авторизуватись за ",
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
                  onPressed: () => {loginCubit.SignIn()},
                  child: const Text(
                    "Авторизуватись як гість ",
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Error on Sing in Process!",
                          style: TextStyle(
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
                      color: Colors.amber,
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
