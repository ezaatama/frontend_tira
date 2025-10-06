import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tira_fe/model/data_reseller/data_reseller_response.dart';
import 'package:tira_fe/service/api_service.dart';

part 'data_reseller_state.dart';

class DataResellerCubit extends Cubit<DataResellerState> {
  final ApiService apiService;
  DataResellerCubit(this.apiService) : super(DataResellerInitial());

  Future<void> fetchDataReseller() async {
    emit(DataResellerLoading());
    try {
      final response = await apiService.getDataSales();

      if (response.success && response.data != null) {
        emit(DataResellerLoaded(response.data!));
      } else {
        emit(DataResellerError(response.error ?? 'Failed to fetch data'));
      }
    } catch (e) {
      emit(DataResellerError(e.toString()));
    }
  }
}
