class Payment_Model {
  String? htmlContent;

  Payment_Model({this.htmlContent});

  Payment_Model.fromJson(Map<String, dynamic> json) {
    htmlContent = json['htmlContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['htmlContent'] = htmlContent;
    return data;
  }
}