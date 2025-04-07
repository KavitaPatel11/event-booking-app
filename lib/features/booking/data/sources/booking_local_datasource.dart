import 'package:hive/hive.dart';
import '../../domain/entities/booking.dart';

class BookingLocalDataSource {
  final _box = Hive.box<Booking>('bookings');

  Future<void> saveBooking(Booking booking) async {
    await _box.put(booking.id, booking);
  }

  List<Booking> getBookings() {
    return _box.values.toList();
  }
}
