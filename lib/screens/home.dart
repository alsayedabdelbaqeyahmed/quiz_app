import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/models/constants.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'question.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // first the stack to hold the image and column
      // the column contain data upper image
      // SafeArea to تحجز some space above Column
      //spcer بتقسم الصفحه علي حسب العدد الي موجود منها
      // وتحجز حسب منت محدد في كل مكان
      body: Stack(
        children: [
          Container(
            child: WebsafeSvg.asset('assets/icons/bg.svg', fit: BoxFit.fill),
            width: double.infinity,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 2), // 2 from 6
                  Text(
                    'Let\'s Play Quiz',
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text('Enter your informations below'),
                  Spacer(), // 1 from 6
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      filled: true,
                      fillColor: Color(0xFF1C2341),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () => Get.to(QuestionScreen()),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.all(kDefaultPadding * .75),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gradient: kPrimaryGradient,
                      ),
                      child: Text(
                        "Lets Start Quiz",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  Spacer(flex: 2)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
