import 'package:hive/hive.dart';
part 'quiz_history.g.dart';

@HiveType(typeId: 0)
class QuizHistory {
  @HiveField(0)
  String? date;
  @HiveField(1)
  int? timeHistory;
  @HiveField(2)
  int? scoreHistory;
  @HiveField(3)
  String? cateogryHistory;
  QuizHistory(
      {required this.cateogryHistory,
      required this.date,
      required this.scoreHistory,
      required this.timeHistory});
}
