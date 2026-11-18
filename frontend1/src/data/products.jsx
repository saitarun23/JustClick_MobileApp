const img = (text, bg) =>
  `https://placehold.co/400x400/${bg}/5a3e2b?text=${encodeURIComponent(text)}`;

const DAIRY = "fbf1dc";
const POWDER = "f6e2b8";
const PICKLE = "f0cfc2";
const OTHER = "e6e4cf";

export const products = [
  // Dairy
  { id: 1, name: "A2 Cow Ghee", tag: "Dairy", price: 850, size: "500 ml", reviews: 124, rating: 5, benefit: "Slow-churned, golden & aromatic", image: img("A2 Ghee", DAIRY) },
  { id: 2, name: "Farm Fresh Butter", tag: "Dairy", price: 260, size: "200 g", reviews: 48, rating: 5, benefit: "Creamy, unsalted & preservative-free", image: img("Butter", DAIRY) },
  { id: 3, name: "Fresh Paneer", tag: "Dairy", price: 120, size: "250 g", reviews: 36, rating: 4, benefit: "Soft, high-protein & made daily", image: img("Paneer", DAIRY) },
  { id: 4, name: "Thick Set Curd", tag: "Dairy", price: 70, size: "500 g", reviews: 29, rating: 4, benefit: "Naturally set, thick & tangy", image: img("Curd", DAIRY) },

  // Powders
  { id: 5, name: "Turmeric Powder", tag: "Powders", price: 180, size: "200 g", reviews: 61, rating: 5, benefit: "High curcumin, stone-ground", image: img("Turmeric", POWDER) },
  { id: 6, name: "Guntur Chilli Powder", tag: "Powders", price: 220, size: "250 g", reviews: 52, rating: 5, benefit: "Bright colour & bold heat", image: img("Chilli Powder", POWDER) },
  { id: 7, name: "Idli Podi", tag: "Powders", price: 160, size: "200 g", reviews: 44, rating: 5, benefit: "Roasted lentils & sesame blend", image: img("Idli Podi", POWDER) },
  { id: 8, name: "Ragi Health Mix", tag: "Powders", price: 240, size: "300 g", reviews: 27, rating: 4, benefit: "Sprouted millet, no added sugar", image: img("Ragi Mix", POWDER) },

  // Pickles
  { id: 9, name: "Mango Avakaya Pickle", tag: "Pickles", price: 350, size: "500 g", reviews: 98, rating: 5, benefit: "Sun-matured, cold-pressed oil", image: img("Avakaya", PICKLE) },
  { id: 10, name: "Gongura Pickle", tag: "Pickles", price: 220, size: "250 g", reviews: 41, rating: 5, benefit: "Tangy sorrel leaves, Andhra style", image: img("Gongura", PICKLE) },
  { id: 11, name: "Garlic Pickle", tag: "Pickles", price: 240, size: "250 g", reviews: 33, rating: 4, benefit: "Spicy, rich & long-lasting", image: img("Garlic Pickle", PICKLE) },
  { id: 12, name: "Lemon Pickle", tag: "Pickles", price: 200, size: "300 g", reviews: 30, rating: 4, benefit: "Salt-cured and sun-ripened", image: img("Lemon Pickle", PICKLE) },

  // Others
  { id: 13, name: "Wild Forest Honey", tag: "Others", price: 450, size: "500 g", reviews: 56, rating: 5, benefit: "Raw, unprocessed & unheated", image: img("Honey", OTHER) },
  { id: 14, name: "Cold-Pressed Groundnut Oil", tag: "Others", price: 380, size: "1 L", reviews: 39, rating: 5, benefit: "Wooden-press, no chemicals", image: img("Groundnut Oil", OTHER) },
  { id: 15, name: "Jaggery Powder", tag: "Others", price: 110, size: "500 g", reviews: 25, rating: 4, benefit: "Natural sweetener, chemical-free", image: img("Jaggery", OTHER) },
  { id: 16, name: "Murukku Snack Pack", tag: "Others", price: 150, size: "250 g", reviews: 18, rating: 4, benefit: "Crunchy, homemade & fresh", image: img("Murukku", OTHER) },
];

export const combos = [
  { id: 101, name: "Pickle Trio Pack", tag: "Combo", price: 650, size: "3 jars", rating: 5, benefit: "Avakaya, gongura & garlic", image: img("Pickle Trio", PICKLE) },
  { id: 102, name: "Breakfast Essentials Box", tag: "Combo", price: 599, size: "4 items", rating: 5, benefit: "Idli podi, ragi mix, ghee & more", image: img("Breakfast Box", POWDER) },
  { id: 103, name: "Dairy Starter Pack", tag: "Combo", price: 1100, size: "3 items", rating: 4, benefit: "Ghee, butter & paneer", image: img("Dairy Pack", DAIRY) },
  { id: 104, name: "Festival Gift Hamper", tag: "Combo", price: 1999, size: "8 items", rating: 5, benefit: "Best-sellers in a gift box", image: img("Gift Hamper", OTHER) },
];

export const collections = [
  { id: 1, title: "Pickles", text: "Sun-matured homemade flavours", image: "https://placehold.co/324x420/f0cfc2/5a3e2b?text=Pickles" },
  { id: 2, title: "Powders", text: "Freshly ground every week", image: "https://placehold.co/324x420/f6e2b8/5a3e2b?text=Powders" },
  { id: 3, title: "Dairy", text: "From local farms to your door", image: "https://placehold.co/324x420/fbf1dc/5a3e2b?text=Dairy" },
  { id: 4, title: "Gift Hampers", text: "Perfect for festivals & family", image: "https://placehold.co/324x420/e6e4cf/5a3e2b?text=Hampers" },
];

export const ingredients = [
  { name: "A2 Cow Milk", text: "Sourced daily from local farms." },
  { name: "Raw Mangoes", text: "Hand-picked and sun-cured for pickles." },
  { name: "Guntur Chillies", text: "Sun-dried and stone-ground in small batches." },
  { name: "Cold-Pressed Oil", text: "Wooden-press oil with no chemicals." },
];

export const reviews = [
  { id: 1, name: "Lakshmi R.", text: "The ghee tastes exactly like homemade. The aroma is amazing." },
  { id: 2, name: "Suresh K.", text: "Avakaya pickle reminded me of my grandmother's recipe. Ordering again." },
  { id: 3, name: "Priya S.", text: "Idli podi and ragi mix are fresh and clean. Great packaging too." },
];

export const menu = [
  { label: "Shop" },
  { label: "Dairy", items: ["Ghee", "Butter", "Paneer", "Curd", "Milk"] },
  { label: "Powders", items: ["Turmeric Powder", "Chilli Powder", "Idli Podi", "Sambar Powder", "Health Mix"] },
  { label: "Pickles", items: ["Mango Pickle", "Gongura Pickle", "Garlic Pickle", "Lemon Pickle", "Tomato Pickle"] },
  { label: "Others", items: ["Honey", "Jaggery", "Cold-Pressed Oils", "Snacks", "Spices"] },
  { label: "Combos", items: ["Pickle Combos", "Breakfast Box", "Festival Hampers"] },
  { label: "Offers" },
];