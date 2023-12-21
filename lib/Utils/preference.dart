import 'dart:io';

import 'package:bath_service_project/Utils/web_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  // Define your preferences variables
  static UserRole? _role;
  static bool _allowDeleteAccount = false;
  static SharedPreferences? _prefs;
  static String _serviceId = "";
  static String _apiKey = "";
  static String _applicationUserID = "";
  static bool _isLogoutAvailable = true;
  static String _mobileNumber = "";

  // Define a method for initializing the SharedPreferences instance
  static Future<void> initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setSavedValues();
  }

  static setSavedValues() {
    var roleStr = _prefs!.getString("Role");
    setRoleValue(roleStr);
    setAllowUsers(_prefs!);
    _serviceId = _prefs!.getString("ServiceID") ?? "";
    _apiKey = _prefs!.getString("apikey") ?? "";
    _applicationUserID = _prefs!.getString("ApplicationUserID") ?? "";
    _isLogoutAvailable = _prefs!.getBool("isLogoutAvailable") ?? true;
    _mobileNumber = _prefs!.getString("Mobile_Number") ?? "";
  }

  static setRoleValue(String? roleStr) {
    if (roleStr != null) {
      if (roleStr == "Plumber") {
        _role = UserRole.plumber;
      } else if (roleStr == "Dealer") {
        _role = UserRole.dealer;
      } else if (roleStr == "End-User") {
        _role = UserRole.endUser;
      } else {
        _role = null;
      }
    } else {
      _role = null;
    }
  }

  static UserRole? getRole() {
    return _role;
  }

  static saveRole(String? role) {
    if (role != null) {
      _prefs?.setString("Role", role);
    } else {
      _prefs?.remove("Role");
    }
    setRoleValue(role);
  }

  static saveServiceId(String? id) {
    if (id != null && id != "null") {
      _prefs?.setString("ServiceID", id);
    } else {
      _prefs?.remove("ServiceID");
    }
    PreferencesManager._serviceId = id ?? "";
  }

  static String getServiceId() {
    return _serviceId;
  }

  static saveApplicationUserID(String? id) {
    if (id != null) {
      _prefs?.setString("ApplicationUserID", id);
    } else {
      _prefs?.remove("ApplicationUserID");
    }
    PreferencesManager._applicationUserID = id ?? "";
  }

  static String getApplicationUserID() {
    return _applicationUserID;
  }
  //ApplicationUserID

  static saveAPIKey(String? apiKey) {
    if (apiKey != null) {
      _prefs?.setString("apikey", apiKey);
    } else {
      _prefs?.remove("apiKey");
    }
    PreferencesManager._apiKey = apiKey ?? "";
  }

  static String getAPIKey() {
    return _apiKey;
  }

  static setAllowUsers(SharedPreferences pref) async {
    if (Platform.isIOS) {
      var response = await WebServices.getDeleteAccountFlag();
      pref.setBool("allowDeleteAccount", response.status);
      PreferencesManager._allowDeleteAccount = response.status;
    } else {
      pref.setBool("allowDeleteAccount", false);
      PreferencesManager._allowDeleteAccount = false;
    }
  }

  static bool getAllowDeleteAccount() {
    return _allowDeleteAccount;
  }

  static saveLogoutAvailable(bool isAllowed) {
    _prefs?.setBool("isLogoutAvailable", isAllowed);
    PreferencesManager._isLogoutAvailable = isAllowed;
  }

  static bool getLogoutAvailable() {
    return _isLogoutAvailable;
  }

  static saveMobileNumber(String? mobile) {
    if (mobile != null) {
      _prefs?.setString("Mobile_Number", mobile);
    } else {
      _prefs?.remove("Mobile_Number");
    }
    PreferencesManager._mobileNumber = mobile ?? "";
  }

  static String getMobileNumber() {
    return _mobileNumber;
  }

  static clearPreferences() {
    saveRole(null);
    saveAPIKey(null);
    saveServiceId(null);
    saveApplicationUserID(null);
    saveMobileNumber(null);
    saveLogoutAvailable(true);
  }
}

enum UserRole { plumber, dealer, endUser }
