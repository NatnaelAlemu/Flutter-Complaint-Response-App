class Response {
  String title;
  String description;
  String forcomplaint;
  String issuedby;
  bool? seen;
  String? id;

  Response(this.title, this.description, this.issuedby, this.forcomplaint,
      {this.seen,this.id});
  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      json['title'],
      json['description'],
      json['forcomplaint'],
      json['issuedby'],
      seen: json['seen'],
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "forcomplaint": forcomplaint,
      "issuedby": issuedby,
      "seen": seen,
      "id": id,
    };
  }
}
