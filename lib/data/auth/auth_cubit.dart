import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tira_fe/model/user_model.dart';
import 'package:tira_fe/service/api_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiService authService;
  AuthCubit(this.authService) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());

    final response = await authService.login(username, password);
    print('👤 User data: ${response.data}');

    if (response.success || response.data != null) {
      print('✅ Login successful, user: ${response.data!.username}');
      emit(AuthAuthenticated(response.data!));
    } else {
      print('❌ Login failed: ${response.error}');
      emit(AuthError(response.error ?? 'Login failed'));
    }
  }
}
