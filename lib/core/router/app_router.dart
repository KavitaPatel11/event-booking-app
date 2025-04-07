import 'package:event_booking_app/features/booking/presentation/screens/booking_confirmation.dart';
import 'package:event_booking_app/features/booking/presentation/screens/booking_screen.dart';
import 'package:event_booking_app/features/booking/presentation/screens/seat_selection.dart';
import 'package:event_booking_app/features/home/presentation/screens/event_detail.dart';
import 'package:event_booking_app/features/home/presentation/screens/home_event_list_screen.dart';
import 'package:event_booking_app/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeEventListScreen(),
      ),
      GoRoute(
        path: '/event-detail',
        builder: (context, state) {
          final event = state.extra as Map<String, dynamic>;

          return EventDetailPage(
            event: event['event'],
            title: event['title'],
            date: event['date'],
            location: event['location'],
            image: event['image'],
            description: event['description'],
            isBooked: event['isBooked'],
            seatNumbers: event['seatNumbers'],
            bookingDate: event['bookingDate'],
          );
        },
      ),
      GoRoute(
        path: '/book-seat',
        builder: (context, state) {
          final event = state.extra as Map<String, dynamic>;

          return SeatSelectionPage(
            event: event['event'],
          );
        },
      ),
      GoRoute(
        path: '/booking',
        builder: (context, state) {
          final event = state.extra as Map<String, dynamic>;

          return BookingScreen(
            selectedSeats: event['selectedSeats'],
            event: event['event'],
          );
        },
      ),
      GoRoute(
        path: '/booking-confirmation',
        builder: (context, state) {
          final event = state.extra as Map<String, dynamic>;

          return BookingConfirmationScreen(
            bookingId: event['bookingId'],
            event: event['event'],
            seatNumbers: event['seatNumbers'],
          );
        },
      ),
    ],
  );
}
