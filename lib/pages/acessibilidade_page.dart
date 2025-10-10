import 'package:flutter/material.dart';

class AcessibilidadePage extends StatefulWidget {
  const AcessibilidadePage({super.key});

  @override
  State<AcessibilidadePage> createState() => _AcessibilidadePageState();
}

class _AcessibilidadePageState extends State<AcessibilidadePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(93, 87, 108, 1),
          flexibleSpace: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 50),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 167, 81, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(247, 237, 226, 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 25,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '15',
                            style: TextStyle(
                              color: Color.fromRGBO(233, 167, 81, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 3),
                          Icon(
                            Icons.paid,
                            color: Color.fromRGBO(233, 167, 81, 1),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFDF7E4),
      body: Column(children: []),
    );
  }
}
