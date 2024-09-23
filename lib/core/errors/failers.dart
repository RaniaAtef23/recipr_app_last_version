abstract class failers{
  final String error;

  failers(this.error);

}
class server_error extends failers{
  server_error(super.error);
}