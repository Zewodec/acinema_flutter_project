import 'package:acinema_flutter_project/features/login/data/data_source/token_local_datasource.dart';
import 'package:flutter/material.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  String sasTok = "";
  String acasTok = "";

  Future<void> getSessionToken() async {
    sasTok = (await TokenLocalDataSource.getSessionToken())!;
    acasTok = (await TokenLocalDataSource.getAccessToken())!;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: getSessionToken(),
                builder: (context, snapshot) =>
                    Text("Session Token:$sasTok\nAccessToken:$acasTok")),
          ],
        ),
      ),
    );
  }
}
