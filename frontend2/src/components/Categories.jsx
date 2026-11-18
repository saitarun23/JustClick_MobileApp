import { CATEGORIES } from "../data/products";
import "../styles/Categories.css";

export default function Categories({ active, onChange }) {
  return (
    <div className="rail" role="tablist">
      {CATEGORIES.map(({ id, label, icon: Icon }) => (
        <button
          key={id}
          role="tab"
          aria-selected={active === id}
          className={active === id ? "pill on" : "pill"}
          onClick={() => onChange(id)}
        >
          <Icon /> {label}
        </button>
      ))}
    </div>
  );
}