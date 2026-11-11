import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';
import '../../data/subscription_controller.dart';
import '../../models/product.dart';
import '../../widgets/net_image.dart';
import '../../widgets/product_actions.dart';
import '../../widgets/product_card.dart';

const _weekdayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _monthNames = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

class ShoppingHomeScreen extends StatefulWidget {
  const ShoppingHomeScreen({super.key});

  @override
  State<ShoppingHomeScreen> createState() => _ShoppingHomeScreenState();
}

class _ShoppingHomeScreenState extends State<ShoppingHomeScreen> {
  final PageController _dayCtrl = PageController();
  final GlobalKey _essentialsKey = GlobalKey();

  int _dayPage = 0;
  String? _selectedCategory;

  @override
  void dispose() {
    _dayCtrl.dispose();
    super.dispose();
  }

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
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
    final picks = products
        .where((p) =>
            _selectedCategory == null || p.category == _selectedCategory)
        .toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: top + 12, bottom: 130),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topBar(),
            const SizedBox(height: 22),
            _greetingBlock(),
            const SizedBox(height: 20),
            _deliveryCard(),
            const SizedBox(height: 22),
            _subscribeBanner(),
            const SizedBox(height: 28),
            _categoryRow(),
            const SizedBox(height: 28),
            _title(
              'Daily essentials',
              sub: 'Subscribe once, skip the hassle',
              key: _essentialsKey,
            ),
            const SizedBox(height: 14),
            _essentialsRail(),
            const SizedBox(height: 28),
            _promiseCard(),
            const SizedBox(height: 28),
            _title(
              _selectedCategory ?? "Today's picks",
              sub: '${picks.length} items',
            ),
            const SizedBox(height: 14),
            _picksRail(picks),
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

  Widget _greetingBlock() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$_greeting!',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text('Fresh essentials,\nevery morning.', style: AppText.display(34)),
        ],
      ),
    );
  }

  // ----------------------------------------------------------- DELIVERY CARD

  Widget _deliveryCard() {
    final subs = SubscriptionController.instance;

    return ListenableBuilder(
      listenable: subs,
      builder: (context, _) {
        final now = DateTime.now();
        final days = List.generate(
          7,
          (i) => DateTime(now.year, now.month, now.day + 1 + i),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
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
                      child: Text(
                        'Upcoming deliveries',
                        style: AppText.display(20),
                      ),
                    ),
                    _arrow(Icons.chevron_left_rounded, () {
                      if (_dayPage > 0) {
                        _dayCtrl.animateToPage(
                          _dayPage - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    }),
                    const SizedBox(width: 8),
                    _arrow(Icons.chevron_right_rounded, () {
                      if (_dayPage < days.length - 1) {
                        _dayCtrl.animateToPage(
                          _dayPage + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    }),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 124,
                  child: PageView.builder(
                    controller: _dayCtrl,
                    itemCount: days.length,
                    onPageChanged: (i) => setState(() => _dayPage = i),
                    itemBuilder: (context, i) =>
                        _dayPageContent(days[i], i, subs.deliveriesOn(days[i])),
                  ),
                ),
                GestureDetector(
                  onTap: _scrollToEssentials,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Add more items',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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

  Widget _dayPageContent(DateTime d, int i, List<Subscription> list) {
    final label = i == 0 ? 'Tomorrow' : _weekdayNames[d.weekday - 1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label · ${d.day} ${_monthNames[d.month - 1]}',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
        ),
        const SizedBox(height: 12),
        if (list.isEmpty)
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.event_available_outlined,
                    color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'No delivery planned.\nSubscribe below and we handle it.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          )
        else
          SizedBox(
            height: 84,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              separatorBuilder: (context, i) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final s = list[i];
                final cat = categoryOf(s.product.category);
                return SizedBox(
                  width: 70,
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
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
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '×${s.qty}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        s.product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  // ------------------------------------------------------- SUBSCRIBE BANNER

  Widget _subscribeBanner() {
    final first = products.firstWhere(
      (p) => canSubscribe(p),
      orElse: () => products.first,
    );
    final cat = categoryOf(first.category);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 180,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -40,
              bottom: -50,
              child: Container(
                height: 190,
                width: 190,
                decoration: const BoxDecoration(
                  color: Color(0x26FFFFFF),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: 18,
              top: 24,
              bottom: 24,
              width: 104,
              child: Transform.rotate(
                angle: 0.07,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: NetImage(
                    url: first.image,
                    fallbackIcon: cat.icon,
                    background: cat.color,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Subscribe\n& forget.',
                    style: AppText.display(28, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  const SizedBox(
                    width: 170,
                    child: Text(
                      'Fresh milk, every morning.',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _scrollToEssentials,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 9),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Subscribe',
                            style: TextStyle(
                              color: AppColors.ink,
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded,
                              size: 14, color: AppColors.ink),
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

  // -------------------------------------------------------------- CATEGORIES

  Widget _categoryRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('Shop by category'),
        const SizedBox(height: 14),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            children: [
              _circle(
                label: 'All',
                selected: _selectedCategory == null,
                child: const ColoredBox(
                  color: AppColors.primarySoft,
                  child: Center(
                    child: Icon(Icons.apps_rounded,
                        size: 26, color: AppColors.primary),
                  ),
                ),
                onTap: () => setState(() => _selectedCategory = null),
              ),
              for (final c in categories)
                _circle(
                  label: c.name,
                  selected: _selectedCategory == c.name,
                  child: NetImage(
                    url: c.image,
                    fallbackIcon: c.icon,
                    background: c.color,
                  ),
                  onTap: () => setState(
                    () => _selectedCategory =
                        _selectedCategory == c.name ? null : c.name,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _circle({
    required String label,
    required bool selected,
    required Widget child,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.accent : Colors.transparent,
                  width: 2.5,
                ),
              ),
              child: SizedBox(
                height: 58,
                width: 58,
                child: ClipOval(child: child),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                color: selected ? AppColors.ink : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------- ESSENTIALS

  Widget _essentialsRail() {
    final items = products.where(canSubscribe).toList();

    return SizedBox(
      height: 172,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        separatorBuilder: (context, i) => const SizedBox(width: 12),
        itemBuilder: (context, i) => _essentialCard(items[i]),
      ),
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
            item(Icons.pause_circle_outline_rounded, 'Flexible', 'Pause anytime'),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------- PICKS RAIL

  Widget _picksRail(List<Product> items) {
    return SizedBox(
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
    );
  }
}