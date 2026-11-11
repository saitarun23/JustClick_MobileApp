import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';
import '../../data/subscription_controller.dart';
import '../../models/product.dart';
import '../../widgets/manage_delivery_sheet.dart';
import '../../widgets/net_image.dart';
import '../../widgets/product_actions.dart';
import '../../widgets/product_card.dart';
import '../../widgets/subscribe_sheet.dart';

const _weekdayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _monthNames = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];
const _quickSearches = ['Milk', 'Eggs', 'Cheese', 'Bread', 'Apples'];

class ShoppingHomeScreen extends StatefulWidget {
  const ShoppingHomeScreen({super.key});

  @override
  State<ShoppingHomeScreen> createState() => _ShoppingHomeScreenState();
}

class _ShoppingHomeScreenState extends State<ShoppingHomeScreen> {
  final PageController _showcaseCtrl = PageController(viewportFraction: 0.84);
  final PageController _dayCtrl = PageController();
  final TextEditingController _searchCtrl = TextEditingController();
  final GlobalKey _essentialsKey = GlobalKey();

  Timer? _timer;
  int _showPage = 0;
  int _dayPage = 0;
  String _query = '';
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    // Auto-slide the product showcase while the customer has no plan yet.
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      final count = products.where(canSubscribe).length;
      if (!mounted ||
          SubscriptionController.instance.hasAny ||
          count == 0 ||
          !_showcaseCtrl.hasClients) {
        return;
      }
      _showcaseCtrl.animateToPage(
        (_showPage + 1) % count,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _showcaseCtrl.dispose();
    _dayCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _scrollToEssentials() {
    final ctx = _essentialsKey.currentContext;
    if (ctx == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have added all daily products.')),
      );
      return;
    }
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      alignment: 0.05,
    );
  }

  void _openWallet() {
    final subs = SubscriptionController.instance;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
          child: ValueListenableBuilder<int>(
            valueListenable: subs.wallet,
            builder: (context, balance, _) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your wallet', style: AppText.display(24)),
                const SizedBox(height: 14),
                const Text(
                  'Balance',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                Text('₹$balance', style: AppText.display(42)),
                const SizedBox(height: 18),
                const Text(
                  'Add money',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final a in const [100, 200, 500])
                      ActionChip(
                        label: Text('+ ₹$a'),
                        backgroundColor: AppColors.primarySoft,
                        side: BorderSide.none,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                        onPressed: () => subs.addMoney(a),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------ BUILD

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final subs = SubscriptionController.instance;
    final searching = _query.isNotEmpty;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.only(top: top + 12, bottom: 130),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topBar(),
            const SizedBox(height: 18),
            _searchBar(),
            const SizedBox(height: 12),
            _quickChips(),
            const SizedBox(height: 22),
            if (searching)
              _results()
            else ...[
              _hero(),
              const SizedBox(height: 28),
              ListenableBuilder(
                listenable: subs,
                builder: (context, _) => _addMoreSection(),
              ),
              _categoryRow(),
              const SizedBox(height: 28),
              _picksSection(),
              const SizedBox(height: 28),
              _promiseCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _title(String text, {String? sub, Key? key}) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: Text(text, style: AppText.display(23))),
          if (sub != null)
            Text(
              sub,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------- TOP BAR

  Widget _topBar() {
    final subs = SubscriptionController.instance;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.location_on_rounded,
                color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Home',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                  ],
                ),
                Text(
                  'Add your full address',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _openWallet,
            child: ValueListenableBuilder<int>(
              valueListenable: subs.wallet,
              builder: (context, balance, _) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.ink,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.account_balance_wallet_outlined,
                        color: Colors.white, size: 17),
                    const SizedBox(width: 6),
                    Text(
                      '₹$balance',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(Icons.notifications_none_rounded,
                size: 21, color: AppColors.ink),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------ SEARCH

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.search_rounded, color: AppColors.ink),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchCtrl,
                textInputAction: TextInputAction.search,
                onChanged: (v) => setState(() => _query = v.trim()),
                decoration: const InputDecoration(
                  hintText: 'Search milk, curd, fruits...',
                  hintStyle: TextStyle(color: AppColors.textSecondary),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (_query.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _searchCtrl.clear();
                  setState(() => _query = '');
                },
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Icon(Icons.close_rounded,
                      size: 20, color: AppColors.textSecondary),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(14),
                child: Icon(Icons.mic_none_rounded,
                    size: 22, color: AppColors.textSecondary),
              ),
          ],
        ),
      ),
    );
  }

  Widget _quickChips() {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          for (final q in _quickSearches)
            GestureDetector(
              onTap: () {
                _searchCtrl.text = q;
                setState(() => _query = q);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.north_west_rounded,
                        size: 13, color: AppColors.textSecondary),
                    const SizedBox(width: 5),
                    Text(
                      q,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _results() {
    final list = products
        .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('Results for “$_query”', sub: '${list.length} items'),
        const SizedBox(height: 14),
        if (list.isEmpty)
          const Padding(
            padding: EdgeInsets.all(40),
            child: Center(
              child: Text(
                'Nothing matches that',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ),
        for (final p in list) _resultTile(p),
      ],
    );
  }

  Widget _resultTile(Product p) {
    final cat = categoryOf(p.category);

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 76,
                width: 76,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: NetImage(
                    url: p.image,
                    fallbackIcon: cat.icon,
                    background: cat.color,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${p.unit} · ${p.category}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '₹${p.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ProductActions(product: p),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------- HERO

  /// Product showcase until the first subscription, then the delivery card.
  Widget _hero() {
    final subs = SubscriptionController.instance;

    return ListenableBuilder(
      listenable: subs,
      builder: (context, _) => SizedBox(
        width: double.infinity,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: subs.hasAny ? _deliveryCard() : _showcase(),
        ),
      ),
    );
  }

  // ------------------------------------------------------ HERO: PRODUCT SHOWCASE

  Widget _showcase() {
    final items = products.where(canSubscribe).toList();
    if (items.isEmpty) return const SizedBox.shrink(key: ValueKey('showcase'));

    return Column(
      key: const ValueKey('showcase'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('Start a daily plan', sub: 'Swipe to explore'),
        const SizedBox(height: 14),
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _showcaseCtrl,
            itemCount: items.length,
            onPageChanged: (i) => setState(() => _showPage = i),
            itemBuilder: (context, i) => _showcaseCard(items[i], i),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 7,
              width: i == _showPage ? 22 : 7,
              decoration: BoxDecoration(
                color:
                    i == _showPage ? AppColors.ink : const Color(0xFFD9D2C3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _showcaseCard(Product p, int i) {
    final cat = categoryOf(p.category);

    return AnimatedScale(
      scale: i == _showPage ? 1 : 0.94,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: GestureDetector(
        onTap: () => showSubscribeSheet(context, p),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              fit: StackFit.expand,
              children: [
                NetImage(
                  url: p.image,
                  fallbackIcon: cat.icon,
                  background: cat.color,
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x00000000), Color(0xCC000000)],
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0x40FFFFFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      p.category.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 18,
                  right: 14,
                  bottom: 18,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              p.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.display(24, color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${p.unit} · ₹${p.price}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Subscribe',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------- HERO: DELIVERY CARD

  Widget _deliveryCard() {
    final subs = SubscriptionController.instance;
    final now = DateTime.now();
    final days = List.generate(
      7,
      (i) => DateTime(now.year, now.month, now.day + 1 + i),
    );
    final pause = subs.pause;

    return Padding(
      key: const ValueKey('delivery'),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFD3E4D8)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Upcoming deliveries', style: AppText.display(20)),
                      const SizedBox(height: 2),
                      const Text(
                        'Tap an item to skip or change it',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                _arrow(Icons.chevron_left_rounded, () {
                  if (_dayCtrl.hasClients && _dayPage > 0) {
                    _dayCtrl.animateToPage(
                      _dayPage - 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                }),
                const SizedBox(width: 8),
                _arrow(Icons.chevron_right_rounded, () {
                  if (_dayCtrl.hasClients && _dayPage < days.length - 1) {
                    _dayCtrl.animateToPage(
                      _dayPage + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                }),
              ],
            ),
            const SizedBox(height: 12),
            if (pause != null) _pauseBanner(pause),
            SizedBox(
              height: 128,
              child: PageView.builder(
                controller: _dayCtrl,
                itemCount: days.length,
                onPageChanged: (i) => setState(() => _dayPage = i),
                itemBuilder: (context, i) =>
                    _dayPageContent(days[i], i, subs.entriesOn(days[i])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _scrollToEssentials,
                    child: const Text(
                      'Add more items',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => pickPause(context),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.flight_takeoff_rounded,
                            size: 16, color: AppColors.primary),
                        SizedBox(width: 4),
                        Text(
                          'Going away?',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _arrow(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        width: 34,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 22, color: AppColors.ink),
      ),
    );
  }

  String _short(DateTime d) => '${d.day} ${_monthNames[d.month - 1]}';

  Widget _pauseBanner(DateTimeRange r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.flight_takeoff_rounded,
              size: 18, color: AppColors.accent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Paused ${_short(r.start)} to ${_short(r.end)}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          GestureDetector(
            onTap: SubscriptionController.instance.resumeAll,
            child: const Text(
              'Resume',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dayPageContent(DateTime d, int i, List<DeliveryEntry> entries) {
    final label = i == 0 ? 'Tomorrow' : _weekdayNames[d.weekday - 1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label · ${d.day} ${_monthNames[d.month - 1]}',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
        ),
        const SizedBox(height: 10),
        if (entries.isEmpty)
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.event_busy_outlined,
                    color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'No delivery planned for this day.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          )
        else
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: entries.length,
              separatorBuilder: (context, k) => const SizedBox(width: 12),
              itemBuilder: (context, k) => _entryTile(d, entries[k]),
            ),
          ),
      ],
    );
  }

  Widget _entryTile(DateTime d, DeliveryEntry e) {
    final s = e.sub;
    final cat = categoryOf(s.product.category);
    final dim = e.status != DeliveryStatus.scheduled;
    final locked = !SubscriptionController.instance.canChange(d);

    final label = switch (e.status) {
      DeliveryStatus.scheduled => '×${s.qty}',
      DeliveryStatus.skipped => 'Skipped',
      DeliveryStatus.paused => 'Paused',
    };
    final bubbleColor = switch (e.status) {
      DeliveryStatus.scheduled => AppColors.accent,
      DeliveryStatus.skipped => const Color(0xFF8A8F89),
      DeliveryStatus.paused => AppColors.accent,
    };

    return GestureDetector(
      onTap: () => showManageDeliverySheet(context, s, d),
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            SizedBox(
              height: 68,
              width: 70,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Opacity(
                      opacity: dim ? 0.45 : 1,
                      child: SizedBox(
                        height: 62,
                        width: 62,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: NetImage(
                            url: s.product.image,
                            fallbackIcon: cat.icon,
                            background: cat.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: bubbleColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  if (locked)
                    Positioned(
                      left: 4,
                      bottom: 4,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.lock_outline_rounded,
                            size: 12, color: AppColors.ink),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              s.product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------- ADD MORE (rail)

  Widget _addMoreSection() {
    final subs = SubscriptionController.instance;
    if (!subs.hasAny) return const SizedBox.shrink();

    final items =
        products.where((p) => canSubscribe(p) && !subs.has(p)).toList();
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('Add to your mornings',
            sub: 'More daily picks', key: _essentialsKey),
        const SizedBox(height: 14),
        SizedBox(
          height: 172,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: items.length,
            separatorBuilder: (context, i) => const SizedBox(width: 12),
            itemBuilder: (context, i) => _essentialCard(items[i]),
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  Widget _essentialCard(Product p) {
    final cat = categoryOf(p.category);

    return Container(
      width: 300,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: NetImage(
                    url: p.image,
                    fallbackIcon: cat.icon,
                    background: cat.color,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      p.unit,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '₹${p.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (p.discount > 0)
                          Text(
                            '₹${p.mrp}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ProductActions(product: p),
        ],
      ),
    );
  }

  // ------------------------------------------------------------- CATEGORIES

  Widget _categoryRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text('Shop by category', style: AppText.display(23)),
              ),
              if (_selectedCategory != null)
                GestureDetector(
                  onTap: () => setState(() => _selectedCategory = null),
                  child: const Text(
                    'Show all',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 186,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 17),
            children: [for (final c in categories) _categoryCard(c)],
          ),
        ),
      ],
    );
  }

  Widget _categoryCard(Category c) {
    final selected = _selectedCategory == c.name;
    final count = products.where((p) => p.category == c.name).length;

    return GestureDetector(
      onTap: () => setState(
        () => _selectedCategory = selected ? null : c.name,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 132,
        margin: const EdgeInsets.only(right: 9),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: selected ? AppColors.accent : Colors.transparent,
            width: 2.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            fit: StackFit.expand,
            children: [
              NetImage(
                url: c.image,
                fallbackIcon: c.icon,
                background: c.color,
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x00000000), Color(0xB3000000)],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xE6FFFFFF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(c.icon, size: 18, color: AppColors.ink),
                ),
              ),
              if (selected)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    height: 26,
                    width: 26,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_rounded,
                        size: 16, color: Colors.white),
                  ),
                ),
              Positioned(
                left: 12,
                right: 8,
                bottom: 12,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.display(17, color: Colors.white),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$count items',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------ PICKS

  Widget _picksSection() {
    final items = products
        .where((p) =>
            _selectedCategory == null || p.category == _selectedCategory)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(_selectedCategory ?? "Today's picks",
            sub: '${items.length} items'),
        const SizedBox(height: 14),
        SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: items.length,
            separatorBuilder: (context, i) => const SizedBox(width: 14),
            itemBuilder: (context, i) => SizedBox(
              width: 150,
              child: ProductCard(product: items[i], imageHeight: 150),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------ PROMISE CARD

  Widget _promiseCard() {
    Widget item(IconData icon, String title, String sub) {
      return Expanded(
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 26),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              sub,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    Widget divider() =>
        Container(height: 54, width: 1, color: AppColors.border);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            item(Icons.verified_outlined, 'Fresh', 'Quality checked'),
            divider(),
            item(Icons.wb_twilight_rounded, 'Morning', 'Early delivery'),
            divider(),
            item(Icons.event_repeat_rounded, 'Flexible', 'Skip or pause'),
          ],
        ),
      ),
    );
  }
}