import { Milk, Wheat, Citrus, Flame, Droplets, Cookie, Gift } from "lucide-react";

const categories = [
  { name: "Dairy", icon: Milk },
  { name: "Powders", icon: Wheat },
  { name: "Pickles", icon: Citrus },
  { name: "Spices", icon: Flame },
  { name: "Honey & Oils", icon: Droplets },
  { name: "Snacks", icon: Cookie },
  { name: "Combos", icon: Gift },
];

export default function Categories() {
  return (
    <section className="section container">
      <h2 className="title">Shop By Category</h2>
      <div className="cats">
        {categories.map(({ name, icon: Icon }) => (
          <a href="#" key={name} className="cat">
            <div className="cat-circle">
              <Icon size={36} strokeWidth={1.6} />
            </div>
            <span>{name}</span>
          </a>
        ))}
      </div>
    </section>
  );
}