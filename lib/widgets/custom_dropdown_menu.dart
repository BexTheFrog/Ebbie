import 'package:flutter/material.dart';

// Widget customizado de dropdown, baseado em Overlay
class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({super.key});

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  // Valor atualmente selecionado no dropdown
  String? selectedValue;

  // Lista de opções disponíveis no dropdown
  final List<String> items = ['Opção 1', 'Opção 2', 'Opção 3'];

  // Responsável por alinhar o dropdown ao botão
  final LayerLink _layerLink = LayerLink();

  // OverlayEntry representa o dropdown aberto sobreposto na tela
  OverlayEntry? _overlayEntry;

  /// Alterna entre abrir e fechar o dropdown
  void _toggleDropdown() {
    if (_overlayEntry != null) {
      // Se já estiver aberto → remove
      _overlayEntry!.remove();
      _overlayEntry = null;
    } else {
      // Se estiver fechado → cria e adiciona no Overlay
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  /// Cria a estrutura visual do dropdown dentro de um OverlayEntry
  OverlayEntry _createOverlayEntry() {
    // Pega o tamanho e posição do widget base (botão principal)
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    // Retorna o dropdown posicionado abaixo do botão
    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height, // logo abaixo do botão
        width: size.width,
        child: Material(
          color: Colors.transparent, // evita fundo sólido
          child: Container(
            // Caixa do dropdown
            decoration: BoxDecoration(
              color: const Color(0xFF9BC1BB),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(color: const Color(0xFF9BC1BC), width: 2),
            ),
            // Lista de opções
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: items.map((item) {
                final bool isSelected = item == selectedValue;

                return InkWell(
                  // Ao clicar em uma opção
                  onTap: () {
                    setState(() {
                      selectedValue = item; // atualiza valor selecionado
                    });
                    _toggleDropdown(); // fecha o dropdown
                  },
                  child: Container(
                    // Se for a opção selecionada → fundo branco
                    color: isSelected ? Colors.white : Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Text(
                          item,
                          style: TextStyle(
                            // Texto verde se for selecionado, branco se não
                            color: isSelected
                                ? const Color(0xFF9BC1BB)
                                : Colors.white,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Se o overlay ainda estiver aberto, fecha antes de destruir o widget
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink, // conecta o botão ao dropdown
      child: Container(
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF9BC1BB),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(2),
            topRight: Radius.circular(5),
            topLeft: Radius.circular(5),
          ),
          border: Border.all(color: const Color(0xFF9BC1BC), width: 2),
        ),
        child: Row(
          children: [
            // Área clicável principal
            Expanded(
              child: GestureDetector(
                onTap: _toggleDropdown, // abre/fecha o dropdown
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Texto do filtro ou valor selecionado
                    Text(
                      selectedValue ?? 'Filtro',
                      style: const TextStyle(color: Colors.white),
                    ),
                    // Ícone de filtro
                    const Icon(Icons.filter_list, color: Colors.white),
                  ],
                ),
              ),
            ),
            // Botão "clear" (X) que aparece só se tiver valor selecionado
            if (selectedValue != null) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedValue = null; // limpa seleção
                  });
                },
                child: const Icon(Icons.clear, color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
