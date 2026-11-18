import { useState } from "react";
import { Menu, X, Search, User, ShoppingBag, ChevronDown, MousePointerClick } from "lucide-react";
import { menu } from "../data/products";

export default function Navbar({ cartCount, openCart }) {
  const [open, setOpen] = useState(false);

  return (
    <header className="header">
      <div className="nav-top container">
        <button className="icon-btn burger" onClick={() => setOpen(!open)} aria-label="Menu">
          {open ? <X size={24} /> : <Menu size={24} />}
        </button>

        <a href="#" className="logo">
          <span className="logo-mark"><MousePointerClick size={20} /></span>
          Just<span>Click</span>
        </a>

        <div className="nav-actions">
          <div className="search-box">
            <Search size={16} />
            <input placeholder="Search ghee, pickles, powders..." />
          </div>
          <button className="icon-btn" aria-label="Account"><User size={22} /></button>
          <button className="icon-btn cart-btn" onClick={openCart} aria-label="Cart">
            <ShoppingBag size={22} />
            <span className="badge">{cartCount}</span>
          </button>
        </div>
      </div>

      <nav className={`nav-links ${open ? "show" : ""}`}>
        <ul className="container">
          {menu.map((m) => (
            <li key={m.label} className="nav-item">
              <a href="#">
                {m.label}
                {m.items && <ChevronDown size={14} />}
              </a>
              {m.items && (
                <div className="dropdown">
                  {m.items.map((i) => (
                    <a href="#" key={i}>{i}</a>
                  ))}
                </div>
              )}
            </li>
          ))}
        </ul>
      </nav>
    </header>
  );
}