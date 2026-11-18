import { Phone, Mail, MapPin, MousePointerClick, Send } from "lucide-react";

export default function Footer() {
  return (
    <footer className="footer">
      <div className="container foot-grid">
        <div>
          <a href="#" className="logo light">
            <span className="logo-mark"><MousePointerClick size={20} /></span>
            Just<span>Click</span>
          </a>
          <p className="muted about">Farm-fresh dairy, powders, pickles and more, made the traditional way.</p>
          <p className="contact"><Phone size={15} /> +91 90000 00000</p>
          <p className="contact"><Mail size={15} /> hello@justclick.in</p>
          <p className="contact"><MapPin size={15} /> Andhra Pradesh, India</p>
        </div>

        <div>
          <h4>Shop</h4>
          <a href="#">Dairy</a>
          <a href="#">Powders</a>
          <a href="#">Pickles</a>
          <a href="#">Combos</a>
        </div>

        <div>
          <h4>Customer Care</h4>
          <a href="#">Contact Us</a>
          <a href="#">About Us</a>
          <a href="#">Returns &amp; Refunds</a>
          <a href="#">FAQ</a>
        </div>

        <div>
          <h4>Newsletter</h4>
          <div className="news">
            <input placeholder="Your email" />
            <button className="btn" aria-label="Subscribe"><Send size={16} /></button>
          </div>
          <p className="muted">Get offers and new arrivals first.</p>
        </div>
      </div>
      <p className="copy">© 2026 Urmistek. All rights reserved.</p>
    </footer>
  );
}