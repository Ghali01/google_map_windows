window.onload=function(e ){
    document.getElementById("h").style.color='red';
};
const EVENT_TYPE='eventType';
function sendDate(event,data){
    window.chrome.webview.postMessage({[EVENT_TYPE]:event,data:data});
}


function dartLog(data){
    sendDate('log',{value:data});

}

let map;
let initNow=false,mapIniteld=false;
let markers= new Map(),polylines=new Map(),polygons=new Map();
const MARKER='marker',POLYLINE='polyline',POLYGON='polygon';
let drawElements={[MARKER]:markers,[POLYLINE]:polylines,[POLYGON]:polygons};
function initMap(){
    if (initNow&&!mapIniteld){
        const mapData=document.getElementById('map-data').dataset;
        map = new google.maps.Map(document.getElementById('map'), {
        center: JSON.parse(mapData.center),
        zoom: parseInt(mapData.zoom),
        fullscreenControl:false,
        zoomControl:false,
        disableDoubleClickZoom:mapData.disabledoublecliczoom=='true',
        minZoom:mapData.minzoom,
        maxZoom:mapData.maxzoom,
      });
      map.addListener('zoom_changed',()=>sendDate('zoomChanged',{zoom:map.getZoom()}));
      map.addListener('center_changed',()=>{
        var loc=map.getCenter();
        loc=new google.maps.LatLng(loc.lat(), loc.lng(), false); 
        sendDate('centerChanged',{latLng:loc});
        });
      map.bounds_changed=()=>sendDate('boundsChanged',map.getBounds());
      map.addListener('click',(e)=>sendDate('click',e.latLng));
      map.addListener('dblclick',(e)=>sendDate('doubleClick',e.latLng));
      map.addListener('contextmenu',(e)=>sendDate('rightClick',e.latLng));
      map.addListener('mousemove',(e)=>sendDate('mouseMove',e.latLng));
      map.addListener('mousedown',(e)=>sendDate('mouseDown',e.latLng));
      map.addListener('mouseup',(e)=>sendDate('mouseUp',e.latLng));
      map.addListener('idle',()=>sendDate('idle'));
      mapIniteld=true;
      sendDate('mapInitialed');

    }
    initNow=true;
}



window.chrome.webview.addEventListener('message', function(e) {
   dartLog("messagereceived: " + JSON.stringify(e.data));
    let msgDate=e.data;
 
    switch(msgDate[EVENT_TYPE]){
        case 'initMap':{
            initNow=true;
            initMap();
        }
        break;
        case 'getZoom':
            sendZoom();
        break;
        case 'setZoom':
            setZoom(msgDate);
        break;
        case 'getCenter':
            sendCenter();
        break;
        case 'setCenter':
            setCenter(msgDate);
        break;
        case 'getBounds':
            sendBounds();
        break;
        case 'fitBounds':
            fitBounds(msgDate);
        break;
        case 'panBy':
            panBy(msgDate);
        break;
        case 'panTo':
            panTo(msgDate);
        break;
        case 'panToBounds':
            panToBounds(msgDate);
        break;
        case 'addMarker':
            addMarker(msgDate);
        break;
        case 'setDrawElementZIndex':
            setDrawElementZIndex(msgDate); 
        break;
        case 'setDrawElementVisible':
            setDrawElementVisible(msgDate); 
        break;
        case 'setDrawElementClickable':
            setDrawElementClickable(msgDate); 
        break;
        case 'setMarkerPosition':
            setMarkerPosition(msgDate); 
        break;
        case 'setMarkerOpacity':
            setMarkerOpacity(msgDate); 
        break;
        case 'setMarkerTitle':
            setMarkerTitle(msgDate); 
        break;
        case 'setMarkerLabel':
            setMarkerLabel(msgDate); 
        break;
        case 'setMarkerIcon':
            setMarkerIcon(msgDate); 
        break;
        case 'removeMarker':
            removeMarker(msgDate); 
        break;      
        case 'addPolyline':
            addPolyline(msgDate); 
        break;
        case 'setPloyEditable':
            setPloyEditable(msgDate);
        break;
        case 'setPloyGeodesic':
            setPloyGeodesic(msgDate);
        break;
        case 'setPolyStrokeColor':
            setPolyStrokeColor(msgDate);
        break;
        case 'setPolyStrokeOpacity':
            setPolyStrokeOpacity(msgDate);
        break;
        case 'setPolyStrokeWeight':
            setPolyStrokeWeight(msgDate);
        break;
        case 'setPolylinePath':
            setPolylinePath(msgDate);
        break;
        case 'removePolyLine':
            removePolyLine(msgDate);
        break;
        case 'addPolygon':
            addPolygon(msgDate);
        break;       
        case 'setPolygonFillColor':
            setPolygonFillColor(msgDate);
        break;
        case 'setPolygonFillOpacity':
            setPolygonFillOpacity(msgDate);
        break;
        case 'setPolygonPaths':
            setPolygonPaths(msgDate);
        break;
        case 'setRectangleBounds':
            setRectangleBounds(msgDate);
        break;
        case 'getRectangleBounds':
            sendRectangleBounds(msgDate);
        break;
        case 'setCircleCenter':
            setCircleCenter(msgDate);
        break;
        case 'setCircleRadius':
            setCircleRadius(msgDate);
        break;
        case 'removePolygon':
            removePolygon(msgDate);
        break;
        
    }


   });

