import 'package:biblioapp/models/genre.dart';
import 'package:flutter/material.dart';

class GerenTag extends StatefulWidget {
  final Genre genre;
  final Color? backgroundColor;
  final bool initialSelected;
  final void Function(bool isSelected)? onTap;

  GerenTag({
    super.key, 
    required this.genre,
    this.backgroundColor,
    this.initialSelected = false,
    this.onTap
  });

  @override
  State<GerenTag> createState() => _GerenTagState();
}

class _GerenTagState extends State<GerenTag> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.initialSelected;
  }

  Color _getBackgroundColor() {
    if (isSelected) {
      return const Color(0xFFffdd55);
    }
    return widget.backgroundColor ?? const Color(0xFFFDFDFD);
  }

  void _handleTap() {
    setState(() {
      isSelected = !isSelected; // Cambia el estado al hacer tap
    });
    // Ejecutar el callback después de actualizar el estado
    widget.onTap?.call(isSelected);
  }

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Text(widget.genre.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}