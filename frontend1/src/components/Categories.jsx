import Carousel from "./Carousel";

const cats = [
  { name: "Dairy", bg: "EAF5D8" },
  { name: "Powders", bg: "DFF0C2" },
  { name: "Pickles", bg: "D4EAAE" },
  { name: "Spices", bg: "E3F2CB" },
  { name: "Honey & Oils", bg: "E8F3D3" },
  { name: "Snacks", bg: "DBEDBA" },
  { name: "Combos", bg: "EDF6DD" },
];

export default function Categories() {
  return (
    <section className="section">
      <h2 className="title">Shop By Category</h2>
      <Carousel>
        {cats.map((c) => (
          <a href="#" className="cat-card" key={c.name}>
            <div className="cat-frame">
              <img
                src={`https://placehold.co/400x440/${c.bg}/3F6A0C?text=${encodeURIComponent(c.name)}`}
                alt={c.name}
              />
            </div>
            <h3>{c.name}</h3>
          </a>
        ))}
      </Carousel>
    </section>
  );
}