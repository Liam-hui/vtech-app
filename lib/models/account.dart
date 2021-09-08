class Account {
  final String guid;
  final String status;
  final bool needVerify;

  // User({@required this.name, @required this.email});
  Account({ required this.guid, required this.status, this.needVerify = false });

  // @override
  // String toString() => 'User { name: $name, email: $email}';
}