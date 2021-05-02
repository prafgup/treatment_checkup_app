import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/Localization/localization_constant.dart';
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
  bool isLoading = true;
  Locale _locale;
  int questionIndex = 0;
  String questionText;
  String hintText;
  String selectedAnswer;
  bool isDelayActive = false;
  int numberOfCorrectAnswers = 0;
  List<Widget> optionList;

  int get numberOfQuestions => widget.questions.length;
@override
void set_question() async {
  _locale = await getLocale()
    ;
  String str_locale=_locale.toString();
      print(_locale);
      if(str_locale.compareTo("en")==0) {
        this.questionText = widget.questions[questionIndex].question;
        hintText="Select the option considering 5 as high and 0 as low";
      }
      else if(str_locale.compareTo("hi")==0) {
        print(widget.questions[questionIndex].question_hi);
        this.questionText = widget.questions[questionIndex].question_hi;
        hintText="5 को उच्च और 0 को निम्न मानकर विकल्प चुनें";
      }
      else if(str_locale.compareTo("pa")==0) {
        this.questionText = widget.questions[questionIndex].question_pa;
        hintText="5 ਨੂੰ ਉੱਚ ਅਤੇ 0 ਨੂੰ ਘੱਟ ਮੰਨਦੇ ਹੋਏ ਵਿਕਲਪ ਦੀ ਚੋਣ ਕਰੋ";
      }

      //else  this.questionText = widget.questions[questionIndex].question;
     // print(questionText);print(_locale);
  setState(() {
    isLoading = false;
  });
}
  @override
  Future<void> initState() {
    super.initState();
    isLoading = true;
    set_question();



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

       _locale=await getLocale();
      //
       setState(() {
        String str_locale=_locale.toString();
        print(_locale);
        if(str_locale.compareTo("en")==0) {
          this.questionText = widget.questions[questionIndex].question;
        }
        else if(str_locale.compareTo("hi")==0) {
          print(widget.questions[questionIndex].question_hi);
          this.questionText = widget.questions[questionIndex].question_hi;
        }
        else if(str_locale.compareTo("pa")==0) {
          this.questionText = widget.questions[questionIndex].question_pa;
        }
        //questionText = widget.questions[questionIndex].question;
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
  Widget build(BuildContext context) {return
    isLoading == true? Container(
        color: Colors.black.withOpacity(0.5),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(child: CircularProgressIndicator(),)):
     Scaffold(
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
                hintText,
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
    List<String> optionsQuestions = ['1','2','3','4','5'];
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