import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:stock_management/model/gsheet2_model.dart';
import 'package:stock_management/model/gsheet_model.dart';


class FormController {
  
  // Google App Script Web URL.
  static const String postUrl = "https://script.google.com/macros/s/AKfycbzR-5x1M2GYrzlaEeT_wSLPdwzEJzFBglQ36rhy6GEUjZmPbRiLYHNXvHjfWjnJrVFL4A/exec";
  static String getUrl ="https://script.google.com/macros/s/AKfycbw0UWSbh_Vv_i-7vYFs4UDNK68JVpMV4tBbQWHphIL9RKgilmQp5jGMFLmaoiw1z2JVjA/exec";
  static String updateAllUrl ="https://script.google.com/macros/s/AKfycbzuAAoZYUg_n3d5O1C3Lj3YWAbP9fTnZfFtEN1dEGGr4dHumASfTjIZPmFH1gYanI8XZw/exec";

  static String postUrl2 = "https://script.google.com/macros/s/AKfycbz8S8NOXVq9FYWbTcJbVddstKK1lEFqRtbjd53G7983bP5vXB030AR2mDM3QoevESWPYQ/exec";
  static String getUrl2 = "https://script.google.com/macros/s/AKfycbwNbjTD8nTMsKoWcHc6lEnEws7iDK-K72HSatRvBtUm3O_3Oe6EmoEhCltj5fwteis9Gg/exec";
  static String updateAllUrl2 ="https://script.google.com/macros/s/AKfycbwBkf7ujiIv2GGEnYmcDMTr2Q4W0J9LEWLmPaAFGyr02aW6gZFLXTwCEo5Op7ExqenJ/exec";


  static const status = "SUCCESS";
  List jsonFeedback=[];
  List jsonFeedback2=[];
  int lastId = 0;
  int lastId2 = 0;

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

  void updateForm(String id,  String oldName, String newName, [String? oldEmail, String? newEmail, String? oldContact, String? newContact,]) async {
    try {
      await http.get(Uri.parse(updateAllUrl+"?Id=$id&DeleteName=$oldName&UpdateName=$newName&DeleteEmail=$oldEmail&UpdateEmail=$newEmail&DeleteContact=$oldContact&UpdateContact=$newContact"), headers: {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<GoogleSheetModel>> getFeedbackList() async {
    return await http.get(Uri.parse(getUrl)).then((response) {
      jsonFeedback = convert.jsonDecode(response.body) as List;
      var data =  jsonFeedback.map((json) => GoogleSheetModel.fromJson(json)).toList();
      lastId = int.parse(data[data.length-1].id);
      return data;
    });
  }


  void submitForm2(SheetModel secondForm, void Function(String) callback) async {
    try {
      await http.post(Uri.parse(postUrl2), body: secondForm.toJson()).then((response) async {
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


  Future<List<SheetModel>> getFeedbackList2() async {
    return await http.get(Uri.parse(getUrl2)).then((response) {
      jsonFeedback2 = convert.jsonDecode(response.body) as List;
      var data =  jsonFeedback2.map((json) => SheetModel.fromJson(json)).toList();
      lastId2 = int.parse(data[data.length-1].id);
      return data;
    });
  }

  void updateForm2(String id,  String oldName, String newName, [String? oldEmail, String? newEmail, String? oldContact, String? newContact,]) async {
    try {
      await http.get(Uri.parse(updateAllUrl2+"?Id=$id&DeleteName=$oldName&UpdateName=$newName&DeleteEmail=$oldEmail&UpdateEmail=$newEmail&DeleteContact=$oldContact&UpdateContact=$newContact"), headers: {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}