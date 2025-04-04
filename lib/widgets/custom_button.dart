import 'dart:ui';

import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:flutter/cupertino.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Color color;
  final Color textColor;
  final Color? disabledColor;
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final IconData? icon;
  final Color? iconColor;
  final double iconSize;
  final bool isDisabled;
  final bool hasShadow;
  final bool isOutlined;
  final Color? borderColor;
  final double borderWidth;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.onLongPressed,
     required this.color,
     this.textColor = AppColors.text,
    this.disabledColor,
     required this.width,
    required this.height,
     this.borderRadius = 12.0,
     this.fontSize = 13.0,
     this.fontWeight = FontWeight.normal,
    this.icon,
    this.iconColor,
     this.iconSize = 26,
    required this.isDisabled,
    required this.hasShadow,
    required this.isOutlined,
    this.borderColor,
     this.borderWidth = 2, Center? child,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double _scale =1.0;

  void _onTapDown(TapDownDetails details){
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details){
    setState(() {
      _scale=1.0;
    });

  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(()=> _scale= 1.0),
      onTap: widget.isDisabled? null: widget.onPressed,
      onLongPress: widget.isDisabled? null: widget.onLongPressed,
      child: Container(width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: widget.isDisabled? widget.disabledColor?? AppColors.btnColor: widget.color,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      border: widget.isOutlined? Border.all(color: widget.borderColor?? AppColors.text, width: widget.borderWidth):null,boxShadow: widget.hasShadow   ? [
          BoxShadow(
            color: AppColors.text.withOpacity(0.4),
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ]
            : [],),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,mainAxisSize: MainAxisSize.min,children: [
          if(widget.icon != null)
            Icon(widget.icon,size: widget.iconSize,color: widget.iconColor?? widget.textColor,),
          if(widget.icon != null) const SizedBox(width: 8,),
          Text(widget.text,style: TextStyle(fontWeight: widget.fontWeight,fontSize: widget.fontSize,color: widget.textColor),)
        ],),
      ),
    );
  }
}
