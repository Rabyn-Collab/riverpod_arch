

class Post{

  final String title;
  final String  detail;
  final String imageUrl;
  final String imageId;
  final String userId;
  final String id;
  final Like like;
  final List<Comment> comments;


  Post({
    required this.imageUrl,
    required this.id,
    required this.title,
    required this.detail,
    required this.imageId,
    required this.userId,
    required this.comments,
    required this.like
});

}

class Like{
  final int likes;
  final List<String> usernames;
  Like({
    required this.likes,
    required this.usernames
});

  factory Like.fromJson(Map<String, dynamic> json){
    return Like(likes: json['likes'],
        usernames: (json['usernames'] as List).map((e) => e as String).toList()
    );
  }
}


class Comment{
  final String comment;
  final String  username;
  final String  userImage;
  Comment({
    required this.username,
    required this.comment,
    required this.userImage
});

  factory Comment.fromJson(Map<String, dynamic> json){
    return Comment(username: json['username'],
        comment: json['comment'],
        userImage: json['userImage']);
  }


  Map toMap(){
    return {
    'comment': this.comment,
    'username': this.username,
    'userImage': this.userImage
    };
  }
}