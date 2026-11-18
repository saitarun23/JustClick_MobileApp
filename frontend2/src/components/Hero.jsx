import { LuSearch, LuBike, LuClock, LuPackageCheck } from "react-icons/lu";
import "../styles/Hero.css";

export default function Hero({ query, setQuery }) {
  return (
    <section className="hero">
      <div className="hero-copy">
        <h1>One click.<br />Dinner is on its way.</h1>
        <p>Hot meals, fresh fruit and late-night cravings from shops near you, delivered in about 20 minutes.</p>
        <label className="search">
          <LuSearch />
          <input
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Search biryani, coffee, cookies"
          />
        </label>
      </div>

      <div className="hero-art" aria-hidden="true">
        <div className="ring r1" />
        <div className="ring r2" />
        <div className="orb"><LuBike /></div>
        <div className="chip c1"><LuPackageCheck /> Packed at Fornello</div>
        <div className="chip c2"><LuClock /> Arriving in 12 min</div>
      </div>
    </section>
  );
}