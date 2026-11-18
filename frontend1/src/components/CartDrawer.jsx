import { X, Plus, Minus, Trash2, ShoppingBag, Lock } from "lucide-react";

export default function CartDrawer({ open, close, cart, changeQty, remove }) {
  const total = cart.reduce((s, i) => s + i.price * i.qty, 0);

  return (
    <>
      <div className={`overlay ${open ? "on" : ""}`} onClick={close} />
      <aside className={`drawer ${open ? "open" : ""}`}>
        <div className="drawer-head">
          <h3>Your Cart ({cart.length})</h3>
          <button className="icon-btn" onClick={close} aria-label="Close"><X size={22} /></button>
        </div>

        <div className="drawer-body">
          {cart.length === 0 && (
            <div className="empty">
              <ShoppingBag size={48} strokeWidth={1.3} />
              <p>Your cart is currently empty.</p>
            </div>
          )}

          {cart.map((i) => (
            <div className="cart-item" key={i.id}>
              <img src={i.image} alt={i.name} />
              <div className="ci-info">
                <h4>{i.name}</h4>
                <p>₹{i.price.toLocaleString("en-IN")} · {i.size}</p>
                <div className="qty">
                  <button onClick={() => changeQty(i.id, -1)} aria-label="Decrease"><Minus size={14} /></button>
                  <span>{i.qty}</span>
                  <button onClick={() => changeQty(i.id, 1)} aria-label="Increase"><Plus size={14} /></button>
                </div>
              </div>
              <button className="icon-btn rm" onClick={() => remove(i.id)} aria-label="Remove">
                <Trash2 size={18} />
              </button>
            </div>
          ))}
        </div>

        <div className="drawer-foot">
          <div className="total">
            <span>Total</span>
            <b>₹{total.toLocaleString("en-IN")}</b>
          </div>
          <button className="btn full">
            <Lock size={15} /> Secure Checkout
          </button>
        </div>
      </aside>
    </>
  );
}