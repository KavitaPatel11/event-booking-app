import '../../domain/entities/home_event.dart';

class HomeEventModel {
  final String title;
  final String date;
  final String location;
  final double price;
  final String thumbnail;
  final String description;
  final int id;

  HomeEventModel(
      {required this.id,
      required this.title,
      required this.date,
      required this.location,
      required this.price,
      required this.thumbnail,
      required this.description});

  factory HomeEventModel.fromJson(Map<String, dynamic> json) {
    return HomeEventModel(
        id: json['id'],
        title: json['title'],
        date: json['date'],
        location: json['location'],
        price: json['price'].toDouble(),
        thumbnail: json['thumbnail'],
        description: json['description']);
  }

  HomeEvent toEntity() {
    return HomeEvent(
        id: id,
        title: title,
        date: date,
        location: location,
        price: price,
        thumbnail: thumbnail,
        description: description);
  }
}
