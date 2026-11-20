import { Milk, Carrot, Citrus, Wheat, Package } from 'lucide-react'

const icons = { Milk, Carrot, Citrus, Wheat, Package }

export default function Categories({ categories, active, setActive }) {
  return (
    <section id="categories" className="section">
      <div className="container">
        <h2 className="section__title">Shop by category</h2>
        <div className="cat-grid">
          {categories.map((c) => {
            const Icon = icons[c.icon]
            return (
              <a
                href="#products"
                key={c.id}
                className={`cat ${active === c.id ? 'cat--active' : ''}`}
                style={{ '--tint': c.tint }}
                onClick={() => setActive(active === c.id ? 'all' : c.id)}
              >
                <span className="cat__icon"><Icon size={34} strokeWidth={1.8} /></span>
                <strong>{c.name}</strong>
                <small>{c.blurb}</small>
              </a>
            )
          })}
        </div>
      </div>
    </section>
  )
}