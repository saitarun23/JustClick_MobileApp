import { CATEGORIES } from "../data/products";
import "../styles/Bento.css";

export default function Bento({ active, onPick }) {
  return (
    <section id="browse" className="wrap bento-sec">
      <h2 className="h2">Pick a shelf</h2>
      <div className="bento">
        {CATEGORIES.map(({ id, label, note, icon: Icon, tone, size }) => (
          <button key={id} className={`tile ${tone} ${size} ${active === id ? "on" : ""}`} onClick={() => onPick(id)} aria-pressed={active === id}>
            <span className="tile-label">{label}</span>
            <span className="tile-note">{note}</span>
            <Icon className="tile-icon" aria-hidden="true" />
          </button>
        ))}
      </div>
    </section>
  );
}