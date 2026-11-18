import { LuX, LuMinus, LuPlus, LuCheck } from "react-icons/lu";
import { PRODUCTS, rupee } from "../data/products";
import "../styles/Cart.css";

export default function Cart({ open, cart, placed, onAdd, onRemove, onPlace, onClose }) {
  const lines = PRODUCTS.filter((p) => cart[p.id]);
  const subtotal = lines.reduce((s, p) => s + cart[p.id] * p.price, 0);
  const delivery = subtotal > 0 && subtotal < 499 ? 29 : 0;
  return (
    <>
      {open && <div className="scrim" onClick={onClose} />}
      <aside className={open ? "drawer open" : "drawer"} aria-hidden={!open}>
        <div className="d-head"><h2>Your order</h2><button onClick={onClose} aria-label="Close order"><LuX /></button></div>
        {placed ? (
          <div className="done">
            <span className="badge"><LuCheck /></span>
            <h3>Order placed</h3>
            <p>Your rider is heading to the shop. Estimated arrival: 25 minutes.</p>
            <button className="checkout" onClick={onClose}>Keep browsing</button>
          </div>
        ) : lines.length === 0 ? (
          <p className="empty">Your order is empty. Press + on any dish to add it.</p>
        ) : (
          <>
            <ul className="lines">
              {lines.map((p) => (
                <li key={p.id}>
                  <div><strong>{p.name}</strong><small>{p.shop}</small></div>
                  <div className="qty">
                    <button onClick={() => onRemove(p.id)} aria-label="Remove one"><LuMinus /></button>
                    <span>{cart[p.id]}</span>
                    <button onClick={() => onAdd(p.id)} aria-label="Add one"><LuPlus /></button>
                  </div>
                  <b>{rupee(p.price * cart[p.id])}</b>
                </li>
              ))}
            </ul>
            <dl className="sum">
              <div><dt>Items</dt><dd>{rupee(subtotal)}</dd></div>
              <div><dt>Delivery</dt><dd>{delivery === 0 ? "Free" : rupee(delivery)}</dd></div>
              <div className="total"><dt>Total</dt><dd>{rupee(subtotal + delivery)}</dd></div>
            </dl>
            <button className="checkout" onClick={onPlace}>Place order</button>
            {subtotal < 499 && <p className="hint">Add {rupee(499 - subtotal)} more for free delivery.</p>}
          </>
        )}
      </aside>
    </>
  );
}