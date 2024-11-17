class ParsingError implements Exception{
  String? parsingErrorMessage;
  String? parsingErrorClassName;
  ParsingError({
    this.parsingErrorClassName,
    this.parsingErrorMessage
  });
}

class NoInternetException implements Exception{}

class ServerError implements Exception{
  String? serverMessage;
  int? errorCode;
  ServerError({this.errorCode,this.serverMessage});

}