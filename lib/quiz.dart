import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/final.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool? isCorrect;
  final List<Map<String, dynamic>> questions = [
    {
      'questions': 'Qual é o Tubarão mais violento do mundo?',
      'answers': [
        'Tubarão-branco',
        'Tubarão-martelo',
        'Tubarão-tigre',
        'Tubarão-lixa'
      ],
      'correctAnswer': 'Tubarão-branco'
    },
    {
      'questions': 'Qual é o peixe mais rápido do mundo?',
      'answers': ['Carpa', 'Dânio-tigre', 'Perca sol', 'Agulhão-vela'],
      'correctAnswer': 'Agulhão-vela'
    },
    {
      'questions': 'Qual a Expectativa de vida de uma Baleia-azul?',
      'answers': ['60-70 anos', '70-80 anos', '80-90 anos', '90-100 anos'],
      'correctAnswer': '80-90 anos'
    }
  ];
  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

 void handleAnswer(String answer) {
  bool correct = answer == questions[currentQuestionIndex]['correctAnswer'];
  setState(() {
    selectedAnswer = answer;
    isCorrect = correct;
  });

  if (!correct) {
    // Aguardar um pouco e depois reiniciar o quiz se a resposta estiver errada
    Future.delayed(Duration(milliseconds: 450), () {
      setState(() {
        currentQuestionIndex = 0;
        selectedAnswer = null;
        isCorrect = null;
      });
    });
  } else {
    // Se a resposta estiver correta, aguardar um pouco e ir para a próxima pergunta
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        if (currentQuestionIndex < questions.length - 1) {
          currentQuestionIndex++;
          selectedAnswer = null;
          isCorrect = null;
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Parabens()));
        }
      });
    });
  }
}
  
  
  
  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];
    return Scaffold( 
      appBar: AppBar(title: Text('Quiz Marítimo', style: GoogleFonts.roboto(fontWeight: FontWeight.bold))
      ),
      body: Column(
        children: [
          Container(
            color: Colors.deepPurple[50],
            width: double.infinity,
            height: 400,
          ),
          Wrap(
            children: currentQuestion['answers'].map<Widget>((resposta) {
              bool isSelected = selectedAnswer == resposta;
              Color? buttonColor;
              if (isSelected) {
                buttonColor = isCorrect! ? Colors.green : Colors.red;
              }

              return meuBtn(
                  resposta, () => handleAnswer(resposta), buttonColor);
            }).toList(),
          )
        ]
      ),
    );
  }
}

Widget meuBtn(String resposta, VoidCallback onPressed, Color? color) => Container(
  margin: const EdgeInsets.all(16),
  width: 160,
  child: ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
    child: Text(resposta),
    )
);