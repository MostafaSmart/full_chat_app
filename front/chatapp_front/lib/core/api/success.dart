abstract class Success {
  final String? code;
  final String message;
  final dynamic data;

  const Success(this.message, {this.code, this.data});
}

class ServerSuccess extends Success {
  const ServerSuccess(super.message, {super.code, super.data});
}
