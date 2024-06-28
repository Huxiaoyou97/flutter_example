class CustomViewModel {
  String? title;
  String? place;
  String? state;
  String? phone;
  String? content;
  String? imageUrl;

  CustomViewModel(
      {this.title,
      this.place,
      this.state,
      this.phone,
      this.content,
      this.imageUrl});

  CustomViewModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    place = json['place'];
    state = json['state'];
    phone = json['phone'];
    content = json['content'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['place'] = place;
    data['state'] = state;
    data['phone'] = phone;
    data['content'] = content;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
