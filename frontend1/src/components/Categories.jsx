import Carousel from "./Carousel";

const cats = [
  { name: "Dairy", bg: "ffe9f1" },
  { name: "Powders", bg: "ffd9e8" },
  { name: "Pickles", bg: "ffc9de" },
  { name: "Spices", bg: "ffdce9" },
  { name: "Honey & Oils", bg: "fbe0ec" },
  { name: "Snacks", bg: "ffd2e4" },
  { name: "Combos", bg: "ffe3ee" },
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
                src={`https://placehold.co/400x440/${c.bg}/b0335f?text=${encodeURIComponent(c.name)}`}
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