function sendZoom(){
    sendDate('sendZoom',{zoom:map.getZoom()});
}
function setZoom(data){
    map.setZoom(data['data']['zoom']);
}
function sendCenter(){
  
    var loc=map.getCenter();
    loc=new google.maps.LatLng(loc.lat(), loc.lng(), false); 
    sendDate('sendCenter',loc);
}
function setCenter(data){
    map.setCenter(data['data']);
}

function sendBounds(){
    sendDate('sendBounds',map.getBounds())
}

function fitBounds(data){
    map.fitBounds(data['data']);
}
function panBy(data){  
    data=data['data'];
    map.panBy(data['x'],data['y']);
 }

function panTo(data){
     map.panTo(data['data']);
  }
function panToBounds(data) {
    map.panToBounds(data['data']);
 }

 function addMarker(data){


    let id=data['data']['id'];
    delete data['data']['id'];
    data['data']['map']=map;
    let marker= new google.maps.Marker(data['data']);
    marker.addListener('click',(e)=>sendDate('markerClick',{id:id,latlng:e.latLng}));
    marker.addListener('dblclick',(e)=>sendDate('markerDoubleClick',{id:id,latlng:e.latLng}));
    marker.addListener('contextmenu',(e)=>sendDate('markerRightClick',{id:id,latlng:e.latLng}));
    marker.addListener('mousemove',(e)=>sendDate('markerMouseMove',{id:id,latlng:e.latLng}));
    marker.addListener('mousedown',(e)=>sendDate('markerMouseDown',{id:id,latlng:e.latLng}));
    marker.addListener('mouseup',(e)=>sendDate('markerMouseUp',{id:id,latlng:e.latLng}));

    markers.set(id,marker);    
}

function setDrawElementZIndex(data){ 
    const {id,type,zIndex}=data['data'];
    drawElements[type].get(id).setOptions({zIndex:zIndex});
}

function setDrawElementClickable(data){
    const {id,type,clickable}=data['data'];
    drawElements[type].get(id).setOptions({clickable:clickable});

}

function setDrawElementVisible(data){
    const {id,type,visible}=data['data'];
    drawElements[type].get(id).setVisible(visible);
}
function setMarkerPosition(data){
    const {id,latLng}=data['data'];
    markers.get(id).setPosition(latLng);
}

function setMarkerOpacity(data){
    const {id,opacity}=data['data'];
    markers.get(id).setOpacity(opacity);
}
function setMarkerTitle(data){
    const {id,title}=data['data'];
    markers.get(id).setTitle(title);
}


function setMarkerLabel(data){
    const {id,label}=data['data'];
    markers.get(id).setLabel(label);
}
function setMarkerIcon(data){
    const {id,icon}=data['data'];
    markers.get(id).setIcon(icon);
}

function removeMarker(data){
    const id =data['data']['id'];
    markers.get(id).setMap(null);
    markers.delete(id);
}

