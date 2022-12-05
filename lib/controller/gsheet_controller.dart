import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:stock_management/model/gsheet_model.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using 
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  
  // Google App Script Web URL.
  static const String postUrl = "https://script.google.com/macros/s/AKfycbwq80MOokVEm14m9IslcewP5fUYDEz9O3H67Kwep1cC_O8B3BzFn6Vq04mUP4e94u1_rA/exec";
  static String getUrl ="https://script.google.com/macros/s/AKfycbyuTA7Z7g8lMr1Q7gYegJGGyx2QsT7tnULFMOxtxD62EUM3d425ckUsQwVey7Pq6GF2-Q/exec";
  static String updateUrl = "https://script.google.com/macros/s/AKfycbwOP6fSG5bCLiyfC0xw2wZpkDi9EtkjbJKCU0i7MIoLguy3pCX41mP5v99vth5yAJvBEw/exec";
  // Success Status Message
  static const status = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [postUrl]. On successful response, [callback] is called.
  void submitForm(GoogleSheetModel feedbackForm, void Function(String) callback) async {
    try {
      await http.post(Uri.parse(postUrl), body: feedbackForm.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url!)).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateForm(String oldName, String newName, [String? oldEmail, String? newEmail, String? oldContact, String? newContact,]) async {
    try {
      await http.get(Uri.parse(updateUrl+"?ProductId=$oldName&UpdateValue=$newName"), headers: {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }


   /// Async function which loads feedback from endpoint URL and returns List.
  Future<List<GoogleSheetModel>> getFeedbackList() async {
    return await http.get(Uri.parse(getUrl)).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => GoogleSheetModel.fromJson(json)).toList();
    });
  }


}