import '../models/product.dart';

class ProductInfo {
  final String brand;
  final double rating;
  final int ratingCount;
  final String about;
  final Map<String, String> details;

  /// Extra gallery images (the main image is added automatically).
  final List<String> images;

  /// Other pack sizes (the standard pack comes from the product itself).
  final List<Variant> moreSizes;

  const ProductInfo({
    this.brand = 'Just Click',
    this.rating = 4.4,
    this.ratingCount = 120,
    this.about = '',
    this.details = const {},
    this.images = const [],
    this.moreSizes = const [],
  });
}

const Map<String, ProductInfo> productInfo = {
  'p1': ProductInfo(
    brand: 'Orchard Fresh',
    rating: 4.5,
    ratingCount: 1280,
    about: 'Crisp, juicy apples sorted by hand for sweetness and colour. '
        'Great for snacking, lunchboxes and fruit salads.',
    details: {
      'Type': 'Fresh fruit',
      'Shelf life': '5 to 7 days',
      'Storage': 'Keep in a cool, dry place',
    },
    moreSizes: [Variant('500 g', 79, 95), Variant('2 kg', 289, 350)],
  ),
  'p2': ProductInfo(
    brand: 'Sunny Farms',
    rating: 4.4,
    ratingCount: 960,
    about: 'Naturally ripened bananas, sweet and soft. A quick energy '
        'boost for breakfast or after a workout.',
    details: {
      'Type': 'Fresh fruit',
      'Shelf life': '2 to 3 days',
      'Storage': 'Keep at room temperature',
    },
    moreSizes: [Variant('12 pcs', 85, 105)],
  ),
  'p3': ProductInfo(
    brand: 'Vine & Co',
    rating: 4.3,
    ratingCount: 540,
    about: 'Seedless grapes with a sweet, fresh bite. Wash and enjoy '
        'straight from the pack.',
    details: {
      'Type': 'Fresh fruit',
      'Shelf life': '3 to 5 days',
      'Storage': 'Refrigerate',
    },
    moreSizes: [Variant('1 kg', 155, 185)],
  ),
  'p4': ProductInfo(
    brand: 'Green Valley',
    rating: 4.2,
    ratingCount: 870,
    about: 'Firm red tomatoes for curries, salads and chutneys. Picked '
        'ripe and packed the same day.',
    details: {
      'Type': 'Fresh vegetable',
      'Shelf life': '4 to 6 days',
      'Storage': 'Keep in a cool, dry place',
    },
    moreSizes: [Variant('500 g', 22, 26), Variant('2 kg', 76, 92)],
  ),
  'p5': ProductInfo(
    brand: 'Green Valley',
    rating: 4.4,
    ratingCount: 310,
    about: 'Tender broccoli florets, ideal for stir fries, soups and '
        'steaming.',
    details: {
      'Type': 'Fresh vegetable',
      'Shelf life': '3 to 4 days',
      'Storage': 'Refrigerate',
    },
  ),
  'p6': ProductInfo(
    brand: 'Green Valley',
    rating: 4.3,
    ratingCount: 420,
    about: 'Sweet, crunchy carrots. Perfect raw, grated or cooked.',
    details: {
      'Type': 'Fresh vegetable',
      'Shelf life': '5 to 7 days',
      'Storage': 'Refrigerate',
    },
    moreSizes: [Variant('1 kg', 66, 80)],
  ),
  'p7': ProductInfo(
    brand: 'Daily Dairy',
    rating: 4.7,
    ratingCount: 2310,
    about: 'Fresh toned milk, quality checked and delivered cold. A '
        'staple for tea, coffee and cereal.',
    details: {
      'Type': 'Dairy',
      'Shelf life': '2 days',
      'Storage': 'Keep refrigerated',
    },
    moreSizes: [Variant('1 L', 68, 68)],
  ),
  'p8': ProductInfo(
    brand: 'Daily Dairy',
    rating: 4.6,
    ratingCount: 1750,
    about: 'Farm eggs, graded and packed with care. Great for '
        'breakfast and baking.',
    details: {
      'Type': 'Eggs',
      'Shelf life': '10 days',
      'Storage': 'Refrigerate',
    },
    moreSizes: [Variant('6 pcs', 44, 50), Variant('30 pcs', 205, 235)],
  ),
  'p9': ProductInfo(
    brand: 'Daily Dairy',
    rating: 4.5,
    ratingCount: 690,
    about: 'Creamy cheese slices that melt nicely on sandwiches and '
        'burgers.',
    details: {
      'Type': 'Dairy',
      'Shelf life': '60 days (sealed)',
      'Storage': 'Keep refrigerated',
    },
    moreSizes: [Variant('400 g', 225, 270)],
  ),
  'p10': ProductInfo(
    brand: 'Crunch Co',
    rating: 4.2,
    ratingCount: 1120,
    about: 'Thin, crispy potato chips with a light salt seasoning.',
    details: {
      'Type': 'Snack',
      'Shelf life': '90 days',
      'Storage': 'Keep in a cool, dry place',
    },
    moreSizes: [Variant('200 g', 56, 65)],
  ),
  'p11': ProductInfo(
    brand: 'Crunch Co',
    rating: 4.1,
    ratingCount: 480,
    about: 'Light and fluffy popcorn, ready to munch.',
    details: {
      'Type': 'Snack',
      'Shelf life': '90 days',
      'Storage': 'Keep in a cool, dry place',
    },
  ),
  'p12': ProductInfo(
    brand: 'Fizz',
    rating: 4.3,
    ratingCount: 1500,
    about: 'A classic fizzy cola, best served chilled.',
    details: {
      'Type': 'Beverage',
      'Shelf life': '6 months',
      'Storage': 'Serve chilled',
    },
    moreSizes: [Variant('2 L', 90, 100)],
  ),
  'p13': ProductInfo(
    brand: 'Pulp Fresh',
    rating: 4.4,
    ratingCount: 730,
    about: 'Refreshing orange juice with a naturally sweet taste.',
    details: {
      'Type': 'Beverage',
      'Shelf life': '6 months (sealed)',
      'Storage': 'Refrigerate after opening',
    },
    moreSizes: [Variant('500 ml', 55, 65)],
  ),
  'p14': ProductInfo(
    brand: "Baker's Basket",
    rating: 4.5,
    ratingCount: 640,
    about: 'Soft brown bread, baked fresh for sandwiches and toast.',
    details: {
      'Type': 'Bakery',
      'Shelf life': '3 days',
      'Storage': 'Keep in a cool, dry place',
    },
  ),
  'p15': ProductInfo(
    brand: "Baker's Basket",
    rating: 4.6,
    ratingCount: 390,
    about: 'Buttery, flaky croissants. Lovely with coffee at breakfast.',
    details: {
      'Type': 'Bakery',
      'Shelf life': '2 days',
      'Storage': 'Keep in a cool, dry place',
    },
    moreSizes: [Variant('4 pcs', 135, 165)],
  ),
};