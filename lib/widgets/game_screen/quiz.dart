import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/models/question.dart';
import 'package:treatment_checkup_app/widgets/common/button.dart';
import 'package:treatment_checkup_app/widgets/game_screen/answer_card.dart';
import 'package:treatment_checkup_app/widgets/game_screen/progress_bar.dart';
import 'package:treatment_checkup_app/widgets/game_screen/result_card.dart';
import 'package:treatment_checkup_app/widgets/result_screen/result_screen.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
class Quiz extends StatefulWidget {
  final List<Feedbak> questions;
 final int day;
  Quiz({@required this.questions,this.day});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  static const delayDuration = 1;

  int questionIndex = 0;
  String questionText;
  String selectedAnswer;
  bool isDelayActive = false;
  int numberOfCorrectAnswers = 0;
  List<Widget> optionList;

  int get numberOfQuestions => widget.questions.length;

  @override
  void initState() {
    super.initState();

    questionText = widget.questions[questionIndex].question;
    updateOptions();
  }

  void updateQuiz() async {
    if (selectedAnswer == null) {
      return;
    }

    // String correctAnswer = widget.questions[questionIndex].correctAnswer;

    int status = await UserTypeService().PUpdateFeedback(widget.day.toString(),widget.questions[questionIndex].questionNo.toString(), selectedAnswer);

    setState(() {
      isDelayActive = true;
      updateOptions();
      questionIndex++;
    });

    await Future.delayed(Duration(seconds: delayDuration));

    if (questionIndex < widget.questions.length) {
      setState(() {
        questionText = widget.questions[questionIndex].question;
        selectedAnswer = null;
        isDelayActive = false;
        updateOptions();
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            numberOfCorrectAnswers: numberOfCorrectAnswers,
            numberOfQuestions: numberOfQuestions,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                child: ProgressBar(
                  numberOfAnsweredQuestions: questionIndex,
                  totalNumberOfQuestions: numberOfQuestions,
                ),
              ),
              Text(
                questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Select the option considering 5 as high and 0 as low",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Column(
                children: optionList
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateOptions() {
    optionList = new List<Widget>();
    List<String> optionsQuestions = ['0','1','2','3','4','5'];
    for(var i=0; i<optionsQuestions.length; ++i){
      if(isDelayActive){
        optionList.add(new ResultCard(titleLabel: optionsQuestions[i],
            isCorrect: selectedAnswer!=null && selectedAnswer.toLowerCase()==optionsQuestions[i].toLowerCase()));
      } else {
        optionList.add(new AnswerCard(titleLabel: optionsQuestions[i],
            isSelected: selectedAnswer!=null && selectedAnswer.toLowerCase()==optionsQuestions[i].toLowerCase(),
            onTap: () {
              selectedAnswer=optionsQuestions[i];

              updateQuiz();
            }
        ));
      }
      optionList.add(new SizedBox(
        height:24,
      ));
    }
  }

  void setSelectedAnswer(String text) {
    setState(() {
      selectedAnswer = text;
    });
  }
}