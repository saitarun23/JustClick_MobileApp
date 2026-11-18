import { ArrowRight } from "lucide-react";
import { collections } from "../data/products";

export default function Collections() {
  return (
    <section className="section container">
      <h2 className="title">Shop By Collections</h2>
      <div className="ritual-grid">
        {collections.map((c) => (
          <div className="ritual" key={c.id}>
            <img src={c.image} alt={c.title} />
            <div className="ritual-info">
              <h3>{c.title}</h3>
              <p>{c.text}</p>
              <a href="#">
                Shop Now <ArrowRight size={14} />
              </a>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}