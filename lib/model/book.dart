// ignore_for_file: non_constant_identifier_names

class Book {
  int book_id = 0;
  String name = "";
  String book_content = "";
  String img_cover = "";
  dynamic lat = "";
  dynamic long = "";
  var images = [];

  Book();

  Book.FromJson(Map < String, dynamic > json, this.book_id, this.name, this.book_content, this.img_cover, this.lat, this.long, this.images) {
    book_id = json['book_id'];
    name = json['name'];
    book_content = json['book_content'];
    img_cover = json['img_cover'];
    lat = json['lat'];
    long = json['long'];
    images = json['images'];
    
  }

  void removeWhere(bool Function(dynamic p1) param0) {}
}