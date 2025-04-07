import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../../data/sources/booking_local_datasource.dart';
import '../../domain/entities/booking.dart';
import '../../domain/usecases/get_bookings.dart';
import '../../domain/usecases/save_booking_usecase.dart';

final bookingViewModelProvider = ChangeNotifierProvider((ref) {
  final saveUseCase = ref.read(saveBookingUseCaseProvider);
  final getUseCase = ref.read(getBookingsUseCaseProvider);
  return BookingViewModel(saveUseCase, getUseCase);
});

final saveBookingUseCaseProvider = Provider<SaveBookingUseCase>((ref) {
  final repo = ref.read(bookingRepositoryProvider);
  return SaveBookingUseCase(repo);
});

final getBookingsUseCaseProvider = Provider<GetBookingsUseCase>((ref) {
  final repo = ref.read(bookingRepositoryProvider);
  return GetBookingsUseCase(repo);
});

final bookingRepositoryProvider = Provider((ref) {
  return BookingRepositoryImpl(BookingLocalDataSource());
});

class BookingViewModel extends ChangeNotifier {
  final SaveBookingUseCase saveBooking;
  final GetBookingsUseCase getBookings;

 BookingViewModel(this.saveBooking, this.getBookings) {
    // 👇 Load existing bookings when ViewModel is initialized
    loadBookings();
  }

  List<Booking> bookings = [];

 Future<void> save(Booking booking) async {
  // Load current bookings
  final existing = getBookings();

  // Check for any seat already booked for this event
  final isDuplicate = existing.any((b) =>
      b.event.id == booking.event.id &&
      b.selectedSeats.any((seat) => booking.selectedSeats.contains(seat)));

  if (isDuplicate) {
    throw Exception("You have already booked one or more of these seats for this event.");
  }

  // No duplicates, proceed
  await saveBooking(booking);
  loadBookings();
}
  void loadBookings() {
    bookings = getBookings();
    notifyListeners();
  }
}
