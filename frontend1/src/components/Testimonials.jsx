import { Star, Quote } from "lucide-react";
import { reviews } from "../data/products";

export default function Testimonials() {
  return (
    <section className="section container">
      <h2 className="title">Customers Are Saying</h2>
      <p className="rating">
        <Star size={20} fill="currentColor" /> 4.8 <small>(800+ verified reviews)</small>
      </p>
      <div className="grid three">
        {reviews.map((r) => (
          <div className="review" key={r.id}>
            <Quote size={24} className="quote" />
            <div className="stars">
              {[1, 2, 3, 4, 5].map((n) => (
                <Star key={n} size={14} fill="currentColor" />
              ))}
            </div>
            <p>{r.text}</p>
            <b>{r.name}</b>
          </div>
        ))}
      </div>
    </section>
  );
}