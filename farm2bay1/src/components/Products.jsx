import { Milk, Carrot, Citrus, Wheat, Package, Plus, Minus } from 'lucide-react'

const icons = { dairy: Milk, vegetables: Carrot, pickles: Citrus, powders: Wheat, others: Package }

export default function Products({ items, categories, active, setActive, cart, add, remove }) {
  return (
    <section id="products" className="section">
      <div className="container">
        <h2 className="section__title">Fresh picks for you</h2>

        <div className="chips">
          <button className={active === 'all' ? 'chip chip--on' : 'chip'} onClick={() => setActive('all')}>All</button>
          {categories.map((c) => (
            <button
              key={c.id}
              className={active === c.id ? 'chip chip--on' : 'chip'}
              onClick={() => setActive(c.id)}
            >
              {c.name}
            </button>
          ))}
        </div>

        {items.length === 0 && <p className="empty">No products found.</p>}

        <div className="grid">
          {items.map((p) => {
            const Icon = icons[p.category]
            const tint = categories.find((c) => c.id === p.category).tint
            const qty = cart[p.id] || 0
            return (
              <article className="card" key={p.id}>
                <div className="card__img" style={{ background: tint }}>
                  <Icon size={64} strokeWidth={1.4} />
                </div>
                <h3>{p.name}</h3>
                <span className="card__unit">{p.unit}</span>
                <div className="card__row">
                  <strong>Rs. {p.price}</strong>
                  {qty === 0 ? (
                    <button className="add" onClick={() => add(p.id)}>Add</button>
                  ) : (
                    <div className="qty">
                      <button onClick={() => remove(p.id)} aria-label="Decrease"><Minus size={16} /></button>
                      <span>{qty}</span>
                      <button onClick={() => add(p.id)} aria-label="Increase"><Plus size={16} /></button>
                    </div>
                  )}
                </div>
              </article>
            )
          })}
        </div>
      </div>
    </section>
  )
}