import { LuPizza, LuSandwich, LuSalad, LuCoffee, LuIceCreamCone, LuCookie, LuApple, LuSoup, LuCroissant } from "react-icons/lu";

export const CATEGORIES = [
  { id: "meals", label: "Hot meals", note: "Biryani, pizza, bowls", icon: LuSoup, tone: "sea", size: "tall" },
  { id: "snacks", label: "Snacks", note: "Ready in 15 min", icon: LuSandwich, tone: "mint", size: "wide" },
  { id: "fresh", label: "Fresh", note: "Fruit and greens", icon: LuApple, tone: "ink", size: "sq" },
  { id: "sweet", label: "Sweet", note: "Cookies, soft serve", icon: LuIceCreamCone, tone: "deep", size: "sq" },
  { id: "drinks", label: "Drinks", note: "Coffee and more", icon: LuCoffee, tone: "foam", size: "wide" },
];

export const PRODUCTS = [
  { id: 1, name: "Wood-fired margherita", shop: "Fornello", cat: "meals", price: 349, mins: 25, icon: LuPizza },
  { id: 2, name: "Chicken biryani bowl", shop: "Dum Kitchen", cat: "meals", price: 289, mins: 30, icon: LuSoup },
  { id: 3, name: "Grilled paneer club", shop: "Toast Lab", cat: "snacks", price: 179, mins: 18, icon: LuSandwich },
  { id: 4, name: "Green goddess salad", shop: "Leaf & Co", cat: "fresh", price: 219, mins: 15, icon: LuSalad },
  { id: 5, name: "Farm fruit box", shop: "Orchard Daily", cat: "fresh", price: 249, mins: 20, icon: LuApple },
  { id: 6, name: "Butter croissant pair", shop: "Maison Flour", cat: "snacks", price: 129, mins: 12, icon: LuCroissant },
  { id: 7, name: "Choco chunk cookies", shop: "Crumb Club", cat: "sweet", price: 159, mins: 16, icon: LuCookie },
  { id: 8, name: "Mango soft serve", shop: "Scoop Yard", cat: "sweet", price: 99, mins: 14, icon: LuIceCreamCone },
  { id: 9, name: "Filter coffee, large", shop: "Bean Street", cat: "drinks", price: 89, mins: 10, icon: LuCoffee },
  { id: 10, name: "Millet khichdi cup", shop: "Dum Kitchen", cat: "meals", price: 139, mins: 22, icon: LuSoup },
];

export const rupee = (n) => "₹" + n.toLocaleString("en-IN");