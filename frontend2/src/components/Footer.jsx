import "../styles/Footer.css";

export default function Footer() {
  return (
    <footer className="foot">
      <div className="wrap">
        <p className="mark">JustClick</p>
        <div className="foot-row">
          <p>Delivery. Made for quick</p>
          <nav aria-label="Footer"><a href="#browse">Browse</a><a href="#menu">Menu</a><a href="#how">How it works</a></nav>
        </div>
      </div>
    </footer>
  );
}