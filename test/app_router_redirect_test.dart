import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/app/router/app_router.dart';

void main() {
  group('appRedirect', () {
    test('redirects to setup when not configured', () {
      expect(
        appRedirect(isConfigured: false, location: dashboardLocation),
        setupLocation,
      );
      expect(
        appRedirect(isConfigured: false, location: membersLocation),
        setupLocation,
      );
    });

    test('does not redirect when already on setup and not configured', () {
      expect(
        appRedirect(isConfigured: false, location: setupLocation),
        isNull,
      );
    });

    test('redirects to dashboard when configured and on setup', () {
      expect(
        appRedirect(isConfigured: true, location: setupLocation),
        dashboardLocation,
      );
    });

    test('does not redirect when configured on app routes', () {
      expect(
        appRedirect(isConfigured: true, location: dashboardLocation),
        isNull,
      );
      expect(
        appRedirect(isConfigured: true, location: contributionsLocation),
        isNull,
      );
    });
  });
}

