import '../entities/home_event.dart';

abstract class HomeEventRepository {
  Future<List<HomeEvent>> fetchHomeEvents();
}
