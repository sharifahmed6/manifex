import 'package:get/get.dart';
import 'package:manifex/Core/snakbar.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../Core/SharepreferenceHelper.dart';

class subscriptionController extends GetxController {
  var offerings = Rxn<Offerings>();
  var isPremium = false.obs;
  var activeSubscription = "".obs;
  var activePackageName = "".obs;

  // Auto-renew & next renewal info
  var autoRenew = false.obs;
  var nextRenewDate = "".obs;

  final Map<String, List<String>> subscriptionFeatures = {
    "premium_monthly": [
      "Unlimited lessons",
      "Advanced progress analytics",
      "Full reward library access",
      "Priority AI support",
      "Parent dashboard",
      "Offline mode",
      "7 days free trial"
    ],
    "family_monthly": [
      "Up to 5 learner profiles",
      "All Premium features",
      "Family progress reports",
      "Shared reward library",
      "Priority support",
      "Educational resources",
      "7 days free trial"
    ],
  };

  @override
  void onInit() {
    super.onInit();
    initRevenueCat();
  }

  /// Initialize RevenueCat and login user
  Future<void> initRevenueCat() async {
    try {
      Purchases.setDebugLogsEnabled(true);
      String userId = PrefHelper.getUserId();


      if (userId != null) {
        await Purchases.logIn(userId);
      } else {
        // Anonymous login if no userId
        await Purchases.logIn("anon_${DateTime.now().millisecondsSinceEpoch}");
      }

      // Fetch offerings
      await fetchOfferings();

      // Listen for subscriber info changes
      Purchases.addCustomerInfoUpdateListener(_customerInfoListener);

      // Initial check
      final info = await Purchases.getCustomerInfo();
      _updatePremiumStatus(info);

    } catch (e) {
      print("RevenueCat init error: $e");
    }
  }

  /// Fetch offerings from RevenueCat
  Future<Offerings?> fetchOfferings() async {
    try {
      Offerings fetchedOfferings = await Purchases.getOfferings();
      offerings.value = fetchedOfferings;
      return fetchedOfferings;
    } catch (e) {
      print("Error fetching offerings: $e");
      return null;
    }
  }

  /// Get packages from current offering
  List<Package> getCurrentPackages() {
    final currentOffering = offerings.value?.current;
    if (currentOffering == null) return [];
    return currentOffering.availablePackages;
  }

  /// Get packages by offering ID
  List<Package> getPackagesByOfferingId(String offeringId) {
    final offering = offerings.value?.all[offeringId];
    if (offering == null) return [];
    return offering.availablePackages;
  }

  /// Listener for subscriber info updates
  void _customerInfoListener(CustomerInfo info) {
    _updatePremiumStatus(info);
  }

  /// Update premium status from CustomerInfo
  void _updatePremiumStatus(CustomerInfo info) {
    // Check first active entitlement
    final activeEntitlement = info.entitlements.active.entries.isNotEmpty
        ? info.entitlements.active.entries.first.value
        : null;

    if (activeEntitlement != null) {
      // Set auto-renew
      autoRenew.value = activeEntitlement.willRenew;

      // Set next renewal date
      String nextRenew = "N/A";
      if (activeEntitlement.expirationDate != null) {
        DateTime expDate = DateTime.parse(activeEntitlement.expirationDate!).toLocal();
        nextRenew =
        "${expDate.day.toString().padLeft(2, '0')}-${expDate.month.toString().padLeft(2, '0')}-${expDate.year}";
      }

      isPremium.value = true;
      activeSubscription.value = activeEntitlement.identifier; // entitlement ID
      activePackageName.value = activeEntitlement.productIdentifier; // product ID
      nextRenewDate.value = nextRenew;

    } else {
      // No active subscription yet
      isPremium.value = false;
      activeSubscription.value = "";
      activePackageName.value = "";
      autoRenew.value = false;
      nextRenewDate.value = "N/A";
    }
  }

  /// Purchase a package
  Future<CustomerInfo> purchasePackage(Package package) async {
    try {
      // Initiate purchase
      PurchaseResult result = await Purchases.purchasePackage(package);

      // Extract CustomerInfo from result
      CustomerInfo customerInfo = result.customerInfo;

      // Update UI reactive variables
      _updatePremiumStatus(customerInfo);

      return customerInfo;
    } catch (e) {
      print("Purchase failed: $e");
      rethrow; // UI can handle it
    }
  }

  /// Unsubscribe / cancel subscription
  /// Note: actual auto-renew OFF must be done by user in App Store / Play Store.
  Future<void> cancelAutoRenew() async {
    try {
      CustomerInfo info = await Purchases.getCustomerInfo();
      final activeEntitlement = info.entitlements.active.entries.isNotEmpty
          ? info.entitlements.active.entries.first.value
          : null;

      if (activeEntitlement != null) {
        AppSnackbar.show("Subscription ${activeEntitlement.identifier} must be cancelled via App Store / Play Store");
      } else {
        AppSnackbar.show("No active subscription to cancel.");
      }

      // Update local state
      _updatePremiumStatus(info);
    } catch (e) {
      AppSnackbar.show("Something went please try again later.");
      print("Error cancelling subscription: $e");
    }
  }
}