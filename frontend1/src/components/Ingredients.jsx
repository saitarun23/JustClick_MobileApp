import { ingredients } from "../data/products";

export default function Ingredients() {
  return (
    <section className="section soft">
      <div className="container">
        <h2 className="title">Made From The Real Stuff</h2>
        <div className="grid four">
          {ingredients.map((i) => (
            <div className="ing" key={i.name}>
              <img
                src={`https://placehold.co/300x260/f6e2b8/5a3e2b?text=${encodeURIComponent(i.name)}`}
                alt={i.name}
              />
              <h4>{i.name}</h4>
              <p>{i.text}</p>
            </div>
          ))}
        </div>
        <div className="center">
          <button className="btn-outline inline">View all products</button>
        </div>
      </div>
    </section>
  );
}