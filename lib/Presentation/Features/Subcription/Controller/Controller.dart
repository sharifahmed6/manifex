import 'package:get/get.dart';
import 'package:manifex/Core/snakbar.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../../Core/SharepreferenceHelper.dart';
import '../../home/controller/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';

class subscriptionController extends GetxController with WidgetsBindingObserver {
  var offerings = Rxn<Offerings>();
  var isPremium = false.obs;
  var activeSubscription = "".obs;
  var activePackageName = "".obs;

  // Auto-renew & next renewal info
  var autoRenew = false.obs;
  var nextRenewDate = "".obs;

  final Map<String, List<String>> subscriptionFeatures = {
    "premium": [
      "Unlimited lessons",
      "Advanced progress analytics",
      "Full reward library access",
      "Priority AI support",
      "Parent dashboard",
      "Cancel Anytime",
    ],
    "family": [
      "Up to 3 learner profiles",
      "All Premium features",
      "Family progress reports",
      "Priority support",
      "Educational resources",
      "Shared reward library",
      "Cancel Anytime",
    ],
  };

  /// Get feature list based on product ID (Flexible matching)
  List<String> getFeatureList(String productId) {
    String id = productId.toLowerCase();
    if (id.contains("family")) {
      return subscriptionFeatures["family"]!;
    } else if (id.contains("premium")) {
      return subscriptionFeatures["premium"]!;
    }
    return ["No details available"];
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    initRevenueCat();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  bool _isManagingSubscription = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_isManagingSubscription) {
        _isManagingSubscription = false;
        restorePurchases();
      } else {
        _refreshCustomerInfo();
      }
    }
  }

  Future<void> _refreshCustomerInfo() async {
    try {
      if (Platform.isAndroid) {
        await Purchases.syncPurchases();
      } else {
        await Purchases.invalidateCustomerInfoCache();
      }
      final info = await Purchases.getCustomerInfo();
      _updatePremiumStatus(info);
      _syncProfileInfo(); // Explicitly sync profile on resume
    } catch (e) {
      print("Error refreshing customer info on resume: $e");
    }
  }

  /// Initialize RevenueCat and login user
  Future<void> initRevenueCat() async {
    try {
      Purchases.setDebugLogsEnabled(true);
      String userId = PrefHelper.getUserId();

      if (userId != null && userId.isNotEmpty) {
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
    bool wasPremium = isPremium.value;
    String oldPackage = activePackageName.value;
    bool oldAutoRenew = autoRenew.value;

    // Check first active entitlement
    final activeEntitlement = info.entitlements.active.entries.isNotEmpty
        ? info.entitlements.active.entries.first.value
        : null;

    if (activeEntitlement != null) {
      // Set auto-renew
      autoRenew.value = activeEntitlement.willRenew && activeEntitlement.unsubscribeDetectedAt == null;

      // Set next renewal date
      String nextRenew = "N/A";
      if (activeEntitlement.expirationDate != null) {
        DateTime expDate = DateTime.parse(
          activeEntitlement.expirationDate!,
        ).toLocal();
        nextRenew =
            "${expDate.day.toString().padLeft(2, '0')}-${expDate.month.toString().padLeft(2, '0')}-${expDate.year}";
      }

      isPremium.value = true;
      activeSubscription.value = activeEntitlement.identifier; // entitlement ID
      activePackageName.value =
          activeEntitlement.productIdentifier; // product ID
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

  void _syncProfileInfo() {
    try {
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().fetchProfileInfo();
      }
    } catch (e) {
      print("Error calling fetchProfileInfo: $e");
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
      _syncProfileInfo(); // Explicitly sync profile after purchase

      return customerInfo;
    } catch (e) {
      print("Purchase failed: $e");
      rethrow; // UI can handle it
    }
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    try {
      CustomerInfo restoredInfo = await Purchases.restorePurchases();
      _updatePremiumStatus(restoredInfo);
      _syncProfileInfo(); // Explicitly sync profile after restore
    } catch (e) {
      print("Restore failed: $e");
      rethrow;
    }
  }

  /// Unsubscribe / cancel subscription
  /// Note: actual auto-renew OFF must be done by user in App Store / Play Store.
  Future<void> cancelAutoRenew() async {
    _isManagingSubscription = true;
    try {
      CustomerInfo info = await Purchases.getCustomerInfo();
      final activeEntitlement = info.entitlements.active.entries.isNotEmpty
          ? info.entitlements.active.entries.first.value
          : null;

      if (Platform.isIOS) {
        final url = Uri.parse("https://apps.apple.com/account/subscriptions");
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (activeEntitlement != null) {
          final sku = activeEntitlement.productIdentifier.split(':').first;
          final url = Uri.parse(
              "https://play.google.com/store/account/subscriptions?package=com.manifex.app&sku=$sku");
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          final url = Uri.parse("https://play.google.com/store/account/subscriptions");
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      }

      // Update local state
      _updatePremiumStatus(info);
    } catch (e) {
      AppSnackbar.show("Could not open store to manage subscription.".tr);
      print("Error cancelling subscription: $e");
    }
  }

  /// Get display name for the active package
  String getDisplayName(String productId) {
    if (productId == "monthly_family_subscription" ||
        productId == "family_monthly") {
      return "Family Monthly".tr;
    } else if (productId == "premium_monthly") {
      return "Premium Monthly".tr;
    }
    return productId.tr;
  }
}
