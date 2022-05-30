class ShowOrder {
  ShowOrder({
    required this.id,
    required this.fullname,
    required this.phone,
    required this.addresh,
    required this.date,
    required this.image,
    required this.message,
  });

  String id;
  String fullname;
  String phone;
  String addresh;
  String date;
  String image;
  String message;

  factory ShowOrder.fromJson(Map<String, dynamic> json) => ShowOrder(
        id: json["id"],
        fullname: json["fullname"],
        phone: json["phone"],
        addresh: json["addresh"],
        date: json["date"],
        image: json["image"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "phone": phone,
        "addresh": addresh,
        "date": date,
        "image": image,
        "message": message,
      };
}

const ip = 'http://192.168.1.177/';

// const ip = 'http://192.168.100.12/';
