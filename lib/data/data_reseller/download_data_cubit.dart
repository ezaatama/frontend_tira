import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tira_fe/service/api_service.dart';

part 'download_data_state.dart';

class DownloadDataCubit extends Cubit<DownloadDataState> {
  final ApiService apiService;
  DownloadDataCubit(this.apiService) : super(DownloadDataInitial());

  Future<void> downloadSalesExcel() async {
    try {
      emit(DownloadDataLoading());

      final file = await apiService.downloadSalesExcel();

      if (file == null) {
        emit(
          const DownloadDataError(
            'Failed to download Excel file: No file received',
          ),
        );
        return;
      }

      final fileStat = await file.stat();
      final fileSize = fileStat.size;
      final filePath = file.path;

      print('Excel file saved - Path: $filePath, Size: $fileSize bytes');

      emit(
        DownloadDataSuccess(file: file, filePath: filePath, fileSize: fileSize),
      );
    } catch (e) {
      print('Error downloading Excel: $e');
      emit(DownloadDataError('Failed to download Excel: ${e.toString()}'));
    }
  }
}
