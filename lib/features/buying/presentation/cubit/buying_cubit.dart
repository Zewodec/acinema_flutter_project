import 'package:acinema_flutter_project/features/buying/data/repository/buying_repository.dart';
import 'package:acinema_flutter_project/features/movies_sessions/data/models/movie_sessions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'buying_state.dart';

class BuyingCubit extends Cubit<BuyingState> {
  BuyingCubit(this.repository) : super(BuyingInitial());

  List<Seat> selectedSeats = [];
  int sessionId = 0;

  void clearSeats() {
    selectedSeats.clear();
  }

  List<int> selectedSeatsIds() {
    List<int> result = [];
    for (Seat seat in selectedSeats) {
      result.add(seat.id);
    }
    return result;
  }

  final BuyingRepository repository;

  void setSessionId(int sessionId) {
    this.sessionId = sessionId;
  }

  void addSelectedSeat(Seat seat) {
    selectedSeats.add(seat);
    if (selectedSeats.isNotEmpty) {
      emit(BookSeatsReadyState());
    }
  }

  void removeSelectedSeat(Seat seat) {
    selectedSeats.remove(seat);
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
    Future.delayed(const Duration(seconds: 3))
        .then((value) => emit(BuyingInitial()));
  }

  void buySeats(
      String email, String cardNumber, String exprationDate, String cvv) async {
    emit(BuyingSeatsState());
    Map<String, dynamic> gotBuyResponse = await repository.dioBuySeats(
        selectedSeatsIds(), sessionId, email, cardNumber, exprationDate, cvv);
    if (isErrorInData(gotBuyResponse)) {
      return;
    }
    emit(BuyingSuccessState(gotBuyResponse['data']));
    Future.delayed(const Duration(seconds: 3))
        .then((value) => emit(BuyingInitial()));
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
