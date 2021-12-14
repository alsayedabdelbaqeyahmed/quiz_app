import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/progress_bar_animation.dart';
import 'package:quiz_app/controller/question_controller.dart';
import 'package:quiz_app/models/constants.dart';
import 'package:quiz_app/screens/question.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ProgParAnimation _controller = Get.put(ProgParAnimation());
    QuestionController _qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          WebsafeSvg.asset(
            'assets/icons/bg.svg',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                'Score',
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: kGrayColor),
              ),
              Spacer(),
              Text(
                '${_controller.numOfCorrectAns * 10} / ${_qnController.question.length * 10}',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: kGrayColor),
              ),
              Spacer(),
              TextButton(
                child: Text(
                  'Again',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: kGrayColor),
                ),
                onPressed: () {
                  _controller.startAgain();
                  Future.delayed(
                    Duration(seconds: 2),
                    () {
                      Get.to(QuestionScreen());
                    },
                  );
                },
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
