import 'package:acinema_flutter_project/core/widgets/loading_screen.dart';
import 'package:acinema_flutter_project/features/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserCubit userCubit;

  @override
  void initState() {
    userCubit = UserCubit();
    userCubit.loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        bloc: userCubit,
        builder: (context, state) {
          if (state is UserLoading) {
            return const LoadingScreen();
          } else if (state is UserLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${state.user.id}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text('Name: ${state.user.name}'),
                  Text('Phone Number: ${state.user.phoneNumber}'),
                  const SizedBox(height: 16.0),
                  Text(
                      'Created At: ${DateTime.fromMillisecondsSinceEpoch(state.user.createdAt * 1000)}'),
                  Text(
                      'Updated At: ${DateTime.fromMillisecondsSinceEpoch(state.user.updatedAt * 1000)}'),
                ],
              ),
            );
          }
          return const Text(
            "Check your Internet connection!",
            style: TextStyle(color: Colors.redAccent),
          );
        },
      ),
    );
  }
}
