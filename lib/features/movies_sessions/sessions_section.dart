import 'package:acinema_flutter_project/features/movies_sessions/presentation/cubit/sessions_cubit.dart';
import 'package:acinema_flutter_project/features/movies_sessions/presentation/widgets/session_button_widget.dart';
import 'package:flutter/material.dart';

class SessionSection extends StatefulWidget {
  const SessionSection({Key? key}) : super(key: key);

  @override
  State<SessionSection> createState() => _SessionSectionState();
}

class _SessionSectionState extends State<SessionSection> {
  late SessionsCubit sessionsCubit;

  @override
  void initState() {
    sessionsCubit = SessionsCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTimeNow = DateTime.now();
    List<Widget> buttons = List.generate(
      7,
      (index) => SessionButtonWidget(
        dateTime: DateTime(
            dateTimeNow.year, dateTimeNow.month, dateTimeNow.day + index),
      ),
    );
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: buttons,
      ),
    );
  }
}
