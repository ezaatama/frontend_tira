import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tira_fe/model/api_response.dart';
import 'package:tira_fe/model/atasan/atasan_model.dart';
import 'package:tira_fe/model/atasan/request_atasan.dart';
import 'package:tira_fe/model/data_reseller/data_reseller_response.dart';
import 'package:tira_fe/model/member/member_model.dart';
import 'package:tira_fe/model/member/request_member.dart';
import 'package:tira_fe/model/user_model.dart';
import 'package:tira_fe/utils/dio.dart';

class ApiService {
  final Dio _dio = DioClient().dio;

  Future<void> initializeAuthHeader() async {
    final token = await getCurrentToken();
    if (token != null && token.isNotEmpty) {
      DioClient().updateAuthHeader(token);
      print('🔑 Auth header initialized with existing token');
    } else {
      print('⚠️ No existing token found for auth header initialization');
    }
  }

  // Get current token
  Future<String?> getCurrentToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<ApiResponse<User>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/api/login',
        data: {'username': username, 'password': password},
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final apiResponse = ApiResponse<User>.fromJson(
        response.data,
        fromJsonT: (data) => User.fromJson(data),
      );

      if (apiResponse.success && apiResponse.data != null) {
        // Save token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', apiResponse.data!.token!);
        await prefs.setString('username', apiResponse.data!.username);
        await prefs.setString('name', apiResponse.data!.name);
        await prefs.setString('role', apiResponse.data!.role);
      }

      return apiResponse;
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Login failed',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Login failed',
        error: e.toString(),
      );
    }
  }

  Future<ApiResponse<List<Member>>> getAllMember() async {
    try {
      final response = await _dio.get('/api/member');

      return ApiResponse<List<Member>>.fromJson(
        response.data,
        fromJsonListT: (list) => list.map((e) => Member.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;

      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Failed to fetch member data',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to fetch member data',
        error: e.toString(),
      );
    }
  }

  Future<ApiResponse<Member>> getMemberById(String id) async {
    try {
      final response = await _dio.get('/api/member/$id');

      return ApiResponse<Member>.fromJson(
        response.data,
        fromJsonT: (data) => Member.fromJson(data),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Failed to fetch member data',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to fetch member data',
        error: e.toString(),
      );
    }
  }

  Future<ApiResponse<Member>> createMember(CreateMemberRequest payload) async {
    try {
      final response = await _dio.post('/api/member', data: payload.toMap());

      return ApiResponse<Member>.fromJson(
        response.data,
        fromJsonT: (data) => Member.fromJson(data),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Failed to create member',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to create member',
        error: e.toString(),
      );
    }
  }

  Future<ApiResponse<Member>> updateMember(
    String id,
    CreateMemberRequest payload,
  ) async {
    try {
      final response = await _dio.put('/api/member/$id', data: payload.toMap());

      return ApiResponse<Member>.fromJson(
        response.data,
        fromJsonT: (data) => Member.fromJson(data),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Failed to update member',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to update member',
        error: e.toString(),
      );
    }
  }

  Future<ApiResponse<void>> deleteMember(String id) async {
    try {
      final response = await _dio.delete('/api/member/$id');

      return ApiResponse<void>.fromJson(response.data);
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Failed to delete member',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to delete member',
        error: e.toString(),
      );
    }
  }

  Future<ApiResponse<List<Atasan>>> getAllAtasan() async {
    try {
      final response = await _dio.get('/api/atasan');

      return ApiResponse<List<Atasan>>.fromJson(
        response.data,
        fromJsonListT: (list) => list.map((e) => Atasan.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;

      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Failed to fetch atasan data',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to fetch atasan data',
        error: e.toString(),
      );
    }
  }

  Future<ApiResponse<List<Atasan>>> getAtasanGEPD() async {
    try {
      final response = await _dio.get('/api/atasan-gepd');

      return ApiResponse<List<Atasan>>.fromJson(
        response.data,
        fromJsonListT: (list) => list.map((e) => Atasan.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;

      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Failed to fetch gepd data',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to fetch gepd data',
        error: e.toString(),
      );
    }
  }

  Future<ApiResponse<Atasan>> getAtasanById(String id) async {
    try {
      final response = await _dio.get('/api/atasan/$id');

      return ApiResponse<Atasan>.fromJson(
        response.data,
        fromJsonT: (data) => Atasan.fromJson(data),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Failed to fetch atasan data',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to fetch atasan data',
        error: e.toString(),
      );
    }
  }

  Future<ApiResponse<Atasan>> createAtasan(CreateAtasanRequest payload) async {
    try {
      final response = await _dio.post('/api/atasan', data: payload.toMap());

      return ApiResponse<Atasan>.fromJson(
        response.data,
        fromJsonT: (data) => Atasan.fromJson(data),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Failed to create atasan',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to create atasan',
        error: e.toString(),
      );
    }
  }

  Future<ApiResponse<Atasan>> updateAtasan(
    String id,
    UpdateAtasanRequest payload,
  ) async {
    try {
      final response = await _dio.put('/api/atasan/$id', data: payload.toMap());

      return ApiResponse<Atasan>.fromJson(
        response.data,
        fromJsonT: (data) => Atasan.fromJson(data),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Failed to update atasan',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to update atasan',
        error: e.toString(),
      );
    }
  }

  Future<ApiResponse<void>> deleteAtasan(String id) async {
    try {
      final response = await _dio.delete('/api/atasan/$id');

      return ApiResponse<void>.fromJson(response.data);
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Failed to delete atasan',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to delete atasan',
        error: e.toString(),
      );
    }
  }

  Future<ApiResponse<List<DataReseller>>> getDataSales() async {
    try {
      final response = await _dio.get('/api/sales');

      return ApiResponse<List<DataReseller>>.fromJson(
        response.data,
        fromJsonListT: (list) =>
            list.map((e) => DataReseller.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;

      return ApiResponse(
        success: false,
        message: errorData is Map && errorData.containsKey('errors')
            ? errorData['errors']
            : 'Failed to fetch member data',
        error: e.response?.statusMessage ?? e.message,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to fetch member data',
        error: e.toString(),
      );
    }
  }

  Future<File?> downloadSalesExcel() async {
    try {
      final response = await _dio.get(
        '/api/export/sales/excel',
        options: Options(
          responseType: ResponseType.bytes, // Receive as bytes
          headers: {
            'Accept':
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
          },
        ),
      );

      if (response.data != null && response.data is Uint8List) {
        final Uint8List bytes = response.data;

        // Get downloads directory
        final directory = await getDownloadsDirectory();
        if (directory == null) {
          print('Cannot access downloads directory');
          return null;
        }

        // Create file path
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final file = File('${directory.path}/sales_data_$timestamp.xlsx');

        // Write file
        await file.writeAsBytes(bytes);

        print('Excel file saved: ${file.path}');
        print('File size: ${bytes.length} bytes');

        return file;
      } else {
        print('No data received or invalid format');
        return null;
      }
    } on DioException catch (e) {
      print('Dio error downloading Excel: ${e.message}');
      print('Response: ${e.response}');
      return null;
    } catch (e) {
      print('General error downloading Excel: $e');
      return null;
    }
  }
}
