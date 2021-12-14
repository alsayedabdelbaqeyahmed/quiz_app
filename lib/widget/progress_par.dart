import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/progress_bar_animation.dart';
import 'package:quiz_app/models/constants.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ProgressParWidget extends StatelessWidget {
  const ProgressParWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.07,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(size.width * 0.5)),
          border: Border.all(
            color: Color(0xff3f4768),
          )),
      child: GetBuilder<ProgParAnimation>(
        init: ProgParAnimation(),
        builder: (controller) => Stack(
          // LayoutBuilder provide us the available space for the conatiner
          // constraints.maxWidth needed for our animation
          // استخدمها هنا علي شان اقدر اتحكم في حجم التشيلد من
          // وبالتالي لما اجي اعمل انميشن اقدر استفيد منها
          children: [
            LayoutBuilder(builder: (ctx, data) {
              return Container(
                // from 0 to 1 takes 60s
                width: data.maxWidth * controller.animation.value,
                decoration: BoxDecoration(
                  gradient: kPrimaryGradient,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 0.5)),
                ),
              );
            }),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${(controller.animation.value * 60).round()} Sec'),
                    WebsafeSvg.asset('assets/icons/clock.svg'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