function addPolyline(data){
    data=data['data'];
    let id=data['id'];
    delete data['id'];
    let polyline= new google.maps.Polyline(data);
    polyline.addListener('click',(e)=>sendDate('polylineClick',{latlng:e.latLng,id:id}));
    polyline.addListener('dblclick',(e)=>sendDate('polylineDoubleClick',{latlng:e.latLng,id:id}));
    polyline.addListener('contextmenu',(e)=>sendDate('polylineRightClick',{latlng:e.latLng,id:id}));
    polyline.addListener('mousemove',(e)=>sendDate('polylineMouseMove',{latlng:e.latLng,id:id}));
    polyline.addListener('mousedown',(e)=>sendDate('polylineMouseDown',{latlng:e.latLng,id:id}));
    polyline.addListener('mouseup',(e)=>sendDate('polylineMouseUp',{latlng:e.latLng,id:id}));

    polyline.setMap(map);
    polylines.set(id,polyline);
}
function setPloyEditable(data){
    const {id,type,editable}=data['data'];
    drawElements[type].get(id).setEditable(editable);
 }

function setPloyGeodesic(data){
    const {id,type,geodesic}=data['data'];
    drawElements[type].get(id).setOptions({geodesic:geodesic});
 }

function setPolyStrokeColor(data){
    const {id,type,strokeColor}=data['data'];
    drawElements[type].get(id).setOptions({strokeColor:strokeColor});
 }

function setPolyStrokeOpacity(data){
    const {id,type,strokeOpacity}=data['data'];
    drawElements[type].get(id).setOptions({strokeOpacity:strokeOpacity});
 }

function setPolyStrokeWeight(data){
    const {id,type,strokeWeight}=data['data'];
    drawElements[type].get(id).setOptions({strokeWeight:strokeWeight});
 }

 function setPolylinePath(data){
     const {id,path}=data['data'];
     polylines.get(id).setPath(path); 
 }
 function removePolyLine(data){
     const id=data['data']['id'];
     polylines.get(id).setMap(null);
     polylines.delete(id);
 }
 function addPolygon(data){
     data=data['data'];
     let {id,type} = data;
     delete data['id'];
     delete data['type'];
     let polygon;
     switch(type){
        case 'polygon':
            polygon=new google.maps.Polygon(data);
            break;
        case 'maprectanlge':{
            polygon=new google.maps.Rectangle(data);
            polygon.addListener('bounds_changed',()=>sendDate(`${type}BoundsChanged`,{bounds:polygons.get(id).getBounds(),id:id}));
            }break;
        case 'mapcircle':{
            polygon=new google.maps.Circle(data);
            polygon.addListener('center_changed',()=>sendDate(`${type}CenterChanged`,{center:polygons.get(id).getCenter(),id:id}));
            polygon.addListener('radius_changed',()=>sendDate(`${type}RadiusChanged`,{radius:polygons.get(id).getRadius(),id:id}));

            }break;
    }
     polygon.addListener('click',(e)=>sendDate(`${type}Click`,{latlng:e.latLng,id:id}));
     polygon.addListener('dblclick',(e)=>sendDate(`${type}DoubleClick`,{latlng:e.latLng,id:id}));
     polygon.addListener('contextmenu',(e)=>sendDate(`${type}RightClick`,{latlng:e.latLng,id:id}));
     polygon.addListener('mousemove',(e)=>sendDate(`${type}MouseMove`,{latlng:e.latLng,id:id}));
     polygon.addListener('mousedown',(e)=>sendDate(`${type}MouseDown`,{latlng:e.latLng,id:id}));
     polygon.addListener('mouseup',(e)=>sendDate(`${type}MouseUp`,{latlng:e.latLng,id:id}));
 
     polygon.setMap(map);
     polygons.set(id,polygon);

 }

 function setPolygonFillColor(data){
    const {id,fillColor}=data['data'];
    polygons.get(id).setOptions({fillColor:fillColor});
 }
 function setPolygonFillOpacity(data){
    const {id,fillOpacity}=data['data'];
    polygons.get(id).setOptions({fillOpacity:fillOpacity});
 }
 function setPolygonPaths(data){
     const {id,paths}=data['data'];
     polygons.get(id).setPaths(paths);
  }

function setRectangleBounds(data){
    const {id,bounds}=data['data'];
    polygons.get(id).setBounds(bounds);
}

function sendRectangleBounds(data){
    const id=data['data']['id'];
    sendDate('sendRectangleBounds',{bounds:polygons.get(id).getBounds(),id:id});
}

function setCircleCenter(data){
    const {id,center}=data['data'];
    polygons.get(id).setCenter(center);
 }

function setCircleRadius(data){
    const {id,radius}=data['data'];
    polygons.get(id).setRadius(radius);
 }

 function removePolygon(data){
     const id =data['data']['id'];
     polygons.get(id).setMap(null);
     polygons.delete(id);
  }