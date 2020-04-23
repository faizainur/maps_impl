class Gempa {
  String _tanggal;
  String _jam;
  List<double> _coords;
  String _latitude;
  String _longitude;
  String _depth;
  String _magnitude;
  String _wilayah;

  Gempa(this._tanggal,
        this._jam,
        this._coords,
        this._latitude,
        this._longitude,
        this._depth,
        this._magnitude,
        this._wilayah);

 String get getWilayah => _wilayah;
 set setWilayah(String wilayah) {
   this._wilayah = wilayah;
 }

  
  set setTanggal(String tanggal) {
    this._tanggal = tanggal;
  }
  String get getTanggal => this._tanggal;
 
  set setJam(String jam) {
    this._jam = jam;
  }
  String get getJam => this._jam;

  set setCoords(List<double> coords) {
    this._coords = coords;
  }
  List<double> get getCoords => this._coords;

  set setLatitude(String latitude) {
    this._latitude = latitude;
  }
  String get getLatitude => this._latitude;

  set setLongitude(String longitude) {
    this._longitude = longitude;
  }
  String get getLongitude => this._longitude;

  set setDepth(String depth) {
    this._depth = depth;
  }
  String get getDepth => this._depth;

  set setMagnitude(String magnitude){
    this._magnitude = magnitude;
  }
  String get getMagnitude => this._magnitude;


}