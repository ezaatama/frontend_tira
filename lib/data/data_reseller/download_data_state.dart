part of 'download_data_cubit.dart';

sealed class DownloadDataState extends Equatable {
  const DownloadDataState();

  @override
  List<Object> get props => [];
}

final class DownloadDataInitial extends DownloadDataState {}

class DownloadDataLoading extends DownloadDataState {}

class DownloadDataSuccess extends DownloadDataState {
  final File file;
  final String filePath;
  final int fileSize;

  const DownloadDataSuccess({
    required this.file,
    required this.filePath,
    required this.fileSize,
  });

  @override
  List<Object> get props => [file, filePath, fileSize];
}

class DownloadDataError extends DownloadDataState {
  final String message;

  const DownloadDataError(this.message);

  @override
  List<Object> get props => [message];
}
