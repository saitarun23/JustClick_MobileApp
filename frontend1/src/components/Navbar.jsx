import { useEffect, useState } from "react";
import { Menu, X, Search, User, ShoppingBag, ChevronDown, MousePointerClick } from "lucide-react";
import { menu } from "../data/products";

export default function Navbar({ cartCount, openCart }) {
  const [open, setOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [compact, setCompact] = useState(false);

  useEffect(() => {
    const onScroll = () => setCompact(window.scrollY > 80);
    window.addEventListener("scroll", onScroll);
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  return (
    <header className={`header ${compact ? "compact" : ""}`}>
      <div className="nav-top">
        <div className="nav-left">
          <button className="icon-btn burger" onClick={() => setOpen(!open)} aria-label="Menu">
            {open ? <X size={26} /> : <Menu size={26} />}
          </button>
        </div>

        <a href="#" className="logo">
          <span className="logo-mark"><MousePointerClick size={22} /></span>
          <span className="logo-text">Just Click</span>
        </a>

        <div className="nav-actions">
          <button className="icon-btn" onClick={() => setSearchOpen(!searchOpen)} aria-label="Search">
            <Search size={24} />
          </button>
          <button className="icon-btn" aria-label="Account"><User size={24} /></button>
          <button className="icon-btn cart-btn" onClick={openCart} aria-label="Cart">
            <ShoppingBag size={24} />
            <span className="badge">{cartCount}</span>
          </button>
        </div>
      </div>

      {searchOpen && (
        <div className="search-bar">
          <Search size={18} />
          <input autoFocus placeholder="Search ghee, pickles, powders..." />
        </div>
      )}

      <nav className={`nav-links ${open ? "show" : ""}`}>
        <ul>
          {menu.map((m) => (
            <li key={m.label} className="nav-item">
              <a href="#">
                {m.label}
                {m.items && <ChevronDown size={15} />}
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