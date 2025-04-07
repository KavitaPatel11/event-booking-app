
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../home/domain/entities/home_event.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final HomeEvent event;
  final String bookingId;
  final List<String> seatNumbers;

  const BookingConfirmationScreen({
    super.key,
    required this.event,
    required this.bookingId,
    required this.seatNumbers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 20),
              const Text(
                "Booking Successful ✔️",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Text("Event : ${event.title}"),
              const SizedBox(height: 8),
              Text("Seat(s): ${seatNumbers.join(', ')}"),
              const SizedBox(height: 8),
              Text("Booking ID: $bookingId"),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
context.go('/home');
                },
                icon: const Icon(Icons.home),
                label: const Text("Go to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
