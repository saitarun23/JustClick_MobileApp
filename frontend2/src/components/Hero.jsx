import { LuSearch, LuBike, LuStore, LuHouse } from "react-icons/lu";
import "../styles/Hero.css";

export default function Hero({ query, setQuery }) {
  return (
    <section className="hero wrap">
      <div className="panel">
        <svg className="ripples" viewBox="0 0 400 400" aria-hidden="true">
          {[60, 110, 160, 210, 260].map((r) => <circle key={r} cx="400" cy="400" r={r} />)}
        </svg>
        <div className="panel-copy">
          <h1>Hungry?<br />Click.<br />Done.</h1>
          <p>Meals, fruit and midnight cravings from shops in your area. At your door in about 20 minutes.</p>
        </div>
        <aside className="live" aria-label="Example live order">
          <div className="live-head"><span className="pulse" /> Order #2481 is on the way</div>
          <div className="route">
            <LuStore /><div className="bar"><i /><LuBike className="rider" /></div><LuHouse />
          </div>
          <div className="live-foot"><b>Arriving in 12 min</b><span>Rider: Tarun</span></div>
        </aside>
      </div>
      <label className="search">
        <LuSearch />
        <input value={query} onChange={(e) => setQuery(e.target.value)} placeholder="What are you craving today?" />
        <a href="#menu" className="go">Search</a>
      </label>
    </section>
  );
}