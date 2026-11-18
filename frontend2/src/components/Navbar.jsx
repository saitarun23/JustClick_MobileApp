import { LuMapPin, LuShoppingBag, LuMousePointerClick } from "react-icons/lu";
import "../styles/Navbar.css";

export default function Navbar({ count, onCart }) {
  return (
    <header className="nav">
      <div className="wrap nav-in">
        <a className="brand" href="#top"><span className="brand-dot"><LuMousePointerClick /></span>JustClick</a>
        <nav className="links" aria-label="Sections">
          <a href="#browse">Browse</a><a href="#menu">Menu</a><a href="#how">How it works</a>
        </nav>
        <button className="loc"><LuMapPin /> Vizag, Andhra Pradesh</button>
        <button className="cart" onClick={onCart} aria-label={`Open order, ${count} items`}>
          <LuShoppingBag /><span>{count}</span>
        </button>
      </div>
    </header>
  );
}