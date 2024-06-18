// ignore_for_file: non_constant_identifier_names, unused_import
class Item {

  int id = 0;
  String name = "";
  int point = 0;
  String item_img = "";

   Item();

    Item.FromJson(Map < String, dynamic > json, this.id, this.name, this.point, this.item_img) {
    id = json['id'];
    name = json['name'];
    point = json['point'];
    item_img = json['item_img'];
  }
}