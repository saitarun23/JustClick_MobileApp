import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';
import '../../data/subscription_controller.dart';
import '../../models/product.dart';
import '../../widgets/manage_delivery_sheet.dart';
import '../../widgets/mascot.dart';
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
const _chipColors = [
  AppColors.sky,
  AppColors.pink,
  AppColors.mint,
  AppColors.sun,
  AppColors.lilac,
];

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
    // Auto-slide the product showcase.
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      final count = products.where(canSubscribe).length;
      if (!mounted || count == 0 || !_showcaseCtrl.hasClients) return;
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
    if (ctx == null) return;
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
                        backgroundColor: AppColors.sun,
                        side: const BorderSide(color: AppColors.ink, width: 2),
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
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
    final searching = _query.isNotEmpty;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.only(top: top + 12, bottom: 130),
        child: Stack(
          children: [
            Positioned(top: -10, right: -40, child: _blob(AppColors.pink, 150)),
            Positioned(top: 330, left: -60, child: _blob(AppColors.sky, 130)),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _topBar(),
                  const SizedBox(height: 18),
                  _searchBar(),
                  const SizedBox(height: 10),
                  _quickChips(),
                  const SizedBox(height: 18),
                  if (searching)
                    _results()
                  else ...[
                    _mooRow(),
                    const SizedBox(height: 24),
                    _hero(),
                    const SizedBox(height: 26),
                    _categoryRow(),
                    const SizedBox(height: 26),
                    _picksSection(),
                    const SizedBox(height: 26),
                    _promiseCard(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blob(Color color, double size) {
    return Opacity(
      opacity: 0.55,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  /// Section heading with a yellow highlighter strip.
  Widget _title(String text, {String? sub, Key? key}) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    AppColors.sun,
                    AppColors.sun,
                  ],
                  stops: [0, 0.62, 0.62, 1],
                ),
              ),
              child: Text(text, style: AppText.display(23)),
            ),
          ),
          const Spacer(),
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
      padding: const EdgeInsets.fromLTRB(20, 0, 24, 4),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: AppDeco.circle(color: AppColors.sun, shadow: 3),
            child: const Icon(Icons.location_on_rounded,
                color: AppColors.ink, size: 22),
          ),
          const SizedBox(width: 12),
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
                        fontSize: 17,
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
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                decoration: AppDeco.sticker(
                  color: AppColors.accent,
                  radius: 20,
                  shadow: 3,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.account_balance_wallet_outlined,
                        color: AppColors.ink, size: 17),
                    const SizedBox(width: 6),
                    Text(
                      '₹$balance',
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 40,
            width: 40,
            decoration: AppDeco.circle(shadow: 3),
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
      padding: const EdgeInsets.fromLTRB(20, 0, 24, 4),
      child: Container(
        height: 54,
        decoration: AppDeco.sticker(radius: 18, shadow: 3),
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
                      size: 20, color: AppColors.ink),
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
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 6),
        children: [
          for (var i = 0; i < _quickSearches.length; i++)
            GestureDetector(
              onTap: () {
                _searchCtrl.text = _quickSearches[i];
                setState(() => _query = _quickSearches[i]);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.center,
                decoration: AppDeco.sticker(
                  color: _chipColors[i % _chipColors.length],
                  radius: 16,
                  shadow: 2,
                  border: 2,
                ),
                child: Text(
                  _quickSearches[i],
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
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
      margin: const EdgeInsets.fromLTRB(20, 0, 24, 14),
      padding: const EdgeInsets.all(12),
      decoration: AppDeco.sticker(radius: 24, shadow: 4),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 76,
                width: 76,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
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

  // -------------------------------------------------------------------- MOO

  Widget _mooRow() {
    final subs = SubscriptionController.instance;

    return ListenableBuilder(
      listenable: subs,
      builder: (context, _) {
        final now = DateTime.now();
        final tomorrow = DateTime(now.year, now.month, now.day + 1);
        final going = subs
            .entriesOn(tomorrow)
            .where((e) => e.status == DeliveryStatus.scheduled)
            .length;

        final String line;
        if (!subs.hasAny) {
          line = 'Moo! Pick a daily plan and I will bring fresh milk every '
              'morning.';
        } else if (subs.isPaused(tomorrow)) {
          line = 'Holiday mode is on. Tomorrow is a day off!';
        } else if (going == 0) {
          line = 'Nothing arrives tomorrow. Enjoy your day!';
        } else {
          line = '$going item${going == 1 ? '' : 's'} arriving tomorrow. '
              'Plans changed? Tap an item to skip it.';
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const MooMascot(size: 76),
              const SizedBox(width: 14),
              Expanded(child: _bubble(line)),
            ],
          ),
        );
      },
    );
  }

  Widget _bubble(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 4),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: AppDeco.sticker(radius: 20, shadow: 3),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                height: 1.3,
              ),
            ),
          ),
          Positioned(
            left: -8,
            top: 24,
            child: Transform.rotate(
              angle: 0.785398,
              child: Container(
                height: 13,
                width: 13,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    left: BorderSide(color: AppColors.ink, width: 2.2),
                    bottom: BorderSide(color: AppColors.ink, width: 2.2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------- HERO

  /// Delivery card on top (only once you have a plan) and the swipeable
  /// subscribe cards underneath, always.
  Widget _hero() {
    final subs = SubscriptionController.instance;

    return ListenableBuilder(
      listenable: subs,
      builder: (context, _) {
        final hasPlan = subs.hasAny;

        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: hasPlan
                      ? Column(
                          children: [
                            _deliveryCard(),
                            const SizedBox(height: 26),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              _showcase(hasPlan),
            ],
          ),
        );
      },
    );
  }

  // ------------------------------------------------------ PRODUCT SHOWCASE

  Widget _showcase(bool hasPlan) {
    final items = products.where(canSubscribe).toList();
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(
          hasPlan ? 'Add more to your plan' : 'Start a daily plan',
          sub: 'Swipe to explore',
          key: _essentialsKey,
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 266,
          child: PageView.builder(
            controller: _showcaseCtrl,
            itemCount: items.length,
            onPageChanged: (i) => setState(() => _showPage = i),
            itemBuilder: (context, i) => _showcaseCard(items[i], i),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 8,
              width: i == _showPage ? 24 : 8,
              decoration: BoxDecoration(
                color: i == _showPage ? AppColors.accent : Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.ink, width: 1.6),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _showcaseCard(Product p, int i) {
    final cat = categoryOf(p.category);
    final on = SubscriptionController.instance.has(p);

    return AnimatedScale(
      scale: i == _showPage ? 1 : 0.94,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: GestureDetector(
        onTap: () => showSubscribeSheet(context, p),
        child: Container(
          margin: const EdgeInsets.fromLTRB(6, 2, 12, 12),
          decoration: AppDeco.sticker(radius: 30, shadow: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(27),
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
                  top: 14,
                  left: 14,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: AppDeco.sticker(
                      color: AppColors.sun,
                      radius: 12,
                      shadow: 2,
                      border: 2,
                    ),
                    child: Text(
                      p.category.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 14,
                  bottom: 16,
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
                        decoration: AppDeco.sticker(
                          color: on ? AppColors.mint : AppColors.accent,
                          radius: 18,
                          shadow: 2,
                          border: 2,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (on)
                              const Padding(
                                padding: EdgeInsets.only(right: 4),
                                child: Icon(Icons.check_rounded,
                                    size: 14, color: AppColors.ink),
                              ),
                            Text(
                              on ? 'Subscribed' : 'Subscribe',
                              style: const TextStyle(
                                color: AppColors.ink,
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
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
    final ranges = subs.pauseRanges;

    return Padding(
      key: const ValueKey('delivery'),
      padding: const EdgeInsets.fromLTRB(20, 0, 25, 6),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        decoration: AppDeco.sticker(color: AppColors.mint, radius: 30, shadow: 5),
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
                        style: TextStyle(fontSize: 11),
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
                const SizedBox(width: 10),
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
            if (ranges.isNotEmpty) _pauseBanner(ranges),
            SizedBox(
              height: 124,
              child: PageView.builder(
                controller: _dayCtrl,
                itemCount: days.length,
                onPageChanged: (i) => setState(() => _dayPage = i),
                itemBuilder: (context, i) =>
                    _dayPageContent(days[i], i, subs.entriesOn(days[i])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _scrollToEssentials,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: AppDeco.sticker(
                        radius: 14,
                        shadow: 2,
                        border: 2,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_rounded,
                              size: 16, color: AppColors.ink),
                          SizedBox(width: 4),
                          Text(
                            'Add items',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => pickPause(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: AppDeco.sticker(
                        color: AppColors.sun,
                        radius: 14,
                        shadow: 2,
                        border: 2,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.flight_takeoff_rounded,
                              size: 16, color: AppColors.ink),
                          SizedBox(width: 4),
                          Text(
                            'Going away?',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
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
        decoration: AppDeco.circle(shadow: 2, border: 2),
        child: Icon(icon, size: 22, color: AppColors.ink),
      ),
    );
  }

  String _short(DateTime d) => '${d.day} ${_monthNames[d.month - 1]}';

  String _rangeText(DateTimeRange r) {
    final s = r.start;
    final e = r.end;
    if (s == e) return _short(s);
    if (s.month == e.month) {
      return '${s.day}–${e.day} ${_monthNames[e.month - 1]}';
    }
    return '${_short(s)} – ${_short(e)}';
  }

  Widget _pauseBanner(List<DateTimeRange> ranges) {
    final text = ranges.map(_rangeText).join(', ');

    return Container(
      margin: const EdgeInsets.only(bottom: 14, right: 3),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: AppDeco.sticker(
        color: AppColors.sun,
        radius: 14,
        shadow: 2,
        border: 2,
      ),
      child: Row(
        children: [
          const Icon(Icons.flight_takeoff_rounded,
              size: 18, color: AppColors.ink),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Holiday: $text',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => pickPause(context),
            child: const Text(
              'Edit',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12,
                decoration: TextDecoration.underline,
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
        const SizedBox(height: 8),
        if (entries.isEmpty)
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: AppDeco.circle(shadow: 2, border: 2),
                child: const Icon(Icons.event_busy_outlined,
                    color: AppColors.ink),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'No delivery planned for this day.',
                  style: TextStyle(fontSize: 12),
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
              separatorBuilder: (context, k) => const SizedBox(width: 10),
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
      DeliveryStatus.skipped => const Color(0xFFE0DED6),
      DeliveryStatus.paused => AppColors.sun,
    };

    return GestureDetector(
      onTap: () => showManageDeliverySheet(context, s, d),
      child: SizedBox(
        width: 76,
        child: Column(
          children: [
            SizedBox(
              height: 70,
              width: 76,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: 3,
                    child: Opacity(
                      opacity: dim ? 0.5 : 1,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: AppDeco.sticker(
                          radius: 18,
                          shadow: 2,
                          border: 2,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
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
                      decoration: AppDeco.sticker(
                        color: bubbleColor,
                        radius: 10,
                        shadow: 1.5,
                        border: 1.6,
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  if (locked)
                    Positioned(
                      left: 3,
                      bottom: 6,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: AppDeco.circle(shadow: 0, border: 1.6),
                        child: const Icon(Icons.lock_outline_rounded,
                            size: 12, color: AppColors.ink),
                      ),
                    ),
                ],
              ),
            ),
            Text(
              s.product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ],
        ),
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
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        AppColors.sun,
                        AppColors.sun,
                      ],
                      stops: [0, 0.62, 0.62, 1],
                    ),
                  ),
                  child: Text('Shop by category', style: AppText.display(23)),
                ),
              ),
              const Spacer(),
              if (_selectedCategory != null)
                GestureDetector(
                  onTap: () => setState(() => _selectedCategory = null),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: AppDeco.sticker(
                      color: AppColors.pink,
                      radius: 12,
                      shadow: 2,
                      border: 2,
                    ),
                    child: const Text(
                      'Show all',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 204,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(20, 4, 12, 0),
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
      child: Container(
        width: 132,
        margin: const EdgeInsets.only(right: 14, bottom: 10),
        decoration: AppDeco.sticker(
          color: c.color,
          radius: 28,
          shadow: 4,
          shadowColor: selected ? AppColors.accent : AppColors.ink,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.5),
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
                  decoration: AppDeco.circle(shadow: 2, border: 2),
                  child: Icon(c.icon, size: 18, color: AppColors.ink),
                ),
              ),
              if (selected)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: AppDeco.circle(
                      color: AppColors.accent,
                      shadow: 0,
                      border: 2,
                    ),
                    child: const Icon(Icons.check_rounded,
                        size: 16, color: AppColors.ink),
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
                      style: AppText.display(18, color: Colors.white),
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
          height: 256,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(20, 4, 12, 0),
            itemCount: items.length,
            separatorBuilder: (context, i) => const SizedBox(width: 6),
            itemBuilder: (context, i) => SizedBox(
              width: 166,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 8),
                child: ProductCard(product: items[i], imageHeight: 150),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------ PROMISE CARD

  Widget _promiseCard() {
    Widget item(IconData icon, Color color, String title, String sub) {
      return Expanded(
        child: Column(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: AppDeco.circle(color: color, shadow: 2, border: 2),
              child: Icon(icon, color: AppColors.ink, size: 24),
            ),
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 24, 4),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        decoration: AppDeco.sticker(radius: 26, shadow: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item(Icons.verified_outlined, AppColors.mint, 'Fresh',
                'Quality checked'),
            item(Icons.wb_twilight_rounded, AppColors.sun, 'Morning',
                'Early delivery'),
            item(Icons.event_repeat_rounded, AppColors.pink, 'Flexible',
                'Skip or pause'),
          ],
        ),
      ),
    );
  }
}