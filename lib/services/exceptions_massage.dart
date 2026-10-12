import 'package:dio/dio.dart';

enum RequestType {
  POST,
  GET,
  LOGIN,
  Register,
  History,
  Result,
  Micro,
  CheckOtp,
  SendOtp,
  NewPassword
}

class ApiException {
  List<String> getExceptionMessage(DioException exception, RequestType requestType) {
    final response = exception.response;

    if (exception.type == DioExceptionType.badResponse && response != null) {
      final statusCode = response.statusCode;
      final data = response.data;

      if (statusCode == 400) {
        if (requestType == RequestType.Register) {
          // Check for the non_field_errors array
          if (data is Map<String, dynamic>) {
            if (data['non_field_errors'] != null && data['non_field_errors'] is List) {
              String errorMessage = data['non_field_errors'][0];
              if (errorMessage == 'Password must be at least 8 characters long.') {
                return ["Password Error", "Password must be at least 8 characters long."];
              } else if (errorMessage == 'Password must contain at least one uppercase character.') {
                return ["Password Error", "Password must contain at least one uppercase character."];
              } else if (errorMessage == 'Password must contain at least one special character (@, #, or %).') {
                return ["Password Error", "Password must contain at least one special character (@, #, or %)."];
              }
            }
            // Handle the email already exists case
            if (data['response'] == "This email is already exists, please login!") {
              return ["Account Error", "This email already exists. Please log in."];
            }
          }
        }else if (requestType == RequestType.LOGIN) {
          // Handle login errors
          if (data is Map<String, dynamic>) {
            if (data['message'] == 'Invalid credentials') {
              return ["Login Error", "Your username or password is incorrect. Please try again."];
            } else if (data['error'] == 'please activate your account first') {
              return ["Account Activation", "Please activate your account before logging in."];
            } else if (data['email'] != null && data['email'] is List && data['email'][0] == 'Enter a valid email address.') {
              return ["Email Error", "Please enter a valid email address."];
            }
          }
        }
         else if (requestType == RequestType.CheckOtp) {
          // Handle OTP verification errors
          if (data is Map<String, dynamic>) {
            if (data['non_field_errors'] != null && data['non_field_errors'] is List) {
              String otpError = data['non_field_errors'][0];
              if (otpError == 'Invalid OTP') {
                return ["OTP Error", "The OTP entered is invalid. Please check and try again."];
              } else if (otpError == 'OTP is expired') {
                return ["OTP Error", "The OTP has expired. Please request a new one."];
              }
            }
            if (data['code'] != null && data['code'] is List && data['code'][0] == 'Ensure this field has no more than 4 characters.') {
              return ["Code Error", "The OTP must have 4 characters."];
            }
          }
        }
       else if (requestType == RequestType.SendOtp) {
          // Handle SendOtp errors
          if (data is Map<String, dynamic>) {
            if (data['email'] != null && data['email'] is List && data['email'][0] == 'Enter a valid email address.') {
              return ["Email Error", "Please enter a valid email address."];
            } else if (data['otp_error'] == 'Your recent otp is active yet') {
              return ["OTP Error", "Your recent OTP is still active. Please wait or use the current OTP."];
            } 
          } else if (data == "error: please register first!!!") {
            // Handle the single string error for registration
            return ["Registration Error", "Invalid email, you have not registered with this email before"];
          }
        }
       else if (requestType == RequestType.NewPassword) {
          // Handle NewPassword-related errors
          if (data is Map<String, dynamic>) {
            if (data['non_field_errors'] != null && data['non_field_errors'] is List) {
              String errorMessage = data['non_field_errors'][0];

              if (errorMessage == 'Password must contain at least one special character (@, #, or &).') {
                return ["Password Error", "Password must contain at least one special character (@, #, or &)."];
              } else if (errorMessage == 'Password must be at least 8 characters long.') {
                return ["Password Error", "Password must be at least 8 characters long."];
              } else if (errorMessage == 'Password must contain at least one uppercase character.') {
                return ["Password Error", "Password must contain at least one uppercase character."];
              } else if (errorMessage == 'The password and repeat password must be the same!!!') {
                return ["Password Error", "The password and repeat password must match."];
              } else if (errorMessage == 'Invalid Token') {
                return ["Token Error", "The token is invalid. Please try again."];
              }
            }
          }
        }
        else if(requestType == RequestType.History){
           // Handle History-related errors
          if (data is Map<String, dynamic>) {
            if (data['error'] != null && data['error'] is String) {
              if (data['error'] == 'Please send correct type!!!') {
                return ["History Error", "Please send the correct type!"];
              } else if (data['error'] == 'Please send type attribute!!!') {
                return ["History Error", "Please include the type attribute in the request."];
              }
            }

            // Handle image-related errors
            if (data['image'] != null && data['image'] is List) {
              String imageError = data['image'][0];
              if (imageError == 'No file was submitted.') {
                return ["Image Error", "No file was submitted."];
              } else if (imageError == 'Upload a valid image. The file you uploaded was either not an image or a corrupted image.') {
                return ["Image Error", "The uploaded file is either not a valid image or is corrupted."];
              } else if (imageError == 'The submitted data was not a file. Check the encoding type on the form.') {
                return ["Image Error", "The submitted data was not a file. Please check the form encoding type."];
              }
            }

            // Handle image_parameter and image_diameter errors
            if (data['image_parameter'] != null && data['image_parameter'] is List && data['image_parameter'][0] == 'No file was submitted.') {
              return ["Image Error", "No file was submitted for image parameter."];
            }
            if (data['image_diameter'] != null && data['image_diameter'] is List && data['image_diameter'][0] == 'No file was submitted.') {
              return ["Image Error", "No file was submitted for image diameter."];
            }
          }
        
        }
        return ["Bad Request", "The request contains invalid data."];
      } 
      else if (statusCode == 401) {
       // Handle 401 errors for History
        if (requestType == RequestType.History && data is Map<String, dynamic>) {
          if (data['detail'] == 'Invalid token.') {
            return ["Authentication Error", "Invalid token provided."];
          } else if (data['detail'] == 'Authentication credentials were not provided.') {
            return ["Authentication Error", "No authentication credentials were provided."];
          }
        }
        return ["Unauthorized", "You are not authorized to perform this action."];
      } else if (statusCode == 500) {
        return ["Server Error", "An error occurred on the server. Please try again later."];
      }
    }

    // Handle other DioException types
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ["Timeout Error", "The connection timed out. Please try again."];
      case DioExceptionType.connectionError:
        return ["Connection Error", "Please check your internet connection and try again."];
      case DioExceptionType.cancel:
        return ["Request Cancelled", "The request was cancelled."];
      default:
        return ["Unexpected Error", "An unexpected error occurred. Please try again later."];
    }
  }
}

