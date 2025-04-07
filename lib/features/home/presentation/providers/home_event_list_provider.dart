import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/sources/home_event_repository_impl.dart';
import '../../domain/entities/home_event.dart';
import '../../domain/repositories/home_event_repository.dart';
import '../../domain/usecases/get_home_events_usecase.dart';

final homeEventRepoProvider = Provider<HomeEventRepository>((ref) {
  return HomeEventRepositoryImpl();
});


final homeEventListViewModelProvider = FutureProvider<List<HomeEvent>>((ref) async {
  final usecase = GetHomeEventsUseCase(ref.read(homeEventRepoProvider));
  return await usecase();
});
