import { LuMousePointerClick } from "react-icons/lu";
import "../styles/Footer.css";

export default function Footer() {
  return (
    <footer className="foot">
      <span className="logo small">
        <span className="logo-dot"><LuMousePointerClick /></span>JustClick
      </span>
      <p>Delivery from local shops. Made for quick evenings.</p>
    </footer>
  );
}