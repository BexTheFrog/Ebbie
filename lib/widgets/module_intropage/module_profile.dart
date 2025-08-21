import 'package:flutter/material.dart';

class ModuleProfile extends StatelessWidget {
  const ModuleProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho do módulo
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFED6A5A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  'Desenvolvimento Web',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF4F1BB),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
        
              // SizedBox(height: 5),
        
              // Descrição do módulo
              Container(
                
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(color: Colors.white),
                  child: Text(
                    'Técnico em desenvolvimento Web no SENAC',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D576B),
                      fontSize: 12,
                    ),
                    
                  ),
                
              ),
        
              SizedBox(height: 10),
            ],
          ),
        );
  }
}