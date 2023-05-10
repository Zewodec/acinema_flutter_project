part of 'buying_cubit.dart';

@immutable
abstract class BuyingState extends Equatable {}

class BuyingInitial extends BuyingState {
  @override
  List<Object?> get props => [];
}

class BookSeatsReadyState extends BuyingState {
  @override
  List<Object?> get props => [];
}

class BookingSeatsState extends BuyingState {
  @override
  List<Object?> get props => [];
}

class BookingSuccessSeatsState extends BuyingState {
  final bool bookResponse;

  BookingSuccessSeatsState(this.bookResponse);

  @override
  List<Object?> get props => [];
}

class BuyingSeatsState extends BuyingState {
  @override
  List<Object?> get props => [];
}

class BuyingSuccessState extends BuyingState {
  @override
  List<Object?> get props => [];
}

class BuyingErrorState extends BuyingState {
  BuyingErrorState(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [];
}
