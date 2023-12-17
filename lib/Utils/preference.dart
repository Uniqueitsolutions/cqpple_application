import 'dart:io';

import 'package:bath_service_project/Utils/web_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  // Define your preferences variables
  static UserRole? role;
  static bool allowDeleteAccount = false;
  static SharedPreferences? prefs;
  static String serviceId = "";
  static String apiKey = "";
  static String applicationUserID = "";

  // Define a method for initializing the SharedPreferences instance
  static Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setSavedValues();
  }

  static setSavedValues() {
    var roleStr = prefs!.getString("Role");
    setRoleValue(roleStr);
    setAllowUsers(prefs!);
    serviceId = prefs!.getString("ServiceID") ?? "";
    apiKey = prefs!.getString("apikey") ?? "";
    applicationUserID = prefs!.getString("ApplicationUserID") ?? "";
  }

  static setRoleValue(String? roleStr) {
    if (roleStr != null) {
      if (roleStr == "Plumber") {
        role = UserRole.plumber;
      } else if (roleStr == "Dealer") {
        role = UserRole.dealer;
      } else if (roleStr == "End-User") {
        role = UserRole.endUser;
      } else {
        role = null;
      }
    } else {
      role = null;
    }
  }

  static saveRole(String? role) {
    if (role != null) {
      prefs?.setString("Role", role);
    } else {
      prefs?.remove("Role");
    }
  }

  static saveServiceId(String? id) {
    if (id != null) {
      prefs?.setString("ServiceID", id);
    } else {
      prefs?.remove("ServiceID");
    }
  }

  static saveApplicationUserID(String? id) {
    if (id != null) {
      prefs?.setString("ApplicationUserID", id);
    } else {
      prefs?.remove("ApplicationUserID");
    }
  }

  //ApplicationUserID

  static saveAPIKey(String? apiKey) {
    if (apiKey != null) {
      prefs?.setString("apikey", apiKey);
    } else {
      prefs?.remove("apiKey");
    }
  }

  static setAllowUsers(SharedPreferences pref) async {
    if (Platform.isIOS) {
      var response = await WebServices.getDeleteAccountFlag();
      pref.setBool("allowDeleteAccount", response.status);
    } else {
      pref.setBool("allowDeleteAccount", false);
    }
  }

  static clearPreferences() {
    saveRole(null);
    saveAPIKey(null);
    saveServiceId(null);
    saveApplicationUserID(null);
    role = null;
    apiKey = "";
    serviceId = "";
    applicationUserID = "";
  }
}

enum UserRole { plumber, dealer, endUser }
