part of WindowsMap;

/// a text display on the [Marker]
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
     'color':color._rgba,
      'fontSize':'${fontSize}px',
     'fontWeight':(fontWeight.index*100).toString()
   };
}