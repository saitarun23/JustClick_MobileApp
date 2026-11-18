import { LuMapPin, LuShoppingBag, LuMousePointerClick } from "react-icons/lu";
import "../styles/Navbar.css";

export default function Navbar({ count, onCartClick }) {
  return (
    <header className="nav">
      <a className="logo" href="#top" aria-label="JustClick home">
        <span className="logo-dot"><LuMousePointerClick /></span>
        JustClick
      </a>
      <button className="loc"><LuMapPin /> Vizag, Andhra Pradesh</button>
      <button className="bag" onClick={onCartClick} aria-label={`Open cart, ${count} items`}>
        <LuShoppingBag />
        {count > 0 && <span className="bag-count">{count}</span>}
      </button>
    </header>
  );
}