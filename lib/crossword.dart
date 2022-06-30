import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

var crosswordMatrix = [
  [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'b' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'a' , null, null, null, null, null, null, null, '2' , null, null, null, null, null, '3' , null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '4' , 'c' , 'y' , 'b' , 'e' , 'r' , 'h' , 'e' , 'i' , 's' , 't' , '5' , null, null, null, 'd' , null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'k' , null, null, null, null, null, null, null, 'y' , null, 'c' , null, null, null, 'e' , null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '6' , 'w' , 'e' , 'b' , null, null, null, null, null, null, 's' , null, 'h' , null, null, null, 'v' , null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'n' , null, null, null, null, '7' , 'b' , 'o' , 't' , 'n' , 'e' , 't' , null, null, 'o' , null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'd' , null, null, null, null, null, null, null, 'e' , null, 'a' , null, null, null, 'p' , null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '8' , 'i' , 'n' , 'f' , 'o' , 'r' , 'm' , 'a' , 't' , 'i' , 'o' , 'n' , 's' , 'e' , 'c' , 'u' , 'r' , 'i' , 't' , 'y' , null],
  [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '9' , null, null, null, null, null, null, null, null, null, null, null, null, 'a' , null, null, null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'u' , null, null, null, null, '10', 'f' , 'r' , 'o' , 'n' , 't' , 'e' , 'n' , 'd' , null, null, null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'x' , null, null, null, null, null, null, null, null, null, null, null, null, 'm' , null, null, null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, '11', null, null, null, null, null, null, null, null, '12', 'd' , 'a' , 't' , 'a' , null, null, null, null, '13', 'c' , 'a' , 'r' , 'd' , 'i' , 'n' , 'g' , null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, 'h' , null, null, null, null, null, null, null, null, null, 'e' , null, null, null, null, null, null, null, null, null, null, null, null, 'n' , null, null, null, null, null, null, null, '14', null, null, null, null, null, null],
  [null, null, null, null, null, null, 'e' , null, null, null, null, null, '15', null, null, null, 's' , null, '16', 'c' , 'r' , 'y' , 'p' , 't' , 'o' , 'j' , 'a' , 'c' , 'k' , 'i' , 'n' , 'g' , null, null, null, null, '17', 's' , 'e' , 'a' , 'g' , 'u' , 'l' , 'l'],
  [null, null, null, null, null, null, 'l' , null, '18', null, '19', 's' , 'n' , 'i' , 'f' , 'f' , 'i' , 'n' , 'g' , null, null, null, null, null, null, null, null, null, null, 's' , null, null, null, null, null, null, null, 'k' , null, null, null, null, null, null],
  [null, null, null, null, null, null, 'p' , null, 'b' , null, null, null, 'e' , null, null, null, 'g' , null, null, null, null, null, '20', 'p' , 'e' , 'n' , 't' , 'e' , 's' , 't' , null, null, null, '21', null, null, null, 'i' , null, null, null, null, null, null],
  [null, null, null, null, null, '22', 'd' , 'r' , 'o' , 'p' , 'c' , 'a' , 't' , 'c' , 'h' , 'i' , 'n' , 'g' , null, null, null, null, null, null, null, null, null, null, '23', 'r' , '&' , 'd' , null, 'd' , null, null, null, 'm' , null, null, null, null, null, null],
  [null, null, null, null, null, null, 'e' , null, 'o' , null, null, null, 'w' , null, null, null, 'e' , null, null, null, null, '24', null, null, null, null, null, null, null, 'a' , null, null, null, 'i' , null, null, null, 'm' , null, null, null, null, null, null],
  [null, null, null, null, null, null, 's' , '25', 's' , 'e' , 'n' , 'i' , 'o' , 'r' , null, null, 'r' , null, null, null, null, 'w' , null, '26', 'f' , 'a' , 't' , 'c' , 'a' , 't' , null, null, null, 'g' , null, null, null, 'i' , null, null, null, null, null, null],
  [null, null, null, null, null, null, 'k' , null, 't' , null, null, null, 'r' , null, null, null, null, null, null, null, null, 'h' , null, null, null, null, null, null, null, 'o' , '27', 'p' , 'h' , 'i' , 's' , 'h' , 'i' , 'n' , 'g' , null, null, null, null, null],
  [null, null, null, null, null, null, null, null, 'i' , null, null, null, 'k' , null, null, '28', 'e' , 'x' , 'p' , 'l' , 'o' , 'i' , 't' , null, null, null, '29', null, null, 'r' , null, null, null, 't' , null, null, null, 'g' , null, null, null, null, null, null],
  [null, null, null, null, null, null, '30', null, 'n' , null, null, null, 'a' , null, '31', null, null, '32', null, null, null, 't' , null, null, null, null, 'c' , null, null, null, null, null, null, 'a' , null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, 'f' , null, 'g' , null, null, '33', 'r' , 'a' , 'n' , 's' , 'o' , 'm' , 'w' , 'a' , 'r' , 'e' , null, null, null, null, 'y' , null, null, null, null, null, null, 'l' , null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, 'u' , null, null, null, null, null, 'c' , null, 'f' , null, null, 'o' , null, null, null, 'h' , null, null, null, null, 'b' , null, '34', 't' , 'r' , 'o' , 'j' , 'a' , 'n' , null, null, null, null, null, null, null, null, null],
  [null, null, '35', null, null, null, 'l' , null, null, null, null, null, 'h' , null, 't' , null, null, 'd' , null, null, null, 'a' , '36', null, null, null, 'e' , null, null, null, null, null, null, 'r' , null, '37', null, null, null, null, null, null, null, null],
  [null, null, 'm' , null, null, null, 'l' , null, null, null, null, null, 'i' , null, null, null, null, 'e' , null, '38', 's' , 't' , 'a' , 'l' , 'k' , 'e' , 'r' , 'i' , 'n' , 'g' , null, null, null, 't' , null, 'w' , null, null, null, null, null, null, null, null],
  [null, null, 'a' , null, null, null, 's' , null, null, null, null, null, 't' , null, null, null, null, 'r' , null, null, null, null, 'n' , null, null, null, 'b' , null, null, null, null, null, null, 'i' , null, 'o' , null, null, null, null, null, null, null, null],
  [null, null, 'l' , null, null, null, 't' , null, null, null, '39', null, 'e' , null, '40', 's' , 'p' , 'a' , 'm' , null, null, null, 'y' , null, null, null, 'u' , null, null, null, null, null, null, 's' , null, 'r' , null, null, null, null, null, null, null, null],
  [null, null, 'w' , null, '41', null, 'a' , null, null, null, 'm' , null, 'c' , null, null, null, null, 't' , null, null, null, null, 'k' , null, '42', 'c' , 'l' , 'o' , 'u' , 'd' , 's' , 'y' , 's' , 't' , 'e' , 'm' , null, null, null, null, null, null, null, null],
  ['43', 'q' , 'a' , 's' , 'p' , 'e' , 'c' , 'i' , 'a' , 'l' , 'i' , 's' , 't' , null, null, null, null, 'o' , null, null, null, null, 'e' , null, null, null, 'l' , null, '44', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, 'r' , null, 'i' , null, 'k' , null, null, null, 'd' , null, null, null, null, null, null, 'r' , null, '45', 'y' , 'o' , 'y' , 'o' , null, null, 'y' , null, 'b' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, 'e' , null, 'g' , null, null, null, null, null, 'd' , null, null, null, null, null, null, null, null, null, null, null, null, null, '46', 'p' , 'i' , 'r' , 'a' , 'c' , 'y' , null, null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, 'g' , null, null, null, null, null, 'l' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'n' , null, 'c' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, 'y' , null, null, '47', 'i' , 'd' , 'e' , 'n' , 't' , 'i' , 't' , 'y' , 't' , 'h' , 'e' , 'f' , 't' , null, null, null, null, null, 'g' , null, 'k' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, 'b' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'd' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, 'a' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '48', 'p' , 'r' , 'o' , 'g' , 'r' , 'a' , 'm' , 'm' , 'e' , 'r' , null, null, null, null, null, null, null, null],
  [null, '49', 'n' , 'o' , 'c' , 'o' , 'd' , 'e' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'o' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, 'k' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'r' , null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
];

List<Tuple2<int, String>> clues = [
  const Tuple2<int, String>(1, 'Creates the internal and computational logic of a website or web application, as well as other software and information systems'),
  const Tuple2<int, String>(2, 'Looks after servers'),
  const Tuple2<int, String>(3, 'Creates and sets up a development environment (version control system, standardized execution environments, containerized applications) for other programmers\nOR ROUGHLY SPEAKING\nusage of Kubernetes to earn tons of money'),
  const Tuple2<int, String>(4, 'A cyberattack on a financial institution or transactions'),
  const Tuple2<int, String>(5, 'Software that gives you unfair advantage in computer games'),
  const Tuple2<int, String>(6, 'Creates the internal and computational logic of a website or web application, as well as other software and information systems'),
  const Tuple2<int, String>(7, 'A network of PC which have been infected with malware and now controlled as a group while their owners are oblivious about it'),
  const Tuple2<int, String>(8, 'Monitors access to data'),
  const Tuple2<int, String>(9, 'A person who checks the efficiency and usability of a program from user’s point of view'),
  const Tuple2<int, String>(10, 'Creates a part of the web page visible to the user and his main task is to accurately convey in the layout what the designer created, as well as implement user logic'),
  const Tuple2<int, String>(11, 'Provides technical support to PC users regarding the operation of hardware and software, including printing, installation, word processing, email and operating systems'),
  const Tuple2<int, String>(12, 'Analyzes and collects different information about users'),
  const Tuple2<int, String>(13, 'Unauthorized usage of credit cards'),
  const Tuple2<int, String>(14, 'The installation of equipment on an ATM that allows you to read and write bank card data in order to make a copy of it in the future'),
  const Tuple2<int, String>(15, 'A person who is responsible for designing a computer or telecommunications network'),
  const Tuple2<int, String>(16, 'Mining cryptocurrencies using other people\'s resources without the knowledge of their owners'),
  const Tuple2<int, String>(17, 'A micromanager who interrupts works of subordinates way too often'),
  const Tuple2<int, String>(18, 'Getting someone\'s in-game account to reach a higher rank for money'),
  const Tuple2<int, String>(19, 'A process of monitoring and capturing all data packets passing through given network'),
  const Tuple2<int, String>(20, 'An authorized simulated cyberattack on a computer system, performed to evaluate the security of the system'),
  const Tuple2<int, String>(21, 'Makes art using digital technologies'),
  const Tuple2<int, String>(22, 'The practice of registering a domain name once registration has lapsed, immediately after expiry'),
  const Tuple2<int, String>(23, 'Creates improvement concepts for existing products and tests them'),
  const Tuple2<int, String>(24, 'An ethical security hacker'),
  const Tuple2<int, String>(25, 'The highest stage of developer evolution'),
  const Tuple2<int, String>(26, 'IT executive who earns what many believe to be unreasonably high salaries and bonuses (yeah, bobby kotick, we are looking at you, fat Blizzard destroyer)'),
  const Tuple2<int, String>(27, 'An attempt to trick someone into giving information over the internet or by email that would allow someone else to take money from them, for example by taking money out of their bank account'),
  const Tuple2<int, String>(28, 'A computer program, which takes advantage of vulnerabilities of a software to cause unintended behavior'),
  const Tuple2<int, String>(29, 'A form of harassment using electronic means'),
  const Tuple2<int, String>(30, 'Masters a variety of skills and has huge salary'),
  const Tuple2<int, String>(31, 'A non-interchangeable unit of data stored on a blockchain (true crime)'),
  const Tuple2<int, String>(32, 'A person making sure that everyone follows the rules in a chat'),
  const Tuple2<int, String>(33, 'Software designed by criminals to prevent computer users from getting access to their own computer system or files unless they pay money'),
  const Tuple2<int, String>(34, 'A malware that disguises itself as an unharmful software'),
  const Tuple2<int, String>(35, 'Software designed to damage or gain access to a computer system without the user knowing'),
  const Tuple2<int, String>(36, 'Lame full-time system administrator'),
  const Tuple2<int, String>(37, 'A program that spreads itself over a network and infects other computers'),
  const Tuple2<int, String>(38, 'Following a person on the internet'),
  const Tuple2<int, String>(39, 'Too qualified for a junior, but has further career prospects'),
  const Tuple2<int, String>(40, 'Unnecessary to the addressee e-mails, promotional letters, etc., sent by individual firms via the Internet or e-mail'),
  const Tuple2<int, String>(41, 'Process of getting access to a computer system using someone else’s legitimate connection'),
  const Tuple2<int, String>(42, 'Estimates a company\'s database\'s storage and measures the availability of programs for the user'),
  const Tuple2<int, String>(43, 'This is a quality assurance specialist whose activities are aimed at improving the software development process, preventing defects and identifying errors in the product (hilarious)'),
  const Tuple2<int, String>(44, 'A defect in the algorithm that is intentionally embedded in it by the developer and allows unauthorized access to data or remote control of the operating system and the computer as a whole'),
  const Tuple2<int, String>(45, 'A specific type of DoS/DDoS aimed at cloud—hosted applications which use autoscaling'),
  const Tuple2<int, String>(46, 'Practice of illegally downloading, copying and distributing copyrighted digital content (cancel the DMCA~)'),
  const Tuple2<int, String>(47, 'When someone uses other person\'s personal information to steal their identity'),
  const Tuple2<int, String>(48, 'A person whose job is to produce computer programs'),
  const Tuple2<int, String>(49, 'Creates software using GUI applications and WYSIWYG redactors instead of writing regular code')
];

List<Tuple2<int, int>> positions = [
  const Tuple2<int, int>(0, 21),
  const Tuple2<int, int>(2, 29),
  const Tuple2<int, int>(2, 35),
  const Tuple2<int, int>(3, 20),
  const Tuple2<int, int>(3, 31),
  const Tuple2<int, int>(5, 19),
  const Tuple2<int, int>(6, 26),
  const Tuple2<int, int>(8, 23),
  const Tuple2<int, int>(9, 16),
  const Tuple2<int, int>(10, 21),
  const Tuple2<int, int>(12, 6),
  const Tuple2<int, int>(12, 15),
  const Tuple2<int, int>(12, 24),
  const Tuple2<int, int>(13, 37),
  const Tuple2<int, int>(14, 12),
  const Tuple2<int, int>(14, 18),
  const Tuple2<int, int>(14, 36),
  const Tuple2<int, int>(15, 8),
  const Tuple2<int, int>(15, 10),
  const Tuple2<int, int>(16, 22),
  const Tuple2<int, int>(16, 33),
  const Tuple2<int, int>(17, 5),
  const Tuple2<int, int>(17, 28),
  const Tuple2<int, int>(18, 21),
  const Tuple2<int, int>(19, 7),
  const Tuple2<int, int>(19, 23),
  const Tuple2<int, int>(20, 30),
  const Tuple2<int, int>(21, 15),
  const Tuple2<int, int>(21, 26),
  const Tuple2<int, int>(22, 6),
  const Tuple2<int, int>(22, 14),
  const Tuple2<int, int>(22, 17),
  const Tuple2<int, int>(23, 11),
  const Tuple2<int, int>(24, 28),
  const Tuple2<int, int>(25, 2),
  const Tuple2<int, int>(25, 22),
  const Tuple2<int, int>(25, 35),
  const Tuple2<int, int>(26, 19),
  const Tuple2<int, int>(28, 10),
  const Tuple2<int, int>(28, 14),
  const Tuple2<int, int>(29, 4),
  const Tuple2<int, int>(29, 24),
  const Tuple2<int, int>(30, 0),
  const Tuple2<int, int>(30, 28),
  const Tuple2<int, int>(31, 19),
  const Tuple2<int, int>(32, 24),
  const Tuple2<int, int>(34, 7),
  const Tuple2<int, int>(36, 25),
  const Tuple2<int, int>(37, 1)
];

List<List<String?>> getAnswerMatrix() {
  var result = crosswordMatrix;
  for (var i = 0; i < result.length; i++) {
    for (var j = 0; j < result[i].length; j++) {
      if (result[i][j] != null) {
        if ('abcdefghijklmnopqrstuvwxyz&'.contains(result[i][j] ?? '')) {
          result[i][j] = '';
        }
      }
    }
  }
  return result;
}

Widget _buildClue (Tuple2<int, String> clue) {
  return Card(
      child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9381ff),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '${clue.item1}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                    width: 500,
                    child: Text(clue.item2)
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ]
      )
  );
}

List<Widget> _buildClues() {
  List<Widget> res = [];
  for (var clue in clues) {
    res.add(_buildClue(clue));
  }
  return res;
}

var cookedClues = _buildClues();

void main() {
  for (var row = 0; row < crosswordMatrix.length; row += 1) {
    for (var column = 0; column < crosswordMatrix[row].length; column += 1) {
      if (crosswordMatrix[row][column] != null) {
        if (double.tryParse(crosswordMatrix[row][column]!) != null) {
          print('Word #${crosswordMatrix[row][column]}, row $row, column $column.');
        }
      }
    }
  }
}
