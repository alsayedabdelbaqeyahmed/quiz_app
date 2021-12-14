import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/progress_bar_animation.dart';

import 'package:quiz_app/models/constants.dart';
import 'package:quiz_app/models/questions.dart';

class QuestionCard extends StatelessWidget {
  final Questions question;

  const QuestionCard({Key key, @required this.question}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProgParAnimation _controller = Get.put(ProgParAnimation());
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
        vertical: size.width * 0.01,
      ),
      padding: EdgeInsets.all(size.width * 0.055),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width * 0.06),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              question.question,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: kBlackColor),
            ),
            SizedBox(height: size.height * 0.03),
            // يعني باستدعيها علي شان اخد ليست من القيم ارجعهم قيمه قيمه
            // علي عدد مرات يساوي الطول الي محدده عندي
            /**Generates a list of values. Creates a list with length positions
             *  and fills it with values created by
             * calling Function for each index */
            ...List.generate(
              question.options
                  .length, // length positions = 4 mean 4 value will back from options
              // Function wich return list of values
              (index) {
                return options(
                    index: index,
                    text: question.options[
                        index], // option1 the option 2 .... then option 4 back to text vari
                    press: () => _controller.checkAnswer(index, question),
                    size: size);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget options({String text, int index, VoidCallback press, Size size}) {
    return GetBuilder<ProgParAnimation>(
      init: ProgParAnimation(),
      builder: (qnController) {
        Color getTheColor() {
          if (qnController.isanswerd) {
            if (index == qnController.correctanse) {
              return kGreenColor;
            } else if (index == qnController.selectedAns &&
                index != qnController.correctanse) {
              return kRedColor;
            }
          }
          return kGrayColor;
        }

        IconData getTheIcon() {
          return getTheColor() == kGreenColor ? Icons.done : Icons.close;
        }

        return InkWell(
          onTap: press,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: getTheColor()),
              borderRadius: BorderRadius.circular(size.width * 0.05),
            ),
            padding: EdgeInsets.all(size.width * 0.04),
            margin: EdgeInsets.only(top: size.height * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${index + 1} $text',
                  style: TextStyle(
                    color: getTheColor(),
                    fontSize: size.width * 0.05,
                  ),
                ),
                Container(
                  width: size.width * 0.07,
                  height: size.width * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * 0.04),
                    border: Border.all(color: getTheColor()),
                    color: getTheColor() == kGrayColor
                        ? Colors.transparent
                        : getTheColor(),
                  ),
                  child: getTheColor() == kGrayColor
                      ? null
                      : Icon(
                          getTheIcon(),
                          size: size.width * 0.06,
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
