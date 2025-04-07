import '../../domain/entities/home_event.dart';
import '../../domain/repositories/home_event_repository.dart';
import '../models/home_event_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


class HomeEventRepositoryImpl implements HomeEventRepository {
  @override
  Future<List<HomeEvent>> fetchHomeEvents() async {
  
    final String response = await rootBundle.loadString('assets/mock_data/home_events.json');
    final List data = json.decode(response);

  
    return data.map((e) => HomeEventModel.fromJson(e).toEntity()).toList();
  }
}
