/// FeedbackForm is a data class which stores data fields of Feedback.
class GoogleSheetModel {
  String id;
  String name;
  String email;
  String mobileNo;

  GoogleSheetModel(this.id,this.name, this.email, this.mobileNo,);

  factory GoogleSheetModel.fromJson(dynamic json) {
    return GoogleSheetModel("${json['id']}","${json['name']}", "${json['email']}","${json['mobile_no']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'id' : id,
        'name': name,
        'email': email,
        'mobile_no': mobileNo,
      };
}