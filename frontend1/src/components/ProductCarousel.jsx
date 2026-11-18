import { useState } from "react";
import Carousel from "./Carousel";
import ProductCard from "./ProductCard";

export default function ProductCarousel({ title, items, onAdd, tabs, soft }) {
  const [active, setActive] = useState("All");
  const list = tabs && active !== "All" ? items.filter((p) => p.tag === active) : items;

  return (
    <section className={`section ${soft ? "soft" : ""}`}>
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

      <Carousel key={active}>
        {list.map((p) => (
          <ProductCard key={p.id} product={p} onAdd={onAdd} />
        ))}
      </Carousel>
    </section>
  );
}