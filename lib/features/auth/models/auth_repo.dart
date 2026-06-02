import 'package:dio/dio.dart';
import 'package:storex/core/constants/const_ip.dart';
import 'package:storex/core/network/api_error.dart';
import 'package:storex/core/network/api_service.dart';
import 'package:storex/features/auth/models/user_model.dart';

class AuthRepo {
  final ApiService _api = ApiService();

  Future<UserModel> register(
  Map<String, dynamic> userData,
) async {
  try {
    print('════════ REGISTER START ════════');
    print('📤 Request Data:');
    print(userData);

    final response = await _api.post(
      'http://${ConstIp().ip}:8000/api/register',
      FormData.fromMap(userData),
    );

    print('📥 Raw Response:');
    print(response);

    if (response is ApiError) {
      print('❌ ApiError returned from ApiService');
      print('❌ Message: ${response.message}');
      throw response;
    }

    if (response is! Map<String, dynamic>) {
      print('❌ Response is not a Map');
      print('❌ Runtime Type: ${response.runtimeType}');

      throw ApiError(
        message: 'Invalid response from server',
      );
    }

    print('✅ Response Keys: ${response.keys.toList()}');

    final userJson = response['user'];

    print('👤 User JSON:');
    print(userJson);

    if (userJson == null) {
      print('❌ user key is NULL');
      print('❌ Full Response: $response');

      throw ApiError(
        message:
            response['message'] ??
            'User data not found',
      );
    }

    final user = UserModel.fromJson(userJson);

    print('✅ User Parsed Successfully');
    print('🆔 ID: ${user.id}');
    print('📧 Email: ${user.email}');
    print('👤 Name: ${user.firstName} ${user.lastName}');
    print('📱 Phone: ${user.phoneNumber}');
    print('🌐 Language: ${user.langPreference}');
    print('🎭 Role: ${user.role}');
    print('════════ REGISTER SUCCESS ════════');

    return user;
  } on DioException catch (e) {
    print('════════ REGISTER DIO ERROR ════════');
    print('❌ Status Code: ${e.response?.statusCode}');
    print('❌ Response Data: ${e.response?.data}');
    print('❌ Request Data: ${e.requestOptions.data}');
    print('═══════════════════════════════════');

    throw ApiError(
      message:
          e.response?.data?['message'] ??
          'Registration failed',
    );
  } catch (e, stackTrace) {
    print('════════ REGISTER ERROR ════════');
    print('❌ Error: $e');
    print('❌ Type: ${e.runtimeType}');
    print('❌ StackTrace:');
    print(stackTrace);
    print('════════════════════════════════');

    if (e is ApiError) rethrow;

    throw ApiError(
      message: 'Registration failed',
    );
  }
}
}