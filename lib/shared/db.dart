import 'package:paylink_app/models/invoice.dart';
import 'package:paylink_app/models/license.dart';
import 'package:paylink_app/models/user.dart';
/*

class Database {
  Realm realm;

  Database() {
    var config = Configuration();
    config.schema.add(User);
    config.schema.add(License);
    config.schema.add(Invoice);
    // Open a Realm
    realm = Realm(config);
  }

  void saveUser(User user) {
    realm.write(() {
      realm.create(user);
    });
  }

  User loadUser() {
    return realm.find<User>("");
  }

  Results<License> findLicenses() {
    return realm.objects<License>();
  }

  void saveLicenses(List<License> licenses) {
    for (License license in licenses) {
      realm.create(license);
    }
  }

  Results<License> findInvoices() {
    return realm.objects<License>();
  }

  Results<License> findPayments() {
    return realm.objects<License>();
  }
}
*/
