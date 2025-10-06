import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tira_fe/model/atasan/atasan_model.dart';
import 'package:tira_fe/model/atasan/request_atasan.dart';
import 'package:tira_fe/service/api_service.dart';

part 'data_atasan_state.dart';

class DataAtasanCubit extends Cubit<DataAtasanState> {
  final ApiService apiService;
  DataAtasanCubit(this.apiService) : super(DataAtasanInitial());

  Future<void> fetchAtasans() async {
    emit(DataAtasanLoading());
    try {
      final response = await apiService.getAllAtasan();
      print('👤 Atasan data: ${response.data}');

      if (response.success && response.data != null) {
        print('✅ Successful number of atasan: ${response.data!.length}');

        emit(DataAtasanLoaded(response.data!));
      } else {
        emit(DataAtasanError(response.error ?? 'Failed to fetch atasan'));
      }
    } catch (e) {
      emit(DataAtasanError(e.toString()));
    }
  }

  Future<void> getAtasanGEPD() async {
    emit(DataGepdLoading());
    try {
      final response = await apiService.getAtasanGEPD();
      print('👤 Atasan data: ${response.data}');

      if (response.success && response.data != null) {
        print('✅ Successful number of atasan: ${response.data!.length}');

        emit(DataGepdLoaded(response.data!));
      } else {
        emit(DataGepdError(response.error ?? 'Failed to fetch atasan'));
      }
    } catch (e) {
      emit(DataGepdError(e.toString()));
    }
  }

  Future<void> detailAtasan(String id) async {
    emit(DataAtasanDetail());
    try {
      final response = await apiService.getAtasanById(id);

      if (response.success && response.data != null) {
        emit(DataAtasanDetailSuccess(response.message, response.data!));
      } else {
        emit(
          DataAtasanDetailError(response.error ?? 'Failed to detail Atasan'),
        );
      }
    } catch (e) {
      emit(DataAtasanDetailError(e.toString()));
    }
  }

  Future<void> createAtasan(CreateAtasanRequest payload) async {
    emit(DataAtasanCreating());
    try {
      final response = await apiService.createAtasan(payload);

      if (response.success && response.data != null) {
        emit(DataAtasanCreateSuccess(response.message, response.data!));
      } else {
        emit(
          DataAtasanCreateError(response.error ?? 'Failed to create Atasan'),
        );
      }
    } catch (e) {
      emit(DataAtasanCreateError(e.toString()));
    }
  }

  Future<void> updateAtasan(String id, UpdateAtasanRequest payload) async {
    emit(DataAtasanUpdating());
    try {
      final response = await apiService.updateAtasan(id, payload);
      if (response.success && response.data != null) {
        emit(DataAtasanUpdateSuccess(response.message, response.data!));
      } else {
        emit(
          DataAtasanUpdateError(response.error ?? 'Failed to update Atasan'),
        );
      }
    } catch (e) {
      emit(DataAtasanUpdateError(e.toString()));
    }
  }

  Future<void> deleteAtasan(String id) async {
    emit(DataAtasanDeleting());
    try {
      final response = await apiService.deleteAtasan(id);
      if (response.success) {
        emit(DataAtasanDeleteSuccess(response.message));
      } else {
        emit(
          DataAtasanDeleteError(response.error ?? 'Failed to delete Atasan'),
        );
      }
    } catch (e) {
      emit(DataAtasanDeleteError(e.toString()));
    }
  }
}
