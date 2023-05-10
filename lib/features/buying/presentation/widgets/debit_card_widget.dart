import 'package:acinema_flutter_project/features/movies/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../movies_sessions/presentation/cubit/sessions_cubit.dart';
import '../cubit/buying_cubit.dart';

class DebitCardWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final BuyingCubit buyingCubit = GetIt.I.get<BuyingCubit>();

  DebitCardWidget({super.key});

  void dispose() {
    _emailController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debit Card Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Debit Card',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _cardNumberController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Card Number',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the card number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            controller: _expiryDateController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Expiry Date',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the expiry date';
                              }
                              return null;
                            },
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            controller: _cvvController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'CVV',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the CVV';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              BlocConsumer(
                  bloc: buyingCubit,
                  builder: (context, state) {
                    if (state is BuyingSeatsState) {
                      return const CircularProgressIndicator(
                        color: Colors.greenAccent,
                      );
                    } else if (state is BuyingSuccessState) {
                      return const Text("Have a good time!");
                    }
                    return const Text("Enter your card data!");
                  },
                  listener: (context, state) {
                    if (state is BuyingSuccessState) {
                      if (state.buyResponse) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Success Payment!")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Failed Payment process!")));
                      }
                    } else if (state is BuyingErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Error: ${state.errorMessage}")));
                    }
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String cardNumber = _cardNumberController.text;
            String expiryDate = _expiryDateController.text;
            String cvv = _cvvController.text;
            String email = _emailController.text;

            buyingCubit.buySeats(email, cardNumber, expiryDate, cvv);
            GetIt.I<SessionsCubit>().loadSessionsForNext3DaysLast();

            _cardNumberController.clear();
            _expiryDateController.clear();
            _cvvController.clear();

            Future.delayed(const Duration(seconds: 3))
                .then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MoviesPage(),
                      ),
                    ));
          }
        },
        child: const Text('Submit'),
      ),
    );
  }
}
