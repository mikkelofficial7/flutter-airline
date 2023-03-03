import 'package:equatable/equatable.dart';
import 'package:sample_flutter/model/model_list_airline.dart';

abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object?> get props => [];
}

// like sealed class for state management
class ApiLoading extends ApiState {}

class ApiLoaded extends ApiState {
  final ListAirline listAirline;
  const ApiLoaded(this.listAirline);
}

class ApiError extends ApiState {
  final int? errorCode;
  final String? message;
  const ApiError(this.errorCode, this.message);
}