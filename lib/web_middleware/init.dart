part of WindowsMap;
class _HTMLFile{
  static const String _PATH='packages/google_map_windows/web_middleware';
  static const String _JS_PATH='packages/google_map_windows/web_middleware/js';


  static Future<String> loadFresh(String? apiKEY,Map data) async{
    final doccument=parse(await rootBundle.loadString('$_PATH/main.html'));
    doccument.getElementsByTagName('head').first.append(doccument.createElement('script')..text=await rootBundle.loadString('$_JS_PATH/main.js'));
    final googleMapJs= doccument.createElement('script')..attributes['src']=
    apiKEY!=null?'https://maps.googleapis.com/maps/api/js?key=$apiKEY&callback=initMap'
        :'https://maps.googleapis.com/maps/api/js?sensor=false&callback=initMap';

    doccument.body!.append(googleMapJs);

    final mapData=doccument.getElementById('map-data');
    for (final el in data.entries){
      mapData!.attributes['data-${el.key}']=el.value.toString();
    }
    return doccument.outerHtml;
  }
}