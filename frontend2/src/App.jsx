import { useMemo, useState } from "react";
import Navbar from "./components/Navbar";
import Hero from "./components/Hero";
import Tracker from "./components/Tracker";
import Categories from "./components/Categories";
import Products from "./components/Products";
import Cart from "./components/Cart";
import Footer from "./components/Footer";
import { PRODUCTS } from "./data/products";

export default function App() {
  const [cat, setCat] = useState("all");
  const [query, setQuery] = useState("");
  const [cart, setCart] = useState({});
  const [open, setOpen] = useState(false);
  const [placed, setPlaced] = useState(false);

  const add = (id) => setCart((c) => ({ ...c, [id]: (c[id] || 0) + 1 }));
  const remove = (id) =>
    setCart((c) => {
      const n = { ...c, [id]: (c[id] || 0) - 1 };
      if (n[id] <= 0) delete n[id];
      return n;
    });

  const shown = useMemo(
    () =>
      PRODUCTS.filter(
        (p) =>
          (cat === "all" || p.cat === cat) &&
          (p.name + p.shop).toLowerCase().includes(query.toLowerCase())
      ),
    [cat, query]
  );

  const count = Object.values(cart).reduce((s, n) => s + n, 0);

  const placeOrder = () => {
    setPlaced(true);
    setCart({});
  };
  const closeCart = () => {
    setOpen(false);
    setPlaced(false);
  };

  return (
    <>
      <Navbar count={count} onCartClick={() => setOpen(true)} />
      <main id="top">
        <Hero query={query} setQuery={setQuery} />
        <Tracker />
        <section className="shelf">
          <Categories active={cat} onChange={setCat} />
          <Products products={shown} cart={cart} query={query} onAdd={add} onRemove={remove} />
        </section>
      </main>
      <Footer />
      <Cart
        open={open}
        cart={cart}
        placed={placed}
        onAdd={add}
        onRemove={remove}
        onPlace={placeOrder}
        onClose={closeCart}
      />
    </>
  );
}