import 'package:flutter_test/flutter_test.dart';
import 'package:logitracker/core/constant/api_endpoints.dart';

void main() {
  group('ApiEndpoints', () {
    test('should have correct base URL', () {
      expect(ApiEndpoints.baseUrl, contains('api/v1/'));
    });

    test('should have auth endpoints', () {
      expect(ApiEndpoints.signup, 'auth/signup');
      expect(ApiEndpoints.login, 'auth/driver-login');
    });

    test('should have user endpoints', () {
      expect(ApiEndpoints.getUserProfile, 'user/getProfile');
      expect(ApiEndpoints.updateProfile, 'user/updateProfile');
      expect(ApiEndpoints.updatePassword, 'user/changePassword');
    });

    test('should have job endpoints', () {
      expect(ApiEndpoints.getJobs, 'job');
      expect(ApiEndpoints.jobDetails, 'job/getJobById');
    });

    test('should have coordinate endpoints', () {
      expect(ApiEndpoints.updateCoord, 'coordinate/updateCoord');
      expect(ApiEndpoints.getLiveCoord, 'coordinate/getLiveCoord');
      expect(ApiEndpoints.getCoord, 'coordinate/getCoord');
      expect(ApiEndpoints.getAllCoord, 'coordinate/getAllCoord');
    });

    test('should have correct timeouts', () {
      expect(ApiEndpoints.connectionTimeout, const Duration(seconds: 1000));
      expect(ApiEndpoints.recieveTimeout, const Duration(seconds: 1000));
    });
  });
}
