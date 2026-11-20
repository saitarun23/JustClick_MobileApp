import { Leaf, MapPin, Phone, Mail } from 'lucide-react'

export default function Footer() {
  return (
    <footer className="footer">
      <div className="container footer__inner">
        <div>
          <div className="brand brand--light">
            <span className="brand__mark"><Leaf size={22} /></span>
            <span className="brand__name">farm2bay</span>
          </div>
          <p>Farm fresh dairy, vegetables, pickles and powders, delivered to your city.</p>
        </div>
        <ul>
          <li><MapPin size={16} /> Andhra Pradesh, India</li>
          <li><Phone size={16} /> +91 00000 00000</li>
          <li><Mail size={16} /> hello@farm2bay.com</li>
        </ul>
      </div>
      <div className="footer__copy">© 2026 farm2bay. All rights reserved.</div>
    </footer>
  )
}