import 'package:hive/hive.dart';
import '../../../home/data/models/home_event_model.dart';
import '../../../home/domain/entities/home_event.dart';


part 'booking.g.dart';

@HiveType(typeId: 0)
class Booking extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  HomeEvent event; // <-- Store full object

  @HiveField(2)
  String name;

  @HiveField(3)
  String email;

  @HiveField(4)
  String phone;

  @HiveField(5)
  List<String> selectedSeats;

  @HiveField(6)
  DateTime bookingDate;

  Booking({
    required this.id,
    required this.event,
    required this.name,
    required this.email,
    required this.phone,
    required this.selectedSeats,
    required this.bookingDate,
  });
}
