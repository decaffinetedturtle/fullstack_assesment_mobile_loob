class AppConfig {
  static const String appName = 'Tealive Careers';
  static const String appVersion = '1.0.0';
  static const String apiBaseUrl = 'http://192.168.150.46:8001/api';

  static const Duration apiTimeout = Duration(seconds: 30);

  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
