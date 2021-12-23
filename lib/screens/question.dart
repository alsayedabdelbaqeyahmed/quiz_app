import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/progress_bar_animation.dart';
import 'package:quiz_app/models/constants.dart';
import 'package:quiz_app/controller/question_controller.dart';
import 'package:quiz_app/widget/progress_par.dart';
import 'package:quiz_app/widget/question_card.dart';
import 'package:websafe_svg/websafe_svg.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final questionController = Get.put(QuestionController());
  final controller = Get.put(ProgParAnimation());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    controller.context = context;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            child: Text('Skip'),
            onPressed: controller.nextQuestion,
          )
        ],
      ),
      body: Stack(
        children: [
          WebsafeSvg.asset(
            'assets/icons/bg.svg',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProgressParWidget(),
                  SizedBox(height: size.height * 0.015),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    child: Text.rich(
                      TextSpan(
                        text: 'Question ${controller.questionNumber}',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: kSecondaryColor),
                        children: [
                          TextSpan(
                            text: '/${questionController.question.length}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(color: kSecondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Divider(thickness: 1.5),
                  SizedBox(height: size.height * 0.02),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (value) {
                        controller.updateQuestion(value);
                        setState(() {});
                      },
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller.pageconroller,
                      itemBuilder: (ctx, index) {
                        return QuestionCard(
                          question: questionController.question[index],
                        );
                      },
                      itemCount: questionController.question.length,
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
