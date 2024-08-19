class ResponseModel{

  final bool _isSuccuess;
  final String _message;
  dynamic data;
  ResponseModel(this._isSuccuess,this._message,{this.data});
  bool get isSuccuess => _isSuccuess;
  String get message => _message;


}