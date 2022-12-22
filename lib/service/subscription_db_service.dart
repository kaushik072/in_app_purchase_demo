import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

// ignore: depend_on_referenced_packages
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_demo/function/expirydate.dart';
import '../core/user_handling.dart';

class SubscriptionDbService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userId = "";

  Future<void> saveSubcriptionsDetails(PurchaseDetails purchaseDetails) async {
    Map<String, dynamic>? userData = Helper.checkLogIn();

    GooglePlayPurchaseDetails gpp =
        purchaseDetails as GooglePlayPurchaseDetails;
    Map map = {
      'developerPayload': gpp.billingClientPurchase.developerPayload,
      'isAcknowledged': gpp.billingClientPurchase.isAcknowledged,
      'isAutoRenewing': gpp.billingClientPurchase.isAutoRenewing,
      'obfuscatedAccountId': gpp.billingClientPurchase.obfuscatedAccountId,
      'obfuscatedProfileId': gpp.billingClientPurchase.obfuscatedProfileId,
      'orderId': gpp.billingClientPurchase.orderId,
      'originalJson': gpp.billingClientPurchase.originalJson,
      'packageName': gpp.billingClientPurchase.packageName,
      'purchaseTime': gpp.billingClientPurchase.purchaseTime,
      'purchaseToken': gpp.billingClientPurchase.purchaseToken,
      'signature': gpp.billingClientPurchase.signature,
      'sku': gpp.billingClientPurchase.sku
    };
    log("-------MAP------$map");
    _firestore.collection('user').doc(userData!['userId']).set({
      "Purchase Wrapper": {
        'developerPayload': gpp.billingClientPurchase.developerPayload,
        'isAcknowledged': gpp.billingClientPurchase.isAcknowledged,
        'isAutoRenewing': gpp.billingClientPurchase.isAutoRenewing,
        'obfuscatedAccountId': gpp.billingClientPurchase.obfuscatedAccountId,
        'obfuscatedProfileId': gpp.billingClientPurchase.obfuscatedProfileId,
        'orderId': gpp.billingClientPurchase.orderId,
        'originalJson': gpp.billingClientPurchase.originalJson,
        'packageName': gpp.billingClientPurchase.packageName,
        'purchaseTime': gpp.billingClientPurchase.purchaseTime.toString(),
        'purchaseToken': gpp.billingClientPurchase.purchaseToken,
        'signature': gpp.billingClientPurchase.signature,
        'sku': gpp.billingClientPurchase.sku
      }
    }, SetOptions(merge: true)).then((value) {
      _firestore.collection('user').doc(userData['userId']).update({
        'expireDate': expiryDateValue(
            timestamp: gpp.billingClientPurchase.purchaseTime.toString()),
        'status': 'active'
      });
    });
  }

  Stream<UserData> get featchUserDataFromDb {
    Map<String, dynamic>? userData = Helper.checkLogIn();
    return _firestore
        .collection('user')
        .doc(userData!['userId'])
        .snapshots()
        .map((event) => userDataFromSnapshot(event));
  }

  Future<void> changeDateFirebase(PurchaseDetails purchaseDetails) async {
    Map<String, dynamic>? userData = Helper.checkLogIn();
    GooglePlayPurchaseDetails gpp =
        purchaseDetails as GooglePlayPurchaseDetails;
    await _firestore.collection('user').doc(userData!['userId']).update({
      'purchaseTime': gpp.billingClientPurchase.purchaseTime,
    }).then((value) => debugPrint('Update the Date'));
  }

  UserData userDataFromSnapshot(DocumentSnapshot ds) {
    debugPrint("Data :: ${ds.data()}");
    GooglePlayPurchaseDetails? oldPd;
    try {
      var pw = ds.get('Purchase Wrapper');
      oldPd = GooglePlayPurchaseDetails.fromPurchase(PurchaseWrapper(
        isAcknowledged: pw['isAcknowledged'],
        isAutoRenewing: pw['isAutoRenewing'],
        orderId: pw['orderId'],
        originalJson: pw['originalJson'],
        packageName: pw['packageName'],
        purchaseState: PurchaseStateWrapper.purchased,
        purchaseTime: pw['purchaseTime'],
        purchaseToken: pw['purchaseToken'],
        signature: pw['signature'],
        sku: pw['sku'],
        developerPayload: pw['developerPayload'],
        obfuscatedAccountId: pw['obfuscatedAccountId'],
        obfuscatedProfileId: pw['obfuscatedProfileId'],
        skus: [],
      ));
    } catch (e) {}
    return UserData(oldPdFromDb: oldPd, username: ds.get('name'));
  }

  Future<bool> checkUserSubscriptionStatus() async {
    Map<String, dynamic>? userData = Helper.checkLogIn();
    String userUid = userData!['userId'];
    var purchaseRef = _firestore.collection("purchases");
    Query<Map<String, dynamic>> query =
        purchaseRef.where("userId", isEqualTo: userUid);
    QuerySnapshot querySnapshot = await query.get();
    bool subStatus = false;
    for (QueryDocumentSnapshot ds in querySnapshot.docs) {
      String status = ds.get('status');
      if (status == "ACTIVE") {
        subStatus = true;
      }
    }
    return subStatus;
  }
}

class UserData {
  String username;
  GooglePlayPurchaseDetails? oldPdFromDb;

  UserData({required this.username, required this.oldPdFromDb});
}
