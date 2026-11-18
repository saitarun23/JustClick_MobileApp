import { useState } from "react";
import ProductCard from "./ProductCard";

export default function ProductGrid({ title, items, onAdd, soft, tabs }) {
  const [active, setActive] = useState("All");
  const list = tabs && active !== "All" ? items.filter((p) => p.tag === active) : items;

  return (
    <section className={`section ${soft ? "soft" : ""}`}>
      <div className="container">
        <h2 className="title">{title}</h2>

        {tabs && (
          <div className="tabs">
            {tabs.map((t) => (
              <button key={t} className={t === active ? "tab on" : "tab"} onClick={() => setActive(t)}>
                {t}
              </button>
            ))}
          </div>
        )}

        <div className="grid">
          {list.map((p) => (
            <ProductCard key={p.id} product={p} onAdd={onAdd} />
          ))}
        </div>
      </div>
    </section>
  );
}