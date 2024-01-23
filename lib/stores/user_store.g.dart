// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserStoreBase, Store {
  late final _$usernameAtom =
      Atom(name: 'UserStoreBase.username', context: context);

  @override
  String? get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String? value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$emailAtom = Atom(name: 'UserStoreBase.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$phoneAtom = Atom(name: 'UserStoreBase.phone', context: context);

  @override
  String? get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String? value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$UserStoreBaseActionController =
      ActionController(name: 'UserStoreBase', context: context);

  @override
  void saveUser(String username) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.saveUser');
    try {
      return super.saveUser(username);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveEmail(String email) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.saveEmail');
    try {
      return super.saveEmail(email);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void savePhone(String phone) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.savePhone');
    try {
      return super.savePhone(phone);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
username: ${username},
email: ${email},
phone: ${phone}
    ''';
  }
}
