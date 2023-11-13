class MyData{
  final String question;
  final String picture;
  final String answer;
  MyData({required this.question, required this.picture, required this.answer});
  factory MyData.fromJson(Map<String, dynamic> json) {
    return MyData(
      question: json['question'],
      picture: json['picture'],
      answer: json['answer'],
    );
  }
}