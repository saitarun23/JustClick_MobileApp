import { LuCheck } from "react-icons/lu";
import "../styles/Tracker.css";

const STEPS = ["Pick", "Click", "Packed", "At your door"];

export default function Tracker() {
  return (
    <section className="track" aria-label="How an order moves">
      {STEPS.map((s, i) => (
        <div className="track-step" key={s}>
          <span className="track-dot">{i < 2 ? <LuCheck /> : ""}</span>
          <span>{s}</span>
        </div>
      ))}
    </section>
  );
}