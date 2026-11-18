import { useMemo, useState } from "react";
import Navbar from "./components/Navbar";
import Hero from "./components/Hero";
import Bento from "./components/Bento";
import Menu from "./components/Menu";
import Steps from "./components/Steps";
import Footer from "./components/Footer";
import Cart from "./components/Cart";
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
    () => PRODUCTS.filter((p) => (cat === "all" || p.cat === cat) && (p.name + p.shop).toLowerCase().includes(query.toLowerCase())),
    [cat, query]
  );
  const count = Object.values(cart).reduce((s, n) => s + n, 0);

  const pick = (id) => {
    setCat((c) => (c === id ? "all" : id));
    setTimeout(() => document.getElementById("menu")?.scrollIntoView({ behavior: "smooth" }), 50);
  };
  const closeCart = () => { setOpen(false); setPlaced(false); };

  return (
    <>
      <Navbar count={count} onCart={() => setOpen(true)} />
      <main id="top">
        <Hero query={query} setQuery={setQuery} />
        <Bento active={cat} onPick={pick} />
        <Menu products={shown} cart={cart} cat={cat} query={query} onAdd={add} onRemove={remove} onClear={() => { setCat("all"); setQuery(""); }} />
        <Steps />
      </main>
      <Footer />
      <Cart open={open} cart={cart} placed={placed} onAdd={add} onRemove={remove} onPlace={() => { setPlaced(true); setCart({}); }} onClose={closeCart} />
    </>
  );
}