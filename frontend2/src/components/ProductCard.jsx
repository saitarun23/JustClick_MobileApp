import { LuClock, LuPlus, LuMinus, LuMousePointerClick } from "react-icons/lu";
import { rupee } from "../data/products";
import "../styles/ProductCard.css";

export default function ProductCard({ product: p, qty, onAdd, onRemove }) {
  const Icon = p.icon;
  return (
    <article className="ticket">
      <div className="ticket-top">
        <span className="ticket-eta"><LuClock /> {p.mins} min</span>
        <Icon className="ticket-art" aria-hidden="true" />
      </div>
      <div className="ticket-cut" aria-hidden="true" />
      <div className="ticket-body">
        <p className="ticket-shop">{p.shop}</p>
        <h3>{p.name}</h3>
        <div className="ticket-foot">
          <strong className="stamp">{rupee(p.price)}</strong>
          {qty === 0 ? (
            <button className="click-btn" onClick={() => onAdd(p.id)}>
              <LuMousePointerClick /> Click to add
            </button>
          ) : (
            <div className="stepper" role="group" aria-label={`Quantity of ${p.name}`}>
              <button onClick={() => onRemove(p.id)} aria-label="Remove one"><LuMinus /></button>
              <span>{qty}</span>
              <button onClick={() => onAdd(p.id)} aria-label="Add one"><LuPlus /></button>
            </div>
          )}
        </div>
      </div>
    </article>
  );
}