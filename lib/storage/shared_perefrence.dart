import 'package:shared_preferences/shared_preferences.dart';

/// A service class for managing local storage using SharedPreferences.
/// This class provides methods to save, retrieve, and delete data such as tokens, email, and first-time usage status.
class StorageService {
  
  // Keys used for storing and retrieving data from SharedPreferences
  static const String _tokenKey = 'token'; // Key for storing the authentication token
  static const String _urlTokenKey = 'url_token'; // Key for storing the URL token
  static const String _email = 'email'; // Key for storing the user's email
  static const String _isFirstAppLaunch = 'isFirstAppLaunch'; // Key for storing the first-time usage flag

  // Token-related methods

  /// Retrieves the stored authentication token from SharedPreferences.
  /// Returns the token as a String if it exists, otherwise returns null.
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Saves the provided authentication token to SharedPreferences.
  /// [token]: The token to be saved.
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Removes the stored authentication token from SharedPreferences.
  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // URL Token-related methods

  /// Saves the provided URL token to SharedPreferences.
  /// [urlToken]: The URL token to be saved.
  static Future<void> saveUrlToken(String urlToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_urlTokenKey, urlToken);
  }

  /// Retrieves the stored URL token from SharedPreferences.
  /// Returns the URL token as a String if it exists, otherwise returns null.
  static Future<String?> getUrlToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_urlTokenKey);
  }

  /// Removes the stored URL token from SharedPreferences.
  static Future<void> removeUrlToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_urlTokenKey);
  }

  // Email-related methods

  /// Saves the provided email to SharedPreferences.
  /// [email]: The email to be saved.
  static Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_email, email);
  }

  /// Retrieves the stored email from SharedPreferences.
  /// Returns the email as a String if it exists, otherwise returns null.
  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_email);
  }

  // First-time usage methods

  /// Sets the first-time usage flag in SharedPreferences.
  /// [value]: A boolean value indicating whether it's the user's first time using the app.
  static Future<void> firstTimeSet(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstAppLaunch, value);
  }

  /// Retrieves the first-time usage flag from SharedPreferences.
  /// Returns `true` if it's the user's first time (or if the flag is not set), otherwise returns `false`.
  static Future<bool> firstTimeGet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Defaults to `true` if the flag has not been set
    return prefs.getBool(_isFirstAppLaunch) ?? true;
  }
}