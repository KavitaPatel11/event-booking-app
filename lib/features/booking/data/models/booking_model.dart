import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  BookingModel({
    required super.id,
    required super.event,
    required super.name,
    required super.email,
    required super.phone,
    required super.selectedSeats,
    required super.bookingDate,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      event: json['event'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      selectedSeats: List<String>.from(json['selectedSeats']),
      bookingDate: DateTime.parse(json['bookingDate']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'event': event,
        'name': name,
        'email': email,
        'phone': phone,
        'selectedSeats': selectedSeats,
        'bookingDate': bookingDate.toIso8601String(),
      };
}
