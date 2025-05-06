import 'dart:convert';

class QuizData {
  final int responseCode;
  final List<Result> results;

  QuizData({
    required this.responseCode,
    required this.results,
  });

  factory QuizData.fromRawJson(String str) =>
      QuizData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuizData.fromJson(Map<String, dynamic> json) => QuizData(
        responseCode: json["response_code"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  final Type type;
  final Difficulty difficulty;
  final Category category;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  Result({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        type: typeValues.map[json["type"]]!,
        difficulty: difficultyValues.map[json["difficulty"]]!,
        category: categoryValues.map[json["category"]]!,
        question: json["question"],
        correctAnswer: json["correct_answer"],
        incorrectAnswers:
            List<String>.from(json["incorrect_answers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "difficulty": difficultyValues.reverse[difficulty],
        "category": categoryValues.reverse[category],
        "question": question,
        "correct_answer": correctAnswer,
        "incorrect_answers": List<dynamic>.from(incorrectAnswers.map((x) => x)),
      };
}

enum Category {
  ART,
  SCIENCE_AMP_NATURE,
  ANIMALS,
  ENTERTAINMENT_BOARD_GAMES,
  ENTERTAINMENT_BOOKS,
  ENTERTAINMENT_CARTOON_AMP_ANIMATIONS,
  ENTERTAINMENT_COMICS,
  SCIENCE_COMPUTERS,
  ENTERTAINMENT_FILM,
  SCIENCE_GADGETS,
  GENERAL_KNOWLEDGE,
  GEOGRAPHY,
  HISTORY,
  ENTERTAINMENT_JAPANESE_ANIME_AMP_MANGA,
  SCIENCE_MATHEMATICS,
  ENTERTAINMENT_MUSIC,
  MYTHOLOGY,
  POLITICS,
  SPORTS,
  VEHICLES,
  ENTERTAINMENT_VIDEO_GAMES
}

final categoryValues = EnumValues({
  "Art": Category.ART,
  "Science &amp; Nature": Category.SCIENCE_AMP_NATURE,
  "Animals": Category.ANIMALS,
  "Entertainment: Board Games": Category.ENTERTAINMENT_BOARD_GAMES,
  "Entertainment: Books": Category.ENTERTAINMENT_BOOKS,
  "Entertainment: Cartoon &amp; Animations":
      Category.ENTERTAINMENT_CARTOON_AMP_ANIMATIONS,
  "Entertainment: Comics": Category.ENTERTAINMENT_COMICS,
  "Science: Computers": Category.SCIENCE_COMPUTERS,
  "Entertainment: Film": Category.ENTERTAINMENT_FILM,
  "Science: Gadgets": Category.SCIENCE_GADGETS,
  "General Knowledge": Category.GENERAL_KNOWLEDGE,
  "Geography": Category.GEOGRAPHY,
  "History": Category.HISTORY,
  "Entertainment: Japanese Anime &amp; Manga":
      Category.ENTERTAINMENT_JAPANESE_ANIME_AMP_MANGA,
  "Science: Mathematics": Category.SCIENCE_MATHEMATICS,
  "Entertainment: Music": Category.ENTERTAINMENT_MUSIC,
  "Mythology": Category.MYTHOLOGY,
  "Politics": Category.POLITICS,
  "Sports": Category.SPORTS,
  "Vehicles": Category.VEHICLES,
  "Entertainment: Video Games": Category.ENTERTAINMENT_VIDEO_GAMES
});

enum Difficulty { EASY, HARD, MEDIUM }

final difficultyValues = EnumValues({
  "easy": Difficulty.EASY,
  "hard": Difficulty.HARD,
  "medium": Difficulty.MEDIUM
});

enum Type { BOOLEAN, MULTIPLE, image }

final typeValues =
    EnumValues({"boolean": Type.BOOLEAN, "multiple": Type.MULTIPLE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
