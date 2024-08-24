// lib/bloc/plant_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../bloc/plant_events.dart';
import '../models/plant_model.dart';


class PlantBloc extends Bloc<PlantEvent, PlantState> {
  PlantBloc() : super(PlantInitial()) {
    on<FetchPlants>(_onFetchPlants);
  }

  Future<void> _onFetchPlants(FetchPlants event, Emitter<PlantState> emit) async {
    emit(PlantLoading());
    try {
      final response = await http.get(Uri.parse('https://www.jsonkeeper.com/b/6Z9C'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> plantsJson = data['data'];
        final List<Plant> plants = plantsJson.map((json) => Plant.fromJson(json)).toList();
        emit(PlantLoaded(plants));
      } else {
        emit(PlantError('Failed to load plants'));
      }
    } catch (e) {
      emit(PlantError('Failed to load plants'));
    }
  }
}
