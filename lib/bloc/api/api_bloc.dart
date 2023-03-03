import 'package:sample_flutter/api/repository/api_repository.dart';
import 'package:sample_flutter/bloc/api/api_event.dart';
import 'package:sample_flutter/bloc/api/api_state.dart';
import 'package:bloc/bloc.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiLoading()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<ApiEvent>((event, emit) async {
      try {
        final mList = await _apiRepository.fetchListAirline(event.page, event.size);
        print("reach here: Start to get data");

        if (mList.totalPages != null && mList.totalPassengers != null) {
          emit(ApiLoaded(mList));
          print("reach here: Success to get ${mList.totalPages} data");
        } else {
          emit(const ApiError(404, "Failed to fetch data. data is not found"));
          print("reach here: Failed to get data because of 404");
        }
      } on Exception catch (e) {
        emit(const ApiError(500, "Failed to fetch data. is your device online?"));
        print("reach here: Failed to get data because of 500");
      }
    });
  }
}