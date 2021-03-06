import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/question_controller.dart';
import 'package:quiz_app/models/animated_page-route.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:quiz_app/screens/score_screen.dart';

class ProgParAnimation extends GetxController
    with SingleGetTickerProviderMixin {
  QuestionController controller = Get.put(QuestionController());
  // QuestionController quesCont = Get.put(QuestionController());
  BuildContext context;

  AnimationController _animationController;
  Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  PageController _pageController;
  PageController get pageconroller => _pageController;

  bool _isanswerd = false;
  bool get isanswerd => this._isanswerd;
  int _correctanse;
  int get correctanse => this._correctanse;
  int _selectedAns;
  int get selectedAns => this._selectedAns;
  var _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;
  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    // with SingleGetTickerProviderMixin for the animation process used with vsync
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    // update like setState
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() => update());
    // start the animation and forwarf to the next page when complete
    _animationController.forward().whenComplete(() {
      nextQuestion();
    });
    // to set the pagecontroller for the page changeing
    _pageController = PageController();

    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    _pageController.dispose();

    super.onClose();
  }

  void checkAnswer(int selectIndex, Questions question) {
    _isanswerd = true;
    _correctanse = question.answer;
    _selectedAns = selectIndex;
    if (_correctanse == _selectedAns) {
      _numOfCorrectAns++;
    }

    // to stop the animation after the user check the answer
    _animationController.stop();
    update();
    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(
      Duration(seconds: 1),
      () {
        nextQuestion();
      },
    );
  }

  void nextQuestion() {
    if (_questionNumber.value != controller.question.length) {
      _isanswerd = false;
      _pageController == null
          ? print('error')
          : _pageController.nextPage(
              duration: Duration(seconds: 3), curve: Curves.ease);
      // Reset the counter
      _animationController.reset();
      // Then start it again
      // Once timer is finish go to the next qn so that the oninit only start once
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      Navigator.pushReplacement(
        context,
        AnimatedPageRoute(
          widget: ScoreScreen(),
          beginDx: 0.1,
          beginDy: 0.0,
          endDx: 0,
          endDy: 0,
          curve: Curves.ease,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void updateQuestion(int index) {
    _questionNumber.value = index + 1;
  }

  void startAgain() {
    _numOfCorrectAns = 0;

    _questionNumber.value = 1;
    _isanswerd = false;
    onInit();

    update();
  }
}
