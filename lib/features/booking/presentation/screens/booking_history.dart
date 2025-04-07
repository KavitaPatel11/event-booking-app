import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/booking_provider.dart';

class BookingHistoryScreen extends ConsumerWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(bookingViewModelProvider);

    return Scaffold(
      body: vm.bookings.isEmpty
          ? const Center(child: Text("No bookings yet."))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: vm.bookings.length,
              itemBuilder: (_, index) {
                final booking = vm.bookings[index];

                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 10,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  shadowColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color.fromARGB(60, 233, 225, 225)
                      : Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white24
                          : Colors.grey.shade300,
                      width: 1.2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🎟️ Event Name
                        Text(
                          '🎟️ Event: ${booking.event.title}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // 💺 Seat Numbers
                        Text(
                          '💺 Seats: ${booking.selectedSeats.join(', ')}',
                          style: const TextStyle(fontSize: 14),
                        ),

                        const SizedBox(height: 6),

                        // 📅 Booking Date
                        Text(
                          '📅 Booked On: ${DateFormat('dd MMMM yyyy – hh:mm a').format(booking.bookingDate)}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // 🔍 View Details Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () {
                              context.push(
                                '/event-detail',
                                extra: {
                                  'event': booking.event,
                                  'title': booking.event.title,
                                  'date': booking.event.date,
                                  'location': booking.event.location,
                                  'image': booking.event.thumbnail,
                                  'description': booking.event.description,
                                  'isBooked': true,
                                  'seatNumbers': booking.selectedSeats,
                                  'bookingDate':
                                      '${DateFormat('dd MMMM yyyy – hh:mm a').format(booking.bookingDate)}'
                                },
                              );
                            },
                            icon: const Icon(Icons.visibility, size: 18),
                            label: const Text("View Details"),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.deepOrangeAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
