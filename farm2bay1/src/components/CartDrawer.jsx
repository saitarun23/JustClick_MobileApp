import { X, Plus, Minus, ShoppingBasket } from 'lucide-react'

export default function CartDrawer({ open, close, products, cart, add, remove }) {
  const lines = products.filter((p) => cart[p.id])
  const total = lines.reduce((sum, p) => sum + p.price * cart[p.id], 0)

  return (
    <>
      <div className={`overlay ${open ? 'overlay--on' : ''}`} onClick={close} />
      <aside className={`drawer ${open ? 'drawer--open' : ''}`}>
        <div className="drawer__head">
          <h3>Your basket</h3>
          <button onClick={close} aria-label="Close"><X size={22} /></button>
        </div>

        {lines.length === 0 ? (
          <div className="drawer__empty">
            <ShoppingBasket size={56} strokeWidth={1.3} />
            <p>Your basket is empty</p>
          </div>
        ) : (
          <>
            <ul className="drawer__list">
              {lines.map((p) => (
                <li key={p.id}>
                  <div>
                    <strong>{p.name}</strong>
                    <small>{p.unit} | Rs. {p.price}</small>
                  </div>
                  <div className="qty">
                    <button onClick={() => remove(p.id)}><Minus size={16} /></button>
                    <span>{cart[p.id]}</span>
                    <button onClick={() => add(p.id)}><Plus size={16} /></button>
                  </div>
                </li>
              ))}
            </ul>
            <div className="drawer__foot">
              <div className="drawer__total"><span>Total</span><strong>Rs. {total}</strong></div>
              <button className="btn btn--primary btn--full">Checkout</button>
            </div>
          </>
        )}
      </aside>
    </>
  )
}