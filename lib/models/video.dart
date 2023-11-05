

class Video {
  final String key;
  final String site;
  final String type;
  final String published_at;
  final String id;

  Video(
      {required this.id,
      required this.type,
      required this.key,
      required this.published_at,
      required this.site});

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
        id: json['id'],
        type: json['type'],
        key: json['key'],
        published_at: json['published_at'],
        site: json['site']
    );
  }

  void mo(){

  }

  void so(){

  }

}
