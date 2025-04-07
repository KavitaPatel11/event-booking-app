import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';
import '../sources/booking_local_datasource.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingLocalDataSource localDataSource;

  BookingRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveBooking(Booking booking) => localDataSource.saveBooking(booking);

  @override
  List<Booking> getBookings() => localDataSource.getBookings();
}
