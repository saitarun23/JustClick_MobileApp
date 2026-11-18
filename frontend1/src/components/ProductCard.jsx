import { Star, ShoppingBag } from "lucide-react";

export default function ProductCard({ product, onAdd }) {
  return (
    <div className="card">
      <div className="card-img">
        <img src={product.image} alt={product.name} />
        <span className="tag">{product.tag}</span>
      </div>

      <h3>{product.name}</h3>

      <div className="stars">
        {[1, 2, 3, 4, 5].map((n) => (
          <Star key={n} size={14} fill={n <= product.rating ? "currentColor" : "none"} />
        ))}
        {product.reviews && <small>({product.reviews})</small>}
      </div>

      <p className="benefit">{product.benefit}</p>
      <p className="price">
        ₹{product.price.toLocaleString("en-IN")} <small>· {product.size}</small>
      </p>

      <button className="btn-outline" onClick={() => onAdd(product)}>
        <ShoppingBag size={16} /> Add to cart
      </button>
    </div>
  );
}