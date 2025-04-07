import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../home/domain/entities/home_event.dart';

class SeatSelectionPage extends StatefulWidget {
  final HomeEvent event;

  const SeatSelectionPage({super.key, required this.event});

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  final List<String> seats = [
    'A1',
    'A2',
    'A3',
    'A4',
    'A5',
    'B1',
    'B2',
    'B3',
    'B4',
    'B5',
    'C1',
    'C2',
    'C3',
    'C4',
    'C5',
  ];

  final List<String> bookedSeats = ['A3', 'B2', 'C5'];
  List<String> selectedSeats = [];

  void toggleSeat(String seat) {
    if (bookedSeats.contains(seat)) return;

    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
      } else {
        selectedSeats.add(seat);
      }
    });
  }

  Widget buildSeatLegendBox(Color color, String label) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seat Selection")),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: seats.map((seat) {
                    final isBooked = bookedSeats.contains(seat);
                    final isSelected = selectedSeats.contains(seat);

                    Color seatColor = isBooked
                        ? Colors.grey.shade300
                        : isSelected
                            ? Colors.blue.shade300
                            : Colors.green.shade300;

                    return GestureDetector(
                      onTap: () => toggleSeat(seat),
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: seatColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          seat,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Divider(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSeatLegendBox(Colors.green.shade300, "Available"),
                      buildSeatLegendBox(Colors.blue.shade300, "Selected"),
                      buildSeatLegendBox(Colors.grey.shade300, "Booked"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Divider(),
                const SizedBox(height: 20),
                Text(
                  "Selected Seat(s): ${selectedSeats.isEmpty ? 'None' : selectedSeats.join(', ')}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Sticky Bottom Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.orange.withOpacity(0.4),
                    disabledForegroundColor: Colors.white70,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: selectedSeats.isNotEmpty
                      ? () {
                          context.push(
                            '/booking',
                            extra: {
                              'event': widget.event,
                              'selectedSeats': selectedSeats
                            },
                          );
                        }
                      : null,
                  child: const Text("Continue", style: TextStyle(fontSize: 16)),
                )),
          ),
        ],
      ),
    );
  }
}
