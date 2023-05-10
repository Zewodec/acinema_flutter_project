import 'package:acinema_flutter_project/features/buying/data/repository/buying_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'buying_state.dart';

class BuyingCubit extends Cubit<BuyingState> {
  BuyingCubit(this.repository) : super(BuyingInitial());

  List<int> selectedSeats = [];
  int sessionId = 0;
  Map<int, String> selectedSeatsText = {};

  final BuyingRepository repository;

  void setSessionId(int sessionId) {
    this.sessionId = sessionId;
  }

  void addSelectedSeat(int seatId, String seatPositionText) {
    selectedSeats.add(seatId);
    selectedSeatsText.addAll({sessionId: seatPositionText});
    if (selectedSeats.isNotEmpty) {
      emit(BookSeatsReadyState());
    }
  }

  void removeSelectedSeat(int seatId, String seatPosition) {
    selectedSeats.remove(seatId);
    selectedSeatsText.remove({sessionId});
    if (selectedSeats.length <= 1) {
      emit(BuyingInitial());
    }
  }

  void bookSeat() async {
    emit(BookingSeatsState());
    Map<String, dynamic> gotBookResponse =
        await repository.dioBookSeats(selectedSeats, sessionId);
    if (isErrorInData(gotBookResponse)) {
      return;
    }
    emit(BookingSuccessSeatsState(gotBookResponse['data']));
  }

  bool isErrorInData(Map<String, dynamic> sessionsData) {
    if (sessionsData.containsKey("error") &&
        sessionsData['error'].toString().isNotEmpty &&
        sessionsData['error'] != null) {
      emit(BuyingErrorState(sessionsData['error']));
      return true;
    } else if (sessionsData.containsKey("error") &&
        (sessionsData['error'].toString().isEmpty ||
            sessionsData['error'] == null)) {
      emit(BuyingErrorState("Something went wrong when getting sessions!"));
      return true;
    }
    return false;
  }
}
