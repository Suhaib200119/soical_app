class PostModel{
  String? textPost;
  String? urlImagePost;
  String? date;
  int? n_comments;
  int? n_like;
  String? publisher;
  String? uid;
  String? urlImagePublisher;

  PostModel(this.textPost, this.urlImagePost, this.date, this.n_comments,
      this.n_like, this.publisher, this.uid, this.urlImagePublisher);
}