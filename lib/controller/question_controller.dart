import 'package:get/get.dart';
import 'package:quiz_app/models/questions.dart';

class QuestionController extends GetxController {
  final List<Questions> _question = questions
      .map(
        (item) => Questions(
          id: item['id'],
          options: item['options'],
          question: item['question'],
          answer: item['answer_index'],
        ),
      )
      .toList();

  List<Questions> get question => this._question;

   
}
