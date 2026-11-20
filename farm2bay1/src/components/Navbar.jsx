import { Leaf, Search, ShoppingBasket, MapPin } from 'lucide-react'

export default function Navbar({ query, setQuery, count, openCart }) {
  return (
    <header className="nav">
      <div className="container nav__inner">
        <a href="#home" className="brand">
          <span className="brand__mark"><Leaf size={22} /></span>
          <span className="brand__name">farm2bay</span>
        </a>

        <div className="nav__loc">
          <MapPin size={18} />
          <div><small>Deliver to</small><strong>Your city</strong></div>
        </div>

        <label className="search">
          <Search size={18} />
          <input
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Search milk, tomatoes, pickles..."
          />
        </label>

        <nav className="nav__links">
          <a href="#categories">Categories</a>
          <a href="#how">How it works</a>
          <a href="#products">Shop</a>
        </nav>

        <button className="cart-btn" onClick={openCart} aria-label="Open cart">
          <ShoppingBasket size={20} />
          <span>Cart</span>
          {count > 0 && <b>{count}</b>}
        </button>
      </div>
    </header>
  )
}