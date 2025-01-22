import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/quiz_full_data.dart';
import '../ViewModel/quiz_page_functions.dart';
import 'category_page.dart';

class ScoreDisplayPage extends StatelessWidget {
  const ScoreDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var hieght = size.height;
    return Consumer<QuizPageFunctions>(
        builder: (context, quizPageFuncitons, child) {
      quizPageFuncitons.recieveDataFromSharedPreference();
      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: () {
          Navigator.push(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) => CategoryPage()));
          return Future.value(true);
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF1f1147),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1f1147),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 240, 240, 242),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(),
                  ),
                );
              },
            ),
            centerTitle: true,
            title: Text(
              "SCORE CARD",
              style: TextStyle(
                  color: Color.fromARGB(255, 5, 240, 197),
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: quizPageFuncitons.scoreHistory.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: hieght * 0.25),
                  child: Container(
                      height: hieght * 0.90,
                      width: width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        ),
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        'assets/images/score_card_empty_final.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      )),
                )
              : Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/santa_final_output.png',
                        width: 200,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: hieght * 0.66 - 1,
                      width: width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: hieght * 0.63 - 1,
                          width: width - 40,
                          child: ListView.separated(
                              itemCount:
                                  quizPageFuncitons.categoryHistory.length,
                              itemBuilder: (BuildContext context, int index) {
                                int currentIndex =
                                    (index + 1) % container.length;
                                return Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: width * 0.56,
                                  height: hieght * 0.10,
                                  decoration: BoxDecoration(
                                      color: container[currentIndex],
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor:
                                            containerwidgets[currentIndex],
                                        child: Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 40, top: 20),
                                            child: Text(
                                              quizPageFuncitons
                                                  .categoryHistory[index],
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 12, 12, 12),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.30),
                                            child: Text(
                                              quizPageFuncitons
                                                  .scoreHistory[index],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 35,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Expanded(
                                            child: Icon(
                                              Icons.timer_outlined,
                                              color: containerwidgets[
                                                  currentIndex],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${quizPageFuncitons.timeHistory[index]}s",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 20,
                                  )),
                        ),
                      ]),
                    )
                  ],
                ),
        ),
      );
    });
  }
}
