import 'package:flutter/material.dart';

import '../models/product.dart';

const List<Promo> promos = [
  Promo('Fresh from\nthe orchard', 'Fruits in 10 minutes', Color(0xFF2F6B4F),
      image:
          'https://www.google.com/imgres?q=frutis%20all%20products&imgurl=https%3A%2F%2Fimages.contentstack.io%2Fv3%2Fassets%2Fbltcedd8dbd5891265b%2Fbltc68b7ba7fc2156b7%2F665640d9f8aaeaadeabcf466%2Ftypes-of-fuit-hero-1-e1559313304247.jpg%3Fq%3D70%26width%3D3840%26auto%3Dwebp&imgrefurl=https%3A%2F%2Fwww.berries.com%2Farticles%2Ftastes%2Ftypes-of-fruit'),
  Promo('Dairy days,\nup to 15% off', 'Milk, eggs and more', Color(0xFFE08A3C),
      image:
          'https://www.google.com/imgres?q=milk%20and%20egg%20all%20products&imgurl=https%3A%2F%2Fthumbs.dreamstime.com%2Fb%2Fcheese-bread-milk-eggs-17775774.jpg&imgrefurl=https%3A%2F%2Fwww.dreamstime.com%2Fphotos-images%2Fmilk-eggs.html'),
  Promo('Snack time,\nany time', 'Munchies for every mood', Color(0xFF5B4B8A),
      image:
          'https://www.google.com/imgres?q=chips%20all%20products&imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FI%2F71FAUX9wPiL._AC_UF350%2C350_QL80_.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.in%2FLays-Potato-Chips-Indias-Masala%2Fdp%2FB08Q95QQQR'),
];

const List<Category> categories = [
  Category('Fruits', Icons.apple, Color(0xFFFDE8E8),
      image:
          'https://www.google.com/imgres?q=all%20fruits&imgurl=https%3A%2F%2Fcontentblog.abaenglish.com%2Fwp-content%2Fuploads%2F2021%2F09%2F30162236%2Ffruits-in-english.jpg&imgrefurl=https%3A%2F%2Fblog.abaenglish.com%2Ffruits-in-english%2F'),
  Category('Vegetables', Icons.eco, Color(0xFFE6F4EA),
      image:
          'https://www.google.com/imgres?q=all%20vegetables&imgurl=https%3A%2F%2Fwww.diabetescarecommunity.ca%2Fwp-content%2Fuploads%2F2024%2F07%2Ffruit-and-veggies-702x360.jpg&imgrefurl=https%3A%2F%2Fwww.diabetescarecommunity.ca%2F'),
  Category('Dairy', Icons.egg_alt, Color(0xFFE8F0FD),
      image:
          'https://www.google.com/imgres?q=all%20dairy%20products&imgurl=https%3A%2F%2Fthumb.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F3%2F35%2FDairyProductsGermany.jpg%2F1280px-DairyProductsGermany.jpg&imgrefurl=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FDairy_product'),
  Category('Snacks', Icons.fastfood, Color(0xFFFFF3D6),
      image:
          'https://www.google.com/imgres?q=all%20snacks&imgurl=https%3A%2F%2Fimgproxy.divecdn.com%2FLBux-f2WPIcLVk6vGOVNnkuwV54t_cNKpYVaC7DRyOc%2Fg%3Ace%2Frs%3Afill%3A1200%3A675%3A1%2FZ3M6Ly9kaXZlc2l0ZS1zdG9yYWdlL2RpdmVpbWFnZS8yMDIxMTAyNl9Nb25kZWxlel9Qcm9kdWN0X0FsbF9QTEFURTFfNzQ2MF9oaWdocmVzX3Q2V2pibEYuanBn.webp&imgrefurl=https%3A%2F%2Fwww.cstoredive.com%2F'),
  Category('Drinks', Icons.local_drink, Color(0xFFEDE7F6),
      image:
          'https://www.google.com/imgres?q=drinks&imgurl=https%3A%2F%2Fwww.shutterstock.com%2Fimage-photo%2Fpoznan-pol-oct-31-2024-260nw-2542841489.jpg&imgrefurl=https%3A%2F%2Fwww.shutterstock.com%2Fsearch%2Fsoft-drinks'),
  Category('Bakery', Icons.bakery_dining, Color(0xFFFBE9DD),
      image:
          'https://www.google.com/imgres?q=all%20bakery&imgurl=https%3A%2F%2Fcooking-ez.com%2Fimages%2Fblog%2Fdifference-boulangerie-patisserie.webp&imgrefurl=https%3A%2F%2Fcooking-ez.com%2Fdifference-between-bakery-and-patisserie.php'),
];

