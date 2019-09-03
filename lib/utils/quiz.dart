import './question.dart';

class Quiz {
  List<Question> _questions;
  int _currentQuestionIndex = -1;
  int _score = 0;

  Quiz(this._questions) {
    _questions.shuffle();
    _questions.take(10);
  }

  List<Question> get questions => _questions;
  int get length => _questions.length-22;
  int get questionNumber => _currentQuestionIndex+1;
  int get score => _score;

  Question get nextQuestion {
    _currentQuestionIndex++;
    if (_currentQuestionIndex >= length) 
    {
      _questions.shuffle();
      _currentQuestionIndex = 0;
      _score = 0;
    }
    // return null;
    return _questions[_currentQuestionIndex];
  }

  void reset() {
    _questions.shuffle();
    _currentQuestionIndex = -1;
    _score = 0;
  } 

  void answer(bool isCorrect) {
    // print([_currentQuestionIndex, _score, _questions.length]);
    if (isCorrect) _score++;
  }
}