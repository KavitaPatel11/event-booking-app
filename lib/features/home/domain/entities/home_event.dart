import 'package:hive/hive.dart';

part 'home_event.g.dart';

@HiveType(typeId: 1) // Assign a unique typeId
class HomeEvent extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final String location;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final String thumbnail;

  @HiveField(6)
  final String description;

  HomeEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.price,
    required this.thumbnail,
    required this.description,
  });
}
