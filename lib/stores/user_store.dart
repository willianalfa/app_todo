import 'package:mobx/mobx.dart';
part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  @observable
  String? username;

  @observable
  String? email;

  @observable
  String? phone;

  @action
  void saveUser(String username) {
    this.username = username;
  }

  @action
  void saveEmail(String email) {
    this.email = email;
  }

  @action
  void savePhone(String phone) {
    this.phone = phone;
  }
}