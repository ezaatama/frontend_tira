import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tira_fe/model/member/member_model.dart';
import 'package:tira_fe/model/member/request_member.dart';
import 'package:tira_fe/service/api_service.dart';

part 'data_member_state.dart';

class DataMemberCubit extends Cubit<DataMemberState> {
  final ApiService apiService;
  DataMemberCubit(this.apiService) : super(DataMemberInitial());

  Future<void> fetchMembers() async {
    emit(DataMemberLoading());
    try {
      final response = await apiService.getAllMember();
      print('👤 Member data: ${response.data}');

      if (response.success && response.data != null) {
        print('✅ Successful number of member: ${response.data!.length}');

        emit(DataMemberLoaded(response.data!));
      } else {
        emit(DataMemberError(response.error ?? 'Failed to fetch members'));
      }
    } catch (e) {
      emit(DataMemberError(e.toString()));
    }
  }

  Future<void> detailMember(String id) async {
    emit(DataMemberDetail());
    try {
      final response = await apiService.getMemberById(id);

      if (response.success && response.data != null) {
        emit(DataMemberDetailSuccess(response.message, response.data!));
      } else {
        emit(
          DataMemberDetailError(response.error ?? 'Failed to detail member'),
        );
      }
    } catch (e) {
      emit(DataMemberDetailError(e.toString()));
    }
  }

  Future<void> createMember(CreateMemberRequest payload) async {
    emit(DataMemberCreating());
    try {
      final response = await apiService.createMember(payload);

      if (response.success && response.data != null) {
        emit(DataMemberCreateSuccess(response.message, response.data!));
      } else {
        emit(
          DataMemberCreateError(response.error ?? 'Failed to create member'),
        );
      }
    } catch (e) {
      emit(DataMemberCreateError(e.toString()));
    }
  }

  Future<void> updateMember(String id, CreateMemberRequest payload) async {
    emit(DataMemberUpdating());
    try {
      final response = await apiService.updateMember(id, payload);
      if (response.success && response.data != null) {
        emit(DataMemberUpdateSuccess(response.message, response.data!));
      } else {
        emit(
          DataMemberUpdateError(response.error ?? 'Failed to update member'),
        );
      }
    } catch (e) {
      emit(DataMemberUpdateError(e.toString()));
    }
  }

  Future<void> deleteMember(String id) async {
    emit(DataMemberDeleting());
    try {
      final response = await apiService.deleteMember(id);
      if (response.success) {
        emit(DataMemberDeleteSuccess(response.message));
      } else {
        emit(
          DataMemberDeleteError(response.error ?? 'Failed to delete member'),
        );
      }
    } catch (e) {
      emit(DataMemberDeleteError(e.toString()));
    }
  }
}
