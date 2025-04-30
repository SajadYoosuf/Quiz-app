import 'package:flutter/material.dart';

enum NetworkStatus { loading, loaded, error }

int? indexForCategoryFind;
List<Color> containerColors = [
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
];
List<IconData> optionIcons = [
  Icons.radio_button_unchecked_outlined,
  Icons.radio_button_unchecked_outlined,
  Icons.radio_button_unchecked_outlined,
  Icons.radio_button_unchecked_outlined,
];

Map<int, List<String>> achievementMessages = {
  0: [
    "First Try!",
    "Completed your very first quiz",
    "https://img.freepik.com/free-vector/golden-cup-with-arrow-hitting-target-center_3446-458.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  1: [
    "Quiz Explorer",
    "Completed 5 quizzes",
    "https://img.freepik.com/free-vector/milestones-business-projects-concept-illustration_114360-8643.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  2: [
    "Getting the Hang of It",
    "Completed 10 quizzes",
    "https://img.freepik.com/free-vector/flat-design-step-illustration_23-2150122449.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  3: [
    "On a Roll!",
    "Completed 25 quizzes",
    "https://img.freepik.com/free-vector/flat-design-step-illustration_23-2150122446.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  4: [
    "Quiz Pro",
    "Completed 50 quizzes",
    "https://img.freepik.com/free-vector/personal-goals-concept-illustration_114360-5381.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  5: [
    "Master of Quizzes",
    "Completed 100 quizzes",
    "https://img.freepik.com/free-vector/career-path-concept-illustration_114360-14174.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  6: [
    "Quiz Addict",
    "Completed 200 quizzes",
    "https://img.freepik.com/free-vector/gamification-concept-illustration_114360-20404.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  7: [
    "Quiz Marathoner",
    "Completed 10 quizzes in a single day",
    "https://img.freepik.com/free-vector/key-business-success-company-progress-leadership-secret-ambitious-plans-entrepreneur-using-business-opportunities-reaching-top-position_335657-889.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  8: [
    "Fast Finisher",
    "Completed a quiz in under 30 seconds",
    "https://img.freepik.com/free-vector/university-graduation-achievement-higher-education-academic-degree-successful-student-jumping-holding-mortarboard-personal-development_335657-799.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740",
  ],
  9: [
    "Perfect Score",
    "Scored 100% in a quiz",
    "https://img.freepik.com/free-vector/hand-holding-trophy_1284-3981.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  10: [
    "Almost There",
    "Scored exactly 90% in a quiz",
    "https://img.freepik.com/free-vector/hiker-celebrating-success-top-mountain-hand-drawn-vector-background_460848-14953.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  11: [
    "Category Explorer",
    "Tried at least 1 quiz in every category",
    "https://img.freepik.com/free-vector/hand-drawn-flat-design-mba-illustration-illustration_23-2149331623.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  12: [
    "Popular Player",
    "Took part in a community leaderboard",
    "https://img.freepik.com/free-vector/business-leadership-motivation-enterprise-management-setting-goals-achieving-success-ambitious-boss-top-manager-controlling-employees-performance_335657-794.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  13: [
    "Early Adopter",
    "Achieved this during the app’s launch month",
    "https://img.freepik.com/premium-vector/cheerful-leader-man_107173-9289.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ],
  14: [
    "Achievement Unlocked!",
    "Unlocked your 10th achievement",
    "https://img.freepik.com/free-vector/best-worker-specialist-event-sponsorship-employee-victory-branded-competition-marketing-competitive-event-contests-organized-by-brand-concept_335657-118.jpg?uid=R195465143&ga=GA1.1.1683227989.1743741218&semt=ais_hybrid&w=740"
  ]
};
List<Color> colors = [
  Color(0xFF1f1147), // Deep violet
  Color(0xFF6a51dc), // Strong purple
  Color(0xFF3a0ca3), // Indigo blue
  Color(0xFF240046), // Royal deep purple
  Color(0xFF5f0f40), // Dark magenta
];

// List B - icon/text/accent colors to pair with above
final List<Color> colorsIcons = [
  Color(0xFFff5f1f), // Vivid orange
  Color(0xFF00c896), // Deep teal green
  Color(0xFFff0054), // Strong raspberry pink
  Color(0xFFffb000), // Rich amber gold
  Color(0xFF00b4d8),
];

String quizHistoryHiveKey = 'quiz_history';
