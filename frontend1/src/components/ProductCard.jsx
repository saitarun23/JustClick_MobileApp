import { Star, ShoppingBag } from "lucide-react";

export default function ProductCard({ product, onAdd }) {
  const p = product;
  return (
    <div className="pcard">
      <div className="pcard-img">
        <img src={p.image} alt={p.name} />
        <span className="tag">{p.oldPrice ? "Limited Offer" : p.tag}</span>
      </div>

      <h3>{p.name}</h3>

      <div className="stars">
        {[1, 2, 3, 4, 5].map((n) => (
          <Star key={n} size={15} fill={n <= p.rating ? "currentColor" : "none"} />
        ))}
        {p.reviews && <small>{p.reviews} reviews</small>}
      </div>

      <p className="benefit">{p.benefit}</p>

      <p className="price">
        ₹{p.price.toLocaleString("en-IN")}.00
        {p.oldPrice && <s>₹{p.oldPrice.toLocaleString("en-IN")}.00</s>}
      </p>
      <p className="size">{p.size}</p>

      <button className="btn full" onClick={() => onAdd(p)}>
        <ShoppingBag size={17} /> Add to cart
      </button>
    </div>
  );
}