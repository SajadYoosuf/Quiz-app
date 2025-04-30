// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:quizify/View/home_page.dart';
// import '../Model/quiz_full_data.dart';
// import '../ViewModel/quiz_page_functions.dart';
// import 'Widget/category_container.dart';
// import 'score_display_page.dart';

// // ignore: must_be_immutable
// class CategoryPage extends StatelessWidget {
//   CategoryPage({super.key});

//   List<QuizCategoryDetails> quizCategoryDetails = [
//     QuizCategoryDetails(
//       quizCategoryName: 'GK',
//       quizCategoryImages: "assets/images/general_knowladge_bg.png",
//       quizCategoryContainercolor: const Color(0xFF896afd),
//     ),
//     QuizCategoryDetails(
//       quizCategoryName: 'Technology',
//       quizCategoryImages: "assets/images/technology.png",
//       quizCategoryContainercolor: const Color(0xFF1a97fd),
//     ),
//     QuizCategoryDetails(
//         quizCategoryName: 'Science',
//         quizCategoryImages: "assets/images/sience.png",
//         quizCategoryContainercolor: const Color(0xFF27cbb1)),
//   ];
//   List<QuizFullData> generalKnowladge = [
//     QuizFullData(
//         question: 'Who was the first President of the United States?',
//         images: 'assets/images/united states.jpg',
//         answer: 'George Washington',
//         option1: 'George Washington',
//         option2: 'Abraham Lincoln',
//         option3: 'Thomas Jefferson',
//         option4: 'John Adams'),
//     QuizFullData(
//         question: 'What is the largest desert in the world?',
//         images: '',
//         answer: 'Antarctic Desert',
//         option1: 'Sahara',
//         option2: 'Gobi',
//         option3: 'Antarctic Desert',
//         option4: 'Kalahari'),
//     QuizFullData(
//         question: 'What is the chemical symbol for water?',
//         images: 'assets/images/chemical_water.jpg',
//         answer: 'H₂O',
//         option1: 'O2',
//         option2: 'H₂O',
//         option3: 'CO2',
//         option4: 'KalahariH2'),
//     QuizFullData(
//         question: 'Who wrote Romeo and Juliet?',
//         images: 'assets/images/romeo_and_julioet.jpg',
//         answer: 'William Shakespeare',
//         option1: ' Charles Dickens',
//         option2: 'William Shakespeare',
//         option3: 'Jane Austen',
//         option4: 'Mark Twain'),
//     QuizFullData(
//         question:
//             'How many players are there in a soccer (football) team on the field at the start of a game?',
//         images: '',
//         answer: '11',
//         option1: '9',
//         option2: '11',
//         option3: '12',
//         option4: '10'),
//     QuizFullData(
//         question: 'What is the square root of 144?',
//         images: 'assets/images/squareroot.jpg',
//         answer: '12',
//         option1: '10',
//         option2: '11',
//         option3: '12',
//         option4: '13'),
//     QuizFullData(
//         question: 'Who is known as the founder of Microsoft?',
//         images: '',
//         answer: 'Bill gates',
//         option1: 'Steve Jobs',
//         option2: 'Bill gates',
//         option3: 'larry page',
//         option4: 'Mark Zukerburg'),
//     QuizFullData(
//         question:
//             'What is the name of the fictional wizarding school in the Harry Potter series?',
//         images: '',
//         answer: 'Hogwarts',
//         option1: 'Beauxbatons',
//         option2: 'Durmstrang',
//         option3: 'Ilvermorny',
//         option4: 'Hogwarts'),
//     QuizFullData(
//         question: 'Which country will host the 2024 Summer Olympics?',
//         images: 'assets/images/olympics.jpg',
//         answer: 'France',
//         option1: 'Japan',
//         option2: 'France',
//         option3: 'Austraila',
//         option4: 'Usa'),
//     QuizFullData(
//         question: 'What is the closest planet to the Sun?',
//         images: 'assets/images/redplanet.jpeg',
//         answer: 'Mercury',
//         option1: 'Venus',
//         option2: 'Earth',
//         option3: 'Mercury',
//         option4: 'Mars'),
//   ];

