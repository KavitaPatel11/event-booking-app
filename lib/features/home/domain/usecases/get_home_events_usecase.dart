import '../entities/home_event.dart';
import '../repositories/home_event_repository.dart';

class GetHomeEventsUseCase {
  final HomeEventRepository repository;

  GetHomeEventsUseCase(this.repository);

  Future<List<HomeEvent>> call() => repository.fetchHomeEvents();
}
