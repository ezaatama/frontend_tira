import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final bool success;
  final String message;
  final T? data;
  final String? error;

  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(Map<String, dynamic>)? fromJsonT,
    T Function(List<dynamic>)? fromJsonListT,
  }) {
    final dataJson = json['data'];

    T? parsedData;
    if (dataJson != null) {
      if (dataJson is List && fromJsonListT != null) {
        parsedData = fromJsonListT(dataJson);
      } else if (dataJson is Map<String, dynamic> && fromJsonT != null) {
        parsedData = fromJsonT(dataJson);
      } else {
        parsedData = dataJson;
      }
    }

    return ApiResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: parsedData,
      error: json['errors'],
    );
  }

  @override
  List<Object?> get props => [success, message, data, error];
}