//   List<QuizFullData> technology = [
//     QuizFullData(
//         question:
//             'Which programming language is primarily used for Android app development?',
//         images: 'assets/images/Andriod-Programming-Languages.png',
//         answer: 'Kotlin',
//         option1: 'Swift',
//         option2: 'Python',
//         option3: 'Kotlin',
//         option4: 'Ruby'),
//     QuizFullData(
//         question: 'Who is known as the father of the computer?',
//         images: '',
//         answer: 'Charles Babbage',
//         option1: 'Alan Turing',
//         option2: 'Charles Babbage',
//         // option3: 'im Berners-Lee',
//         option4: 'John von Neumann'),
//     QuizFullData(
//         question: 'What does "HTTP" stand for?',
//         images: 'assets/images/http.jpg',
//         answer: 'HyperText Transfer Protocol',
//         option1: 'HyperText Transfer Protocol',
//         option2: 'High Transmission Protocol',
//         option3: 'Hyperlink Text Protocol',
//         option4: 'Hosting Transfer Protocol'),
//     QuizFullData(
//         question: 'Which company developed the TensorFlow framework?',
//         images: '',
//         answer: 'Google',
//         option1: 'Amazon',
//         option2: 'Microsoft',
//         option3: 'Google',
//         option4: 'IBM'),
//     QuizFullData(
//         question: 'What does GUI stand for in computing?',
//         images: '',
//         answer: 'Graphical User Interface',
//         option1: 'Graphics User Interface',
//         option2: 'General User Input',
//         option3: 'Global Utility Interface',
//         option4: 'Graphical User Interface'),
//     QuizFullData(
//         question: 'Which of the following is NOT an operating system?',
//         images: '',
//         answer: 'Oracle',
//         option1: 'Linux',
//         option2: 'Windows',
//         option3: 'Oracle',
//         option4: 'macOS'),
//     QuizFullData(
//         question:
//             'What is the primary purpose of an API in software development?',
//         images: '',
//         answer: 'Allowing applications to communicate',
//         option1: 'Designing user interfaces',
//         option2: 'Providing data encryption',
//         option3: 'Allowing applications to communicate',
//         option4: 'Debugging applications'),
//     QuizFullData(
//         question: 'What technology is commonly associated with blockchain?',
//         images: 'assets/images/blockchain.jpg',
//         answer: 'Cryptocurrencies',
//         option1: 'Virtual Reality',
//         option2: 'Cryptocurrencies',
//         option3: 'Cloud Computing',
//         option4: 'IoT (Internet of Things)'),
//     QuizFullData(
//         question: 'In which year was the World Wide Web (WWW) invented?',
//         images: 'assets/images/www.jpg',
//         answer: '1989',
//         option1: '1985',
//         option2: '1989',
//         option3: '1991',
//         option4: '1995'),
//     QuizFullData(
//         question: 'What does AI stand for?',
//         images: 'assets/images/ai.jpg',
//         answer: 'Artifical Intelligence',
//         option1: 'Artificial Information',
//         option2: 'Automated Intelligence',
//         option3: 'Artifical Intelligence',
//         option4: ' Advanced Innovation'),
//   ];

