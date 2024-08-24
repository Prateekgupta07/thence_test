import '../models/plant_model.dart';

abstract class PlantEvent {}

class FetchPlants extends PlantEvent {}

abstract class PlantState {}

class PlantInitial extends PlantState {}

class PlantLoading extends PlantState {}

class PlantLoaded extends PlantState {
  final List<Plant> plants;

  PlantLoaded(this.plants);
}

class PlantError extends PlantState {
  final String message;

  PlantError(this.message);
}
