import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/home_event.dart';

class EventDetailPage extends StatefulWidget {
  final String title;
  final HomeEvent event;

  final String date;
  final String location;
  final String image;
  final String description;
  final bool isBooked;
  final List<String> seatNumbers;
  final String bookingDate;

  const EventDetailPage({
    super.key,
    required this.title,
    required this.event,
    required this.date,
    required this.location,
    required this.image,
    required this.description,
    required this.isBooked,
    required this.seatNumbers,
    required this.bookingDate,
  });

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Header Banner
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    widget.image,
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SafeArea(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(widget.date,
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(width: 16),
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.location,
                        style: const TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.isBooked)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text("Seat Number: ${widget.seatNumbers.join(',')}",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.green)),
                      const SizedBox(height: 8),
                      Text("Booked on: ${widget.bookingDate}",
                          style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      widget.description,
                      maxLines: isExpanded ? null : 3,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 14),
                    )),
              ),
              if (!isExpanded)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = true;
                      });
                    },
                    child: const Text("Read more"),
                  ),
                ),
              const SizedBox(height: 100), // To leave space for sticky button
            ],
          ),
          if (!widget.isBooked)
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
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    context.push(
                      '/book-seat',
                      extra: {
                        'event': widget.event,
                      },
                    );
                    // TODO: Implement booking logic
                  },
                  child: Text("Book Now", style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
