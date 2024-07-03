class Post {
  String? name;
  String? id;
  String? title;
  String? details;

  Post({ this.id,this.name, this.title, this.details});

  Post.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
    title = json['title'];
    details = json['details'];
  }
}