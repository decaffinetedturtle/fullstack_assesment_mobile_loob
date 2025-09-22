class ApiConfig {
  static const String environment = "development";

  static String get baseUrl {
    if (environment == "development") {
      return "http://192.168.150.46:8001";
    } else if (environment == "staging") {
      return "https://staging-api.tealive-careers.com";
    } else {
      return "https://api.tealive-careers.com";
    }
  }

  static String get applicationUrl => "$baseUrl/api/applications";
  static String get applicationStatusUrl => "$baseUrl/api/applications";

  // Endpoint paths (without base URL)
  static const String applicationsEndpoint = '/api/applications';
  static const String applicationStatusEndpoint = '/api/applications';
  static const String applicationSearchEndpoint = '/api/applications/search';

  static const Duration timeout = Duration(seconds: 30);

  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
