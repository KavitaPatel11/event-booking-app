import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class SaveBookingUseCase {
  final BookingRepository repository;

  SaveBookingUseCase(this.repository);

  Future<void> call(Booking booking) => repository.saveBooking(booking);
}
