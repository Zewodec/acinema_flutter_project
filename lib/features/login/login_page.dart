import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  late TextEditingController _phoneNumberFieldController;

  // late LoginAPI loginAPI;

  // String _phoneNumber = "";

  @override
  void initState() {
    _phoneNumberFieldController = TextEditingController();
    _phoneNumberFieldController.text = "+38";
    // loginAPI = LoginAPI();
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
                    if (RegExp(r'^\+\d{1,3}\s?\d{3,14}$').hasMatch(value)) {
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
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 200,
                height: 35,
                child: OutlinedButton(
                    onPressed: () => {},
                    child: const Text(
                      "Авторизуватись як гість ",
                      style: TextStyle(fontFamily: "FixelText", fontSize: 12),
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
