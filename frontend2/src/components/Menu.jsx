import { LuPlus, LuMinus, LuClock } from "react-icons/lu";
import { rupee } from "../data/products";
import "../styles/Menu.css";

export default function Menu({ products, cart, cat, query, onAdd, onRemove, onClear }) {
  return (
    <section id="menu" className="wrap menu-sec">
      <div className="menu-head">
        <h2 className="h2">{cat === "all" ? "Today's menu" : "Filtered menu"}</h2>
        {(cat !== "all" || query) && <button className="clear" onClick={onClear}>Show everything</button>}
      </div>
      {products.length === 0 ? (
        <p className="empty">Nothing matches “{query}”. Try a shorter word or show everything.</p>
      ) : (
        <ul className="board">
          {products.map((p) => {
            const Icon = p.icon, qty = cart[p.id] || 0;
            return (
              <li key={p.id} className="dish">
                <span className="disc"><Icon /></span>
                <div className="dish-main">
                  <h3>{p.name}</h3>
                  <p>{p.shop} <i /> <LuClock /> {p.mins} min</p>
                </div>
                <span className="leader" aria-hidden="true" />
                <b className="price">{rupee(p.price)}</b>
                {qty === 0 ? (
                  <button className="plus" onClick={() => onAdd(p.id)} aria-label={`Add ${p.name}`}><LuPlus /></button>
                ) : (
                  <div className="qty">
                    <button onClick={() => onRemove(p.id)} aria-label="Remove one"><LuMinus /></button>
                    <span>{qty}</span>
                    <button onClick={() => onAdd(p.id)} aria-label="Add one"><LuPlus /></button>
                  </div>
                )}
              </li>
            );
          })}
        </ul>
      )}
    </section>
  );
}