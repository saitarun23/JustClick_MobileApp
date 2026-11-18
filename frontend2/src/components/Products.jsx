import ProductCard from "./ProductCard";
import "../styles/Products.css";

export default function Products({ products, cart, query, onAdd, onRemove }) {
  if (products.length === 0) {
    return <p className="empty">Nothing matches “{query}”. Try a shorter word or pick another shelf.</p>;
  }
  return (
    <div className="grid">
      {products.map((p) => (
        <ProductCard
          key={p.id}
          product={p}
          qty={cart[p.id] || 0}
          onAdd={onAdd}
          onRemove={onRemove}
        />
      ))}
    </div>
  );
}