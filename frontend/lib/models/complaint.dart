class Complaint {
  String title;
  String description;
  bool? seen;
  bool? fixed;
  String? madeby;
  String? response;
  String? id;

  Complaint(this.title, this.description,
      {this.seen, this.id,this.fixed, this.madeby, this.response});
  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      json['title'],
      json['description'],
      seen: json['seen'],
      fixed: json['fixed'],
      madeby: json['madeby'],
      id: json['_id'],
      response: json['response'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "seen": seen,
      "fixed": fixed,
      "madeby": madeby,
      "id": id,
      "response": response,
    };
  }
}
