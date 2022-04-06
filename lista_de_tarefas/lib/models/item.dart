class Item {
  String title = "";
  bool? done = false;

  Item({
    required this.title,
    this.done,
  });

  Item.fromJson(Map<String, dynamic> json) {
    title = json['String'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['String'] = this.title;
    data['done'] = this.done;
    return data;
  }
}
