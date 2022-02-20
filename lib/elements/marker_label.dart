part of WindowsMap;


class MarkerLabel{
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  const MarkerLabel({
    required this.text,
    this.color=Colors.black,
    this.fontSize=12,
    this.fontWeight=FontWeight.normal,
});
   Map _toMap()=>{
     'text':text,
     'color':'rgba(${color.red},${color.green},${color.blue},${color.opacity})',
      'fontSize':'${fontSize}px',
     'fontWeight':(fontWeight.index*100).toString()
   };
   String _toJson()=>jsonEncode(_toMap());
}