const List<Product> products = [
  // ------------------------------------------------------------- FRUITS
  Product(
    id: 'p1',
    name: 'Fresh Apples',
    unit: '1 kg',
    image:
        'https://www.google.com/imgres?q=apples&imgurl=https%3A%2F%2Fhips.hearstapps.com%2Fhmg-prod%2Fimages%2Fapples-at-farmers-market-royalty-free-image-1627321463.jpg%3Fcrop%3D0.796xw%3A1.00xh%3B0.103xw%2C0%26resize%3D640%3A*&imgrefurl=https%3A%2F%2Fwww.prevention.com%2F',
    category: 'Fruits',
    price: 149,
    mrp: 180,
    brand: 'Orchard Fresh',
    rating: 4.6,
    ratingCount: 1280,
    description:
        'Crisp, juicy apples picked at peak ripeness from the hills. Great '
        'for snacking, salads, juices and baking. Each apple is hand-sorted '
        'for colour and firmness before it is packed, so what reaches you '
        'is fresh and ready to eat.',
    images: [
      'https://www.google.com/imgres?q=apples&imgurl=https%3A%2F%2Fhips.hearstapps.com%2Fhmg-prod%2Fimages%2Fapples-at-farmers-market-royalty-free-image-1627321463.jpg%3Fcrop%3D0.796xw%3A1.00xh%3B0.103xw%2C0%26resize%3D640%3A*&imgrefurl=https%3A%2F%2Fwww.prevention.com%2F',
      'https://loremflickr.com/600/600/apple?lock=11',
      'https://loremflickr.com/600/600/apple?lock=12',
    ],
    variants: [
      Variant('1 kg', 149, 180),
      Variant('500 g', 79, 95),
      Variant('2 kg', 285, 340),
    ],
    details: {
      'Shelf life': '7 days',
      'Origin': 'India',
      'Storage': 'Keep refrigerated',
    },
  ),
  Product(
    id: 'p2',
    name: 'Bananas',
    unit: '6 pcs',
    image:
        'https://www.google.com/imgres?q=banana&imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FI%2F51ebZJ%2BDR4L._AC_UF894%2C1000_QL80_.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.in%2FFresh-Banana-Robusta-1kg-Pack%2Fdp%2FB07BG8WX37',
    category: 'Fruits',
    price: 45,
    mrp: 55,
    brand: 'Farm Basket',
    rating: 4.5,
    ratingCount: 940,
    description:
        'Naturally sweet Robusta bananas, ripened slowly for an even taste. '
        'A quick energy boost for breakfast, smoothies or the gym bag.',
    images: [
      'https://www.google.com/imgres?q=banana&imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FI%2F51ebZJ%2BDR4L._AC_UF894%2C1000_QL80_.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.in%2FFresh-Banana-Robusta-1kg-Pack%2Fdp%2FB07BG8WX37',
      'https://loremflickr.com/600/600/banana?lock=21',
      'https://loremflickr.com/600/600/banana?lock=22',
    ],
    variants: [
      Variant('6 pcs', 45, 55),
      Variant('12 pcs', 85, 105),
      Variant('1 dozen + 2', 99, 120),
    ],
    details: {
      'Shelf life': '4 days',
      'Origin': 'India',
      'Storage': 'Keep at room temperature',
    },
  ),
  Product(
    id: 'p3',
    name: 'Grapes',
    unit: '500 g',
    image:
        'https://www.google.com/imgres?q=grapes&imgurl=https%3A%2F%2Fmiro.medium.com%2Fv2%2Fresize%3Afit%3A1400%2F1*r_ISwbAu9M_6CgqT0J620Q.png&imgrefurl=https%3A%2F%2Fmedium.com%2Factivated-thinker',
    category: 'Fruits',
    price: 80,
    mrp: 95,
    brand: 'Vineyard Select',
    rating: 4.4,
    ratingCount: 610,
    description:
        'Seedless, plump and sweet grapes, washed and packed in a ventilated '
        'box to keep them fresh. Chill them for a refreshing snack.',
    images: [
      'https://www.google.com/imgres?q=grapes&imgurl=https%3A%2F%2Fmiro.medium.com%2Fv2%2Fresize%3Afit%3A1400%2F1*r_ISwbAu9M_6CgqT0J620Q.png&imgrefurl=https%3A%2F%2Fmedium.com%2Factivated-thinker',
      'https://loremflickr.com/600/600/grapes?lock=31',
      'https://loremflickr.com/600/600/grapes?lock=32',
    ],
    variants: [
      Variant('500 g', 80, 95),
      Variant('1 kg', 150, 180),
    ],
    details: {
      'Type': 'Seedless',
      'Shelf life': '5 days',
      'Storage': 'Keep refrigerated',
    },
  ),

  // --------------------------------------------------------- VEGETABLES
  Product(
    id: 'p4',
    name: 'Tomatoes',
    unit: '1 kg',
    image:
        'https://www.google.com/imgres?q=tomatoes&imgurl=https%3A%2F%2Fmedia.post.rvohealth.io%2Fwp-content%2Fuploads%2F2020%2F09%2FAN313-Tomatoes-732x549-Thumb.jpg&imgrefurl=https%3A%2F%2Fwww.healthline.com%2Fnutrition%2Ffoods%2Ftomatoes',
    category: 'Vegetables',
    price: 40,
    mrp: 48,
    brand: 'Farm Basket',
    rating: 4.3,
    ratingCount: 1520,
    description:
        'Firm, red, farm-fresh tomatoes with a good balance of tang and '
        'sweetness. Perfect for curries, salads, chutneys and sauces.',
    images: [
      'https://www.google.com/imgres?q=tomatoes&imgurl=https%3A%2F%2Fmedia.post.rvohealth.io%2Fwp-content%2Fuploads%2F2020%2F09%2FAN313-Tomatoes-732x549-Thumb.jpg&imgrefurl=https%3A%2F%2Fwww.healthline.com%2Fnutrition%2Ffoods%2Ftomatoes',
      'https://loremflickr.com/600/600/tomato?lock=41',
      'https://loremflickr.com/600/600/tomato?lock=42',
    ],
    variants: [
      Variant('1 kg', 40, 48),
      Variant('500 g', 22, 26),
      Variant('2 kg', 76, 92),
    ],
    details: {
      'Shelf life': '5 days',
      'Origin': 'India',
      'Storage': 'Keep in a cool, dry place',
    },
  ),
  Product(
    id: 'p5',
    name: 'Broccoli',
    unit: '1 pc',
    image:
        'https://www.google.com/imgres?q=Broccoli&imgurl=https%3A%2F%2Fwww.sharbatlyfruit.com%2Ffruits%2Fmedia-gallery%2FBroccoli%2520green_2.jpg&imgrefurl=https%3A%2F%2Fwww.sharbatlyfruit.com%2Fen%2Ffresh-produce%2Fbroccoli',
    category: 'Vegetables',
    price: 60,
    mrp: 60,
    brand: 'Green Leaf',
    rating: 4.2,
    ratingCount: 380,
    description:
        'Tight, dark green broccoli heads rich in fibre and vitamins. '
        'Steam, roast or stir-fry them for a quick healthy side.',
    images: [
      'https://www.google.com/imgres?q=Broccoli&imgurl=https%3A%2F%2Fwww.sharbatlyfruit.com%2Ffruits%2Fmedia-gallery%2FBroccoli%2520green_2.jpg&imgrefurl=https%3A%2F%2Fwww.sharbatlyfruit.com%2Fen%2Ffresh-produce%2Fbroccoli',
      'https://loremflickr.com/600/600/broccoli?lock=51',
      'https://loremflickr.com/600/600/broccoli?lock=52',
    ],
    variants: [
      Variant('1 pc', 60, 60),
      Variant('2 pcs', 115, 120),
    ],
    details: {
      'Shelf life': '4 days',
      'Origin': 'India',
      'Storage': 'Keep refrigerated',
    },
  ),
  Product(
    id: 'p6',
    name: 'Carrots',
    unit: '500 g',
    image:
        'https://www.google.com/imgres?q=Carrots&imgurl=https%3A%2F%2Fimages.immediate.co.uk%2Fproduction%2Fvolatile%2Fsites%2F30%2F2025%2F07%2FCarrots-a5d12ea.gif%3Fquality%3D90%26resize%3D708%2C643&imgrefurl=https%3A%2F%2Fwww.bbcgoodfood.com%2F',
    category: 'Vegetables',
    price: 35,
    mrp: 42,
    brand: 'Farm Basket',
    rating: 4.4,
    ratingCount: 720,
    description:
        'Sweet, crunchy orange carrots, washed and trimmed. Great raw, '
        'in salads, soups, halwa or as a juicy snack.',
    images: [
      'https://www.google.com/imgres?q=Carrots&imgurl=https%3A%2F%2Fimages.immediate.co.uk%2Fproduction%2Fvolatile%2Fsites%2F30%2F2025%2F07%2FCarrots-a5d12ea.gif%3Fquality%3D90%26resize%3D708%2C643&imgrefurl=https%3A%2F%2Fwww.bbcgoodfood.com%2F',
      'https://loremflickr.com/600/600/carrot?lock=61',
      'https://loremflickr.com/600/600/carrot?lock=62',
    ],
    variants: [
      Variant('500 g', 35, 42),
      Variant('1 kg', 66, 80),
    ],
    details: {
      'Shelf life': '7 days',
      'Origin': 'India',
      'Storage': 'Keep refrigerated',
    },
  ),

  // -------------------------------------------------------------- DAIRY
  Product(
    id: 'p7',
    name: 'Toned Milk',
    unit: '500 ml',
    image:
        'https://www.google.com/imgres?q=Toned%20Milk&imgurl=https%3A%2F%2Fcdn.grofers.com%2Fcdn-cgi%2Fimage%2Ff%3Dauto%2Cfit%3Dscale-down%2Cq%3D70%2Cmetadata%3Dnone%2Cw%3D1080%2Fda%2Fcms-assets%2Fcms%2Fproduct%2Fa538dae1-f4a3-49c9-aaf0-586b2855f825.png%3Fbg_token%3Dcolor.background.quaternary&imgrefurl=https%3A%2F%2Fblinkit.com%2Fprn%2Fmother-dairy-toned-milk%2Fprid%2F19925',
    category: 'Dairy',
    price: 35,
    mrp: 35,
    brand: 'Mother Dairy',
    rating: 4.7,
    ratingCount: 3100,
    description:
        'Pasteurised toned milk with 3% fat, a good everyday choice for tea, '
        'coffee, cereal and cooking. Delivered chilled.',
    images: [
      'https://www.google.com/imgres?q=Toned%20Milk&imgurl=https%3A%2F%2Fcdn.grofers.com%2Fcdn-cgi%2Fimage%2Ff%3Dauto%2Cfit%3Dscale-down%2Cq%3D70%2Cmetadata%3Dnone%2Cw%3D1080%2Fda%2Fcms-assets%2Fcms%2Fproduct%2Fa538dae1-f4a3-49c9-aaf0-586b2855f825.png%3Fbg_token%3Dcolor.background.quaternary&imgrefurl=https%3A%2F%2Fblinkit.com%2Fprn%2Fmother-dairy-toned-milk%2Fprid%2F19925',
      'https://loremflickr.com/600/600/milk?lock=71',
    ],
    variants: [
      Variant('500 ml', 35, 35),
      Variant('1 L', 68, 70),
      Variant('2 x 1 L', 134, 140),
    ],
    details: {
      'Fat content': '3%',
      'Shelf life': '2 days',
      'Storage': 'Keep refrigerated',
    },
  ),
  Product(
    id: 'p8',
    name: 'Farm Eggs',
    unit: '12 pcs',
    image:
        'https://www.google.com/imgres?q=Farm%20Eggs&imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FI%2F61j2dNzzd5L._AC_UF894%2C1000_QL80_.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.in%2FFarm-made-foods-Range-Pieces%2Fdp%2FB07M8NF5WL',
    category: 'Dairy',
    price: 84,
    mrp: 96,
    brand: 'Happy Hens',
    rating: 4.5,
    ratingCount: 2050,
    description:
        'Farm-fresh white eggs, graded by size and checked for quality. '
        'A great source of protein for breakfast, baking and cooking.',
    images: [
      'https://www.google.com/imgres?q=Farm%20Eggs&imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FI%2F61j2dNzzd5L._AC_UF894%2C1000_QL80_.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.in%2FFarm-made-foods-Range-Pieces%2Fdp%2FB07M8NF5WL',
      'https://loremflickr.com/600/600/eggs?lock=81',
      'https://loremflickr.com/600/600/eggs?lock=82',
    ],
    variants: [
      Variant('12 pcs', 84, 96),
      Variant('6 pcs', 45, 50),
      Variant('30 pcs', 205, 235),
    ],
    details: {
      'Type': 'White eggs',
      'Shelf life': '14 days',
      'Storage': 'Keep refrigerated',
    },
  ),
  Product(
    id: 'p9',
    name: 'Cheese Slices',
    unit: '200 g',
    image:
        'https://www.google.com/imgres?q=Cheese%20Slices&imgurl=https%3A%2F%2Fgourmet-foods.in%2Fwp-content%2Fuploads%2F2025%2F12%2FPresident-Cheese-Slice-Open-Pack.webp&imgrefurl=https%3A%2F%2Fgourmet-foods.in%2Fproduct%2Fpresident-cheese-slice%2F',
    category: 'Dairy',
    price: 120,
    mrp: 140,
    brand: 'Creamy Co.',
    rating: 4.3,
    ratingCount: 870,
    description:
        'Smooth, melt-ready cheese slices individually wrapped. Ideal for '
        'sandwiches, burgers, toasts and quick snacks.',
    images: [
      'https://www.google.com/imgres?q=Cheese%20Slices&imgurl=https%3A%2F%2Fgourmet-foods.in%2Fwp-content%2Fuploads%2F2025%2F12%2FPresident-Cheese-Slice-Open-Pack.webp&imgrefurl=https%3A%2F%2Fgourmet-foods.in%2Fproduct%2Fpresident-cheese-slice%2F',
      'https://loremflickr.com/600/600/cheese?lock=91',
    ],
    variants: [
      Variant('200 g', 120, 140),
      Variant('100 g', 65, 75),
      Variant('400 g', 225, 270),
    ],
    details: {
      'Slices': '10 per 200 g',
      'Shelf life': '6 months',
      'Storage': 'Keep refrigerated',
    },
  ),

  // ------------------------------------------------------------- SNACKS
  Product(
    id: 'p10',
    name: 'Salted Chips',
    unit: '100 g',
    image:
        'https://www.google.com/imgres?q=Salted%20Chips&imgurl=https%3A%2F%2Fby2coffee.in%2Fwp-content%2Fuploads%2F2023%2F05%2Fsalted-potato-chips.jpg&imgrefurl=https%3A%2F%2Fby2coffee.in%2Fproduct%2Fpotato-salt-chips%2F',
    category: 'Snacks',
    price: 30,
    mrp: 35,
    brand: 'Crunchy Bites',
    rating: 4.1,
    ratingCount: 1900,
    description:
        'Thin, crispy potato chips lightly salted for that classic taste. '
        'Packed in a nitrogen-flushed bag to stay crunchy.',
    images: [
      'https://www.google.com/imgres?q=Salted%20Chips&imgurl=https%3A%2F%2Fby2coffee.in%2Fwp-content%2Fuploads%2F2023%2F05%2Fsalted-potato-chips.jpg&imgrefurl=https%3A%2F%2Fby2coffee.in%2Fproduct%2Fpotato-salt-chips%2F',
      'https://loremflickr.com/600/600/chips?lock=101',
    ],
    variants: [
      Variant('100 g', 30, 35),
      Variant('50 g', 18, 20),
      Variant('200 g', 56, 68),
    ],
    details: {
      'Flavour': 'Classic salted',
      'Shelf life': '4 months',
      'Type': 'Vegetarian',
    },
  ),
  Product(
    id: 'p11',
    name: 'Popcorn',
    unit: '120 g',
    image:
        'https://www.google.com/imgres?q=Popcorn&imgurl=https%3A%2F%2Frecipeforperfection.com%2Fwp-content%2Fuploads%2F2017%2F11%2FMovie-Theater-Popcorn-in-a-popcorn-bucket.jpg&imgrefurl=https%3A%2F%2Frecipeforperfection.com%2Fbetter-than-movie-theater-popcorn%2F',
    category: 'Snacks',
    price: 50,
    mrp: 60,
    brand: 'Pop Time',
    rating: 4.2,
    ratingCount: 540,
    description:
        'Ready-to-eat buttery popcorn, light and fluffy. A perfect movie '
        'night companion or evening snack.',
    images: [
      'https://www.google.com/imgres?q=Popcorn&imgurl=https%3A%2F%2Frecipeforperfection.com%2Fwp-content%2Fuploads%2F2017%2F11%2FMovie-Theater-Popcorn-in-a-popcorn-bucket.jpg&imgrefurl=https%3A%2F%2Frecipeforperfection.com%2Fbetter-than-movie-theater-popcorn%2F',
      'https://loremflickr.com/600/600/popcorn?lock=111',
    ],
    variants: [
      Variant('120 g', 50, 60),
      Variant('60 g', 28, 32),
      Variant('240 g', 95, 115),
    ],
    details: {
      'Flavour': 'Butter',
      'Shelf life': '3 months',
      'Type': 'Vegetarian',
    },
  ),

  // ------------------------------------------------------------- DRINKS
  Product(
    id: 'p12',
    name: 'Cola',
    unit: '750 ml',
    image:
        'https://www.google.com/imgres?q=cola&imgurl=http%3A%2F%2Fwww.luckystore.in%2Fcdn%2Fshop%2Ffiles%2FCoca-Cola-Original-250ML-_imported_-luckystore-59861625.png%3Fv%3D1752229129&imgrefurl=https%3A%2F%2Fwww.luckystore.in%2Fproducts%2Fcoca-cola-original-250ml-imported',
    category: 'Drinks',
    price: 40,
    mrp: 45,
    brand: 'Fizz Up',
    rating: 4.3,
    ratingCount: 2600,
    description:
        'Chilled, sparkling cola with a bold classic taste. Best served '
        'cold with ice alongside snacks and meals.',
    images: [
      'https://www.google.com/imgres?q=cola&imgurl=http%3A%2F%2Fwww.luckystore.in%2Fcdn%2Fshop%2Ffiles%2FCoca-Cola-Original-250ML-_imported_-luckystore-59861625.png%3Fv%3D1752229129&imgrefurl=https%3A%2F%2Fwww.luckystore.in%2Fproducts%2Fcoca-cola-original-250ml-imported',
      'https://loremflickr.com/600/600/cola?lock=121',
    ],
    variants: [
      Variant('750 ml', 40, 45),
      Variant('330 ml', 20, 22),
      Variant('2 L', 95, 105),
    ],
    details: {
      'Type': 'Carbonated',
      'Shelf life': '6 months',
      'Storage': 'Serve chilled',
    },
  ),
  Product(
    id: 'p13',
    name: 'Orange Juice',
    unit: '1 L',
    image:
        'https://www.google.com/imgres?q=Orange%20Juice&imgurl=https%3A%2F%2Fimages-prod.healthline.com%2Fhlcmsresource%2Fimages%2FAN_images%2Forange-juice-1296x728-feature.jpg&imgrefurl=https%3A%2F%2Fwww.healthline.com%2Fnutrition%2Forange-juice',
    category: 'Drinks',
    price: 99,
    mrp: 120,
    brand: 'Sunny Squeeze',
    rating: 4.5,
    ratingCount: 760,
    description:
        'Refreshing orange juice made from ripe oranges, with no added '
        'preservatives. Shake well and serve chilled.',
    images: [
      'https://www.google.com/imgres?q=Orange%20Juice&imgurl=https%3A%2F%2Fimages-prod.healthline.com%2Fhlcmsresource%2Fimages%2FAN_images%2Forange-juice-1296x728-feature.jpg&imgrefurl=https%3A%2F%2Fwww.healthline.com%2Fnutrition%2Forange-juice',
      'https://loremflickr.com/600/600/orangejuice?lock=131',
    ],
    variants: [
      Variant('1 L', 99, 120),
      Variant('200 ml', 25, 30),
      Variant('2 x 1 L', 190, 240),
    ],
    details: {
      'Type': '100% juice',
      'Shelf life': '5 months',
      'Storage': 'Refrigerate after opening',
    },
  ),

  // ------------------------------------------------------------- BAKERY
  Product(
    id: 'p14',
    name: 'Brown Bread',
    unit: '400 g',
    image:
        'https://www.google.com/imgres?q=Brown%20Bread&imgurl=https%3A%2F%2Fsallysbakingaddiction.com%2Fwp-content%2Fuploads%2F2024%2F01%2Fwhole-wheat-sandwich-bread-2.jpg&imgrefurl=https%3A%2F%2Fsallysbakingaddiction.com%2Fwhole-wheat-bread%2F',
    category: 'Bakery',
    price: 45,
    mrp: 50,
    brand: 'Daily Bake',
    rating: 4.4,
    ratingCount: 1100,
    description:
        'Soft whole wheat sandwich bread baked fresh every morning. '
        'Higher in fibre than white bread, great for toasts and sandwiches.',
    images: [
      'https://www.google.com/imgres?q=Brown%20Bread&imgurl=https%3A%2F%2Fsallysbakingaddiction.com%2Fwp-content%2Fuploads%2F2024%2F01%2Fwhole-wheat-sandwich-bread-2.jpg&imgrefurl=https%3A%2F%2Fsallysbakingaddiction.com%2Fwhole-wheat-bread%2F',
      'https://loremflickr.com/600/600/bread?lock=141',
    ],
    variants: [
      Variant('400 g', 45, 50),
      Variant('200 g', 26, 28),
      Variant('2 x 400 g', 86, 100),
    ],
    details: {
      'Type': 'Whole wheat',
      'Shelf life': '4 days',
      'Storage': 'Keep in a cool, dry place',
    },
  ),
  Product(
    id: 'p15',
    name: 'Croissant',
    unit: '2 pcs',
    image:
        'https://www.google.com/imgres?q=Croissant&imgurl=https%3A%2F%2Fwww.simplejoy.com%2Fwp-content%2Fuploads%2F2021%2F04%2FCroissant-French-Toast-5.jpg&imgrefurl=https%3A%2F%2Fwww.simplejoy.com%2Fcroissant-french-toast%2F',
    category: 'Bakery',
    price: 70,
    mrp: 85,
    brand: 'Le Petit Four',
    rating: 4.6,
    ratingCount: 430,
    description:
        'Flaky, buttery croissants with a golden crust and soft layers '
        'inside. Warm them for two minutes for a bakery-fresh taste.',
    images: [
      'https://www.google.com/imgres?q=Croissant&imgurl=https%3A%2F%2Fwww.simplejoy.com%2Fwp-content%2Fuploads%2F2021%2F04%2FCroissant-French-Toast-5.jpg&imgrefurl=https%3A%2F%2Fwww.simplejoy.com%2Fcroissant-french-toast%2F',
      'https://loremflickr.com/600/600/croissant?lock=151',
    ],
    variants: [
      Variant('2 pcs', 70, 85),
      Variant('4 pcs', 135, 165),
      Variant('6 pcs', 195, 245),
    ],
    details: {
      'Type': 'Butter croissant',
      'Shelf life': '2 days',
      'Storage': 'Keep in a cool, dry place',
    },
  ),
];