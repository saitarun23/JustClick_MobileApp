import { useEffect, useState } from "react";
import { ChevronLeft, ChevronRight, ArrowRight } from "lucide-react";

const slides = [
  { title: "Pure A2 Cow Ghee", sub: "Slow-churned the traditional way.", bg: "#f8ecd0", btn: "Shop Dairy" },
  { title: "Homemade Pickles", sub: "Sun-matured, cold-pressed oil, zero preservatives.", bg: "#f2d6ca", btn: "Shop Pickles" },
  { title: "Freshly Ground Powders", sub: "Stone-ground turmeric, chilli and podis.", bg: "#f3e2bd", btn: "Shop Powders" },
];

export default function Hero() {
  const [i, setI] = useState(0);
  const next = () => setI((p) => (p + 1) % slides.length);
  const prev = () => setI((p) => (p - 1 + slides.length) % slides.length);

  useEffect(() => {
    const t = setInterval(next, 4500);
    return () => clearInterval(t);
  }, []);

  return (
    <section className="hero">
      {slides.map((s, idx) => (
        <div key={idx} className={`slide ${idx === i ? "active" : ""}`} style={{ background: s.bg }}>
          <div className="container slide-inner">
            <div>
              <p className="eyebrow">Just Click · Fresh &amp; Pure</p>
              <h1>{s.title}</h1>
              <p className="sub">{s.sub}</p>
              <button className="btn">
                {s.btn} <ArrowRight size={16} />
              </button>
            </div>
            <img
              src={`https://placehold.co/520x420/ffffff/5a3e2b?text=${encodeURIComponent(s.title)}`}
              alt={s.title}
            />
          </div>
        </div>
      ))}

      <button className="arrow left" onClick={prev} aria-label="Previous"><ChevronLeft size={22} /></button>
      <button className="arrow right" onClick={next} aria-label="Next"><ChevronRight size={22} /></button>

      <div className="dots">
        {slides.map((_, idx) => (
          <button key={idx} className={idx === i ? "dot on" : "dot"} onClick={() => setI(idx)} aria-label={`Slide ${idx + 1}`} />
        ))}
      </div>
    </section>
  );
}