//   List<QuizFullData> science = [
//     QuizFullData(
//         question: 'What is the chemical symbol for water?',
//         images: 'assets/images/chemical_water.jpg',
//         answer: 'H20',
//         option1: 'O₂',
//         option2: 'H20',
//         option3: 'CO₂',
//         option4: 'H₂'),
//     QuizFullData(
//         question: 'Which planet is known as the "Red Planet"?',
//         images: 'assets/images/redplanet.jpeg',
//         answer: 'Mars',
//         option1: 'Venus',
//         option2: 'Mars',
//         option3: 'Jupiter',
//         option4: 'Saturn'),
//     QuizFullData(
//         question: 'What gas do plants absorb during photosynthesis?',
//         images: 'assets/images/photosynthesis.jpg',
//         answer: 'Carbon Dioxide',
//         option1: 'Oxygen',
//         option2: 'Carbon Dioxide',
//         option3: 'Nitrogen',
//         option4: 'Hydrogen'),
//     QuizFullData(
//         question: 'What is the speed of light in a vacuum?',
//         images: 'assets/images/vaccum.jpg',
//         answer: '299,792 km/s',
//         option1: '150,000 km/s',
//         option2: '299,792 km/s',
//         option3: '1,000,000 km/s',
//         option4: '500,000 km/s'),
//     QuizFullData(
//         question: 'Who proposed the theory of relativity?',
//         images: 'assets/images/relativity.jpg',
//         answer: 'Albert Einstein',
//         option1: 'Isaac Newton',
//         option2: 'Albert Einstein',
//         option3: 'Nikola Tesla',
//         option4: 'Galileo Galilei'),
//     QuizFullData(
//         question: 'What is the main element found in the Earth\'s core?',
//         images: 'assets/images/earth core.png',
//         answer: 'Iron',
//         option1: 'Nickel',
//         option2: 'Iron',
//         option3: 'Carbon',
//         option4: 'Magnesium'),
//     QuizFullData(
//         question: 'Which blood cells help fight infection in the human body?',
//         images: '',
//         answer: 'White Blood Cells',
//         option1: 'Red Blood Cells',
//         option2: 'Platelets',
//         option3: 'White Blood Cells',
//         option4: 'Plasma'),
//     QuizFullData(
//         question: 'What is the most abundant gas in the Earth\'s atmosphere?',
//         images: 'assets/images/gas.jpg',
//         answer: 'Nitrogen',
//         option1: 'Oxygen',
//         option2: 'Carbon Dioxide',
//         option3: 'Nitrogen',
//         option4: 'Hydrogen'),
//     QuizFullData(
//         question: 'Which part of the cell is known as the "powerhouse"?',
//         images: 'assets/images/cell.png',
//         answer: 'Mitochondria',
//         option1: 'Nucleus',
//         option2: 'Ribosome',
//         option3: 'Mitochondria',
//         option4: 'Golgi Apparatus'),
//     QuizFullData(
//         question: 'What is the SI unit of force?',
//         images: '',
//         answer: 'Newton',
//         option1: 'Newton',
//         option2: 'Joule',
//         option3: 'Pascal',
//         option4: 'Watt'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     var quizPageFunctions = Provider.of<QuizPageFunctions>(context);
//     quizPageFunctions.recieveDataFromSharedPreference();
//     var size = MediaQuery.of(context).size;
//     var width = size.width;
//     var height = size.height;
//     return WillPopScope(
//       onWillPop: () {
//         Navigator.push(
//             // ignore: use_build_context_synchronously
//             context,
//             MaterialPageRoute(builder: (context) => const HomePage()));
//         return Future.value(true);
//       },
//       child: Scaffold(
//         backgroundColor: const Color(0xFF1f1147),
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Color.fromARGB(255, 240, 240, 242),
//             ),
//             onPressed: () {
//               Navigator.push(
//                   // ignore: use_build_context_synchronously
//                   context,
//                   MaterialPageRoute(builder: (context) => const HomePage()));
//             },
//           ),
//           backgroundColor: const Color(0xFF1f1147),
//           centerTitle: true,
//           title: const Text(
//             "educational quiz",
//             style: TextStyle(
//                 color: Color(0xFF32c8ad), fontWeight: FontWeight.bold),
//           ),
//         ),
//         body: Column(
//           children: [
//             quizPageFunctions.categoryHistory.isEmpty
//                 //for checking recent score is empty true is displaying blank container or false displaying the score board
//                 ? GestureDetector(
//                     onDoubleTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const ScoreDisplayPage())).then((_) {
//                         quizPageFunctions.recieveDataFromSharedPreference();
//                       });
//                     },
//                     child: Container(
//                       //bank container
//                       margin: EdgeInsets.only(left: width * 0.09),
//                       width: 250,
//                       height: 80,
//                       decoration: BoxDecoration(
//                           color: const Color(0xFF1f1147),
//                           borderRadius: BorderRadius.circular(14)),
//                     ),
//                   )
//                 : GestureDetector(
//                     onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const ScoreDisplayPage())),
//                     child: Container(
//                       //for display recent score
//                       margin: EdgeInsets.only(left: width * 0.05),
//                       width: 250,
//                       height: 85,
//                       decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 56, 3, 245),
//                           borderRadius: BorderRadius.circular(14)),
//                       child: Row(
//                         children: [
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               const Align(
//                                 alignment: Alignment.topCenter,
//                                 child: Text(
//                                   'YOUR RECENT SCORE',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               Text(
//                                 textAlign: TextAlign.start,
//                                 quizPageFunctions.categoryHistory[
//                                     quizPageFunctions.categoryHistory.length -
//                                         1],
//                                 style: const TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 textAlign: TextAlign.right,
//                                 quizPageFunctions.scoreHistory[
//                                     quizPageFunctions.categoryHistory.length -
//                                         1],
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 17,
//                                     color: Colors.white),
//                               ),
//                             ],
//                           ),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: Column(
//                               children: [
//                                 const SizedBox(
//                                   height: 30,
//                                 ),
//                                 const Icon(
//                                   Icons.timer_outlined,
//                                   color: Color.fromARGB(255, 237, 236, 241),
//                                 ),
//                                 Text(
//                                   "${quizPageFunctions.timeHistory[quizPageFunctions.categoryHistory.length - 1]}'s",
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 17,
//                                       color: Colors.white),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//             SizedBox(
//               height: height * 0.09,
//             ),
//             Center(
//               child: categoryContainer(
//                 context,
//                 quizCategoryDetails[0].quizCategoryName,
//                 quizCategoryDetails[0].quizCategoryImages,
//                 quizCategoryDetails[0].quizCategoryContainercolor,
//                 generalKnowladge,
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Center(
//               child: categoryContainer(
//                   context,
//                   quizCategoryDetails[1].quizCategoryName,
//                   quizCategoryDetails[1].quizCategoryImages,
//                   quizCategoryDetails[1].quizCategoryContainercolor,
//                   technology),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Center(
//               child: categoryContainer(
//                   context,
//                   quizCategoryDetails[2].quizCategoryName,
//                   quizCategoryDetails[2].quizCategoryImages,
//                   quizCategoryDetails[2].quizCategoryContainercolor,
//                   science),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
