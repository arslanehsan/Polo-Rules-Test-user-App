import 'package:flutter/material.dart';
import 'package:polo_rules_test/Objects/CategoryObject.dart';
import 'package:polo_rules_test/Utils/Router.dart';
import 'package:polo_rules_test/Utils/Toast.dart';

import '../Firebase/FirebaseDatabaseHelper.dart';
import '../Objects/QuestionObject.dart';
import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';
import '../Utils/dimensions.dart';

class SingleCategoryView extends StatefulWidget {
  final CategoryObject category;
  const SingleCategoryView({
    super.key,
    required this.category,
  });

  @override
  State<SingleCategoryView> createState() => _SingleCategoryViewState();
}

class _SingleCategoryViewState extends State<SingleCategoryView> {
  late double screenWidth;
  late double screenHeight;
  late bool web;

  late final CategoryObject category = widget.category;

  List<QuestionObject> _questions = [];

  int index = 1;

  String? selectedAnswer;
  bool answered = false;

  Future<void> _getQuestions() async {
    await FirebaseDatabaseHelper()
        .getQuestions(categoryId: category.id!)
        .then((questionsData) {
      print('Questions Length is ${questionsData.length}');
      setState(() {
        _questions = questionsData;
      });
    });
  }

  @override
  void initState() {
    _getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    web = screenWidth > AppConstents.webSize;
    return Scaffold(
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: screenHeight,
      width: screenWidth,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: category.backgroundColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topBarView(),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Question $index of ${_questions.length}',
              style: TextStyle(
                color: AppThemeColor.dullFontColor,
                fontWeight: FontWeight.w600,
                fontSize: web
                    ? Dimensions.fontSizeLarge * 2
                    : Dimensions.fontSizeLarge,
              ),
            ),
            if (_questions.isNotEmpty)
              web
                  ? Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(web ? 70 : 20.0),
                              child: Text(
                                _questions[index - 1].question!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppThemeColor.pureWhiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: web
                                      ? Dimensions.fontSizeLarge * 2
                                      : Dimensions.fontSizeLarge,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: _answersView(
                            question: _questions[index - 1],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            _questions[index - 1].question!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppThemeColor.pureWhiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.fontSizeLarge,
                            ),
                          ),
                        ),
                        _answersView(
                          question: _questions[index - 1],
                        ),
                      ],
                    ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                InkWell(
                  onTap: () {
                    if (answered && index < _questions.length) {
                      setState(() {
                        selectedAnswer = null;
                        answered = false;
                        index = index + 1;
                      });
                    } else {
                      RouterClass().quizCompleteScreen(
                        context: context,
                        category: category,
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppThemeColor.pureWhiteColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppThemeColor.pureWhiteColor,
                      size: web ? 54 : 34,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _answersView({required QuestionObject question}) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _singleAnsView(
            title: 'Ans A',
            value: AppConstents.answersOptions[0],
            answer: question.ansA!,
            correctAnswer: question.correctAnswer!,
          ),
          _singleAnsView(
            title: 'Ans B',
            value: AppConstents.answersOptions[1],
            answer: question.ansB!,
            correctAnswer: question.correctAnswer!,
          ),
          _singleAnsView(
            title: 'Ans C',
            value: AppConstents.answersOptions[2],
            answer: question.ansC!,
            correctAnswer: question.correctAnswer!,
          ),
          _singleAnsView(
            title: 'Ans D',
            value: AppConstents.answersOptions[3],
            answer: question.ansD!,
            correctAnswer: question.correctAnswer!,
          ),
        ],
      ),
    );
  }

  Widget _singleAnsView({
    required String title,
    required String answer,
    required String value,
    required String correctAnswer,
  }) {
    return InkWell(
      onTap: () {
        ShowToast().showNormalToast(
            msg: value == correctAnswer ? 'Correct!' : 'Wrong!');

        setState(() {
          answered = true;
          selectedAnswer = value;
        });
      },
      child: Container(
        width: web ? screenWidth / 2.5 : screenWidth,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: web ? 30 : 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (answered && selectedAnswer == value)
              ? (answered && selectedAnswer == correctAnswer)
                  ? AppThemeColor.greenColor
                  : Colors.red
              : (answered && value == correctAnswer)
                  ? AppThemeColor.greenColor
                  : AppThemeColor.pureWhiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          answer,
          style: TextStyle(
            color: (answered && selectedAnswer == value)
                ? (answered && selectedAnswer == correctAnswer)
                    ? AppThemeColor.pureWhiteColor
                    : AppThemeColor.pureWhiteColor
                : (answered && value == correctAnswer)
                    ? AppThemeColor.pureWhiteColor
                    : AppThemeColor.dullFontColor,
            fontSize: Dimensions.fontSizeDefault,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _topBarView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppThemeColor.pureWhiteColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.close_rounded,
              color: AppThemeColor.pureWhiteColor,
              size: web ? 54 : 34,
            ),
          ),
        ),
      ],
    );
  }
}
