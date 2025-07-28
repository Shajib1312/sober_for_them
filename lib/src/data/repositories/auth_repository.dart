// lib/src/data/repositories/auth_repository.dart
import '../../services/network_service.dart';
import '../../utils/constants.dart';
import '../../utils/storage.dart';
import '../models/api_response.dart';
import '../models/user_model.dart';

class AuthRepository {
  final NetworkService _network = NetworkService();

  Future<ApiResponse<UserModel>> login(String email, String password) async {
    try {
      final result = await _network.post(ApiEndpoints.login, {
        'email': email,
        'password': password,
      });

      if (result['success'] && result['data'] != null) {
        final user =
            UserModel.fromJson(result['data']['user'] ?? result['data']);
        await Storage.saveToken(result['data']['accessToken']);
        await Storage.saveUser(user);
        return ApiResponse(
          success: true,
          statusCode: result['statusCode'],
          message: result['message'],
          data: user,
        );
      } else {
        return ApiResponse(
          success: false,
          statusCode: result['statusCode'],
          message: result['message'],
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse<void>> register(
      String fullName, String email, String password) async {
    try {
      final result = await _network.post(ApiEndpoints.register, {
        'fullName': fullName,
        'email': email,
        'password': password,
      });

      if (result['success']) {
        return ApiResponse(
          success: true,
          statusCode: result['statusCode'],
          message: result['message'],
        );
      } else {
        return ApiResponse(
          success: false,
          statusCode: result['statusCode'],
          message: result['message'],
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse<void>> forgotPassword(String email) async {
    try {
      final result = await _network.post(ApiEndpoints.forgotPassword, {
        'email': email,
      });

      return ApiResponse(
        success: result['success'],
        statusCode: result['statusCode'],
        message: result['message'],
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse<void>> verifyOtp(String email, int otp) async {
    try {
      final result = await _network.put(ApiEndpoints.verifyOtpForgotPassword, {
        'email': email,
        'otp': otp,
      });

      if (result['success']) {
        await Storage.saveOtpEmail(email);
        return ApiResponse(
          success: true,
          statusCode: result['statusCode'],
          message: result['message'],
        );
      } else {
        return ApiResponse(
          success: false,
          statusCode: result['statusCode'],
          message: result['message'],
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse<void>> resetPassword(String email, String password) async {
    try {
      final token = await Storage.getToken();
      final result = await _network.put(
        ApiEndpoints.updatePassword,
        {'email': email, 'password': password},
        token,
      );

      if (result['success']) {
        await Storage.removeOtpEmail();
        return ApiResponse(
          success: true,
          statusCode: result['statusCode'],
          message: result['message'],
        );
      } else {
        return ApiResponse(
          success: false,
          statusCode: result['statusCode'],
          message: result['message'],
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse<UserModel>> getProfile(String token) async {
    try {
      final result = await _network.get(ApiEndpoints.profile, token);
      if (result['success'] && result['data'] != null) {
        final user = UserModel.fromJson(result['data']);
        await Storage.saveUser(user);
        return ApiResponse(
          success: true,
          statusCode: result['statusCode'],
          message: result['message'],
          data: user,
        );
      } else {
        return ApiResponse(
          success: false,
          statusCode: result['statusCode'],
          message: result['message'],
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse<void>> changePassword(
      String oldPass, String newPass, String token) async {
    try {
      final result = await _network.put(
          ApiEndpoints.changePassword,
          {
            'oldPassword': oldPass,
            'newPassword': newPass,
          },
          token);

      return ApiResponse(
        success: result['success'],
        statusCode: result['statusCode'],
        message: result['message'],
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse<UserModel>> updateProfile(
      String fullName, String token) async {
    try {
      final result = await _network.put(
          ApiEndpoints.updateProfile,
          {
            'fullName': fullName,
          },
          token);

      if (result['success'] && result['data'] != null) {
        final user = UserModel.fromJson(result['data']);
        await Storage.saveUser(user);
        return ApiResponse(
          success: true,
          statusCode: result['statusCode'],
          message: result['message'],
          data: user,
        );
      } else {
        return ApiResponse(
          success: false,
          statusCode: result['statusCode'],
          message: result['message'],
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }
}
