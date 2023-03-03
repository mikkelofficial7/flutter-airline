import 'package:equatable/equatable.dart';

abstract class ApiEvent extends Equatable {
  final int page;
  final int size;

  const ApiEvent({
    required this.page,
    required this.size
  });

  @override
  List<Object> get props => [page, size];
}

class GetAirlineList extends ApiEvent {
  final int page;
  final int size;

  const GetAirlineList({
    required this.page,
    required this.size
  }) : super(page: page, size: size);
}