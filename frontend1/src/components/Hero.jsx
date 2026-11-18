import { useEffect, useState } from "react";
import { ChevronLeft, ChevronRight, ArrowRight, Leaf, Droplets, ShieldCheck, Flame, Wheat, Citrus, Sprout, Gift } from "lucide-react";

const slides = [
  {
    kicker: "A Pure",
    title: "A2 Cow Ghee",
    sub: "Slow-churned the traditional way for rich aroma and golden taste.",
    bg: "linear-gradient(120deg,#ffe9f1 0%,#ffc9de 100%)",
    perks: [[Leaf, "Farm Fresh"], [Droplets, "Slow Churned"], [ShieldCheck, "No Preservatives"]],
    btn: "Shop Dairy",
  },
  {
    kicker: "Homemade",
    title: "Sun-Matured Pickles",
    sub: "Cold-pressed oil, hand-ground spices and zero preservatives.",
    bg: "linear-gradient(120deg,#fff0f5 0%,#ffbfd8 100%)",
    perks: [[Citrus, "Raw Mangoes"], [Flame, "Bold Spice"], [Sprout, "Small Batch"]],
    btn: "Shop Pickles",
  },
  {
    kicker: "Freshly Ground",
    title: "Stone-Ground Powders",
    sub: "Turmeric, chilli, podis and health mixes, made every week.",
    bg: "linear-gradient(120deg,#ffeef4 0%,#ffb3d1 100%)",
    perks: [[Wheat, "Stone Ground"], [Leaf, "100% Natural"], [Gift, "Gift Ready"]],
    btn: "Shop Powders",
  },
];

export default function Hero() {
  const [i, setI] = useState(0);
  const next = () => setI((p) => (p + 1) % slides.length);
  const prev = () => setI((p) => (p - 1 + slides.length) % slides.length);

  useEffect(() => {
    const t = setInterval(next, 5000);
    return () => clearInterval(t);
  }, []);

  return (
    <section className="hero">
      {slides.map((s, idx) => (
        <div key={idx} className={`slide ${idx === i ? "active" : ""}`} style={{ background: s.bg }}>
          <div className="slide-inner">
            <div className="slide-text">
              <p className="kicker"><span>{s.kicker}</span></p>
              <h1>{s.title}</h1>
              <p className="sub">{s.sub}</p>
              <div className="perks">
                {s.perks.map(([Icon, label]) => (
                  <div className="perk" key={label}>
                    <Icon size={30} strokeWidth={1.4} />
                    <span>{label}</span>
                  </div>
                ))}
              </div>
              <button className="btn">{s.btn} <ArrowRight size={16} /></button>
            </div>

            <div className="hero-img">
              <img
                src={`https://placehold.co/560x520/fff5f9/b0335f?text=${encodeURIComponent(s.title)}`}
                alt={s.title}
              />
            </div>
          </div>
        </div>
      ))}

      <button className="hero-arrow left" onClick={prev} aria-label="Previous"><ChevronLeft size={36} strokeWidth={1.4} /></button>
      <button className="hero-arrow right" onClick={next} aria-label="Next"><ChevronRight size={36} strokeWidth={1.4} /></button>

      <div className="dashes hero-dashes">
        {slides.map((_, idx) => (
          <button key={idx} className={idx === i ? "dash on" : "dash"} onClick={() => setI(idx)} aria-label={`Slide ${idx + 1}`} />
        ))}
      </div>
    </section>
  );
}