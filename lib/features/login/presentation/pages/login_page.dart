import 'package:acinema_flutter_project/features/login/data/models/device_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  late TextEditingController _phoneNumberFieldController;

  // String _phoneNumber = "";

  @override
  void initState() {
    _phoneNumberFieldController = TextEditingController();
    _phoneNumberFieldController.text = "+38";
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
                    if (RegExp(r'^\+380\d{9}$').hasMatch(value)) {
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
                        Text(
                          "Авторизуватись за ",
                          style: TextStyle(fontFamily: "FixelText"),
                        ),
                        Icon(Icons.phone)
                      ],
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 200,
                height: 30,
                child: OutlinedButton(
                    onPressed: () async => {
                          Fluttertoast.showToast(
                              msg: await DeviceInfo.getId(),
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0)
                        },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Авторизуватись як гість ",
                          style: TextStyle(
                              fontFamily: "FixelText",
                              fontSize: 11,
                              fontStyle: FontStyle.italic),
                        ),
                        Icon(Icons.people)
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
