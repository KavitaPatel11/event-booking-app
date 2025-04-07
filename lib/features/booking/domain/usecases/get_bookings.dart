import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class GetBookingsUseCase {
  final BookingRepository repository;

  GetBookingsUseCase(this.repository);

  List<Booking> call() => repository.getBookings();
}
