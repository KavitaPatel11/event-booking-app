import '../entities/booking.dart';

abstract class BookingRepository {
  Future<void> saveBooking(Booking booking);
  List<Booking> getBookings();
}
