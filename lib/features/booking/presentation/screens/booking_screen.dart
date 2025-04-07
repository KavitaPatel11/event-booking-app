import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../home/domain/entities/home_event.dart';
import '../../domain/entities/booking.dart';
import '../providers/booking_provider.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final HomeEvent event;
  final List<String> selectedSeats;

  const BookingScreen({
    super.key,
    required this.event,
    required this.selectedSeats,
  });

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final uuid = Uuid();

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      final booking = Booking(
       id: uuid.v4(), // 🔑 generate unique ID
        event: widget.event,
        name: _name.text,
        email: _email.text,
        phone: _phone.text,
        selectedSeats: widget.selectedSeats,
        bookingDate: DateTime.now(),
      );

      try {
        await ref.read(bookingViewModelProvider).save(booking);
        context.go('/booking-confirmation', extra: {
          'bookingId': booking.id,
          'event': booking.event,
          'seatNumbers': booking.selectedSeats,
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()),backgroundColor: Colors.red,),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book Your Seats")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // 👇 Booking Summary
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Booking Summary:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text("Event: ${widget.event.title}"),
                    Text("Selected Seats: ${widget.selectedSeats.join(', ')}"),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              // 👇 Booking Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(labelText: "Name"),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: (v) => v == null || !v.contains('@')
                          ? 'Invalid email'
                          : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      controller: _phone,
                      decoration: const InputDecoration(
                          labelText: "Phone", counterText: ""),
                      validator: (v) =>
                          v == null || v.length < 10 ? 'Invalid phone' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submit,
                      child: const Text('Confirm Booking'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
