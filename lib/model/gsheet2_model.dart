/// FeedbackForm is a data class which stores data fields of Feedback.
class SheetModel {
  String id;
  String fullName;
  String emailAddress;
  String contact;

  SheetModel(this.id, this.fullName, this.emailAddress, this.contact,);

  factory SheetModel.fromJson(dynamic json) {
    return SheetModel("${json['id']}","${json['fullName']}", "${json['emailAddress']}","${json['contact']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'id' : id,
        'fullName': fullName,
        'emailAddress': emailAddress,
        'contact': contact,
      };
}