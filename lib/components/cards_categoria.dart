import 'package:flutter/material.dart';
import 'package:reprovaca/pages/list_vacas.dart';

import '../models/list_inseminada.dart';
import '../models/list_nocio.dart';
import '../models/list_parida.dart';
import '../models/list_solteira.dart';
import '../pages/list_bezerro.dart';
import '../models/list_prenha.dart';
import '../pages/list_reprodutor.dart';

class CardCategoriar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     
    return ListView(
      
      children: <Widget>[
        
        Container(
         margin: const EdgeInsets.all(6.0),
          width: 146.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Color.fromARGB(255, 115, 115, 115),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 50, 50, 50).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListVacs()),
              );
            },
            style: ButtonStyle(
              mouseCursor: MaterialStateMouseCursor.clickable,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'imagens/fa.jpg',
                    fit: BoxFit.cover,
                   width: 70.0,
                    height: 70.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Vacas',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 36.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          margin: const EdgeInsets.all(6.0),
          width: 146.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Color.fromARGB(255, 115, 115, 115),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 50, 50, 50).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListBezerro()),
              );
            },
            style: ButtonStyle(
              mouseCursor: MaterialStateMouseCursor.clickable,
            ),
            child: Row(
              children: [
             ClipRRect(
  borderRadius: BorderRadius.circular(50),
  child: Image.asset(
    'imagens/bezerro2.png',
    fit: BoxFit.cover,
  width: 70.0,
                    height: 70.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bezerros',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 36.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
         margin: const EdgeInsets.all(6.0),
          width: 146.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Color.fromARGB(255, 115, 115, 115),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 50, 50, 50).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListRepro()),
              );
            },
            style: ButtonStyle(
              mouseCursor: MaterialStateMouseCursor.clickable,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'imagens/reprodutor.jpg',
                    fit: BoxFit.cover,
                  width: 70.0,
                    height: 70.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Reprodutores',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 36.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
         margin: const EdgeInsets.all(6.0),
          width: 146.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Color.fromARGB(255, 115, 115, 115),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 50, 50, 50).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListPrenhaPage()),
              );
            },
            style: ButtonStyle(
              mouseCursor: MaterialStateMouseCursor.clickable,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'imagens/prenha.jpg',
                    fit: BoxFit.cover,
                   width: 70.0,
                    height: 70.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Vacas Prenhas',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 36.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
        margin: const EdgeInsets.all(6.0),
          width: 146.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Color.fromARGB(255, 115, 115, 115),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                 color: const Color.fromARGB(255, 50, 50, 50).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListSolteiras()),
              );
            },
            style: ButtonStyle(
              mouseCursor: MaterialStateMouseCursor.clickable,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'imagens/fa.jpg',
                    fit: BoxFit.cover,
                  width: 70.0,
                    height: 70.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Vacas Solteiras',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 36.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
           margin: const EdgeInsets.all(6.0),
          width: 146.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Color.fromARGB(255, 115, 115, 115),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                 color: const Color.fromARGB(255, 50, 50, 50).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListParidas()),
              );
            },
            style: ButtonStyle(
              mouseCursor: MaterialStateMouseCursor.clickable,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'imagens/parida.jpg',
                    fit: BoxFit.cover,
                   width: 70.0,
                    height: 70.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Vacas Paridas',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 36.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
       
         Container(
        margin: const EdgeInsets.all(6.0),
          width: 146.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Color.fromARGB(255, 115, 115, 115),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                 color: const Color.fromARGB(255, 50, 50, 50).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => List_nocio()),
              );
            },
            style: ButtonStyle(
              mouseCursor: MaterialStateMouseCursor.clickable,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'imagens/solteira.jpg',
                    fit: BoxFit.cover,
                  width: 70.0,
                    height: 70.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Vacas No cio',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 36.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
          
         Container(
        margin: const EdgeInsets.all(6.0),
          width: 146.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Color.fromARGB(255, 115, 115, 115),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                 color: const Color.fromARGB(255, 50, 50, 50).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Listinseminada()),
              );
            },
            style: ButtonStyle(
              mouseCursor: MaterialStateMouseCursor.clickable,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'imagens/prenha.jpg',
                    fit: BoxFit.cover,
                    width: 70.0,
                    height: 70.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Vacas Inseminadas',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 36.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),SizedBox(height: 155,),
      ],
    );
  }
}
