import { useState } from "react";
import "./App.css";
import { products, combos } from "./data/products";
import Announcement from "./components/Announcement";
import Navbar from "./components/Navbar";
import Hero from "./components/Hero";
import Marquee from "./components/Marquee";
import Categories from "./components/Categories";
import ProductCarousel from "./components/ProductCarousel";
import Collections from "./components/Collections";
import Story from "./components/Story";
import Certifications from "./components/Certifications";
import Ingredients from "./components/Ingredients";
import Testimonials from "./components/Testimonials";
import Footer from "./components/Footer";
import CartDrawer from "./components/CartDrawer";
import FloatingButtons from "./components/FloatingButtons";

export default function App() {
  const [cart, setCart] = useState([]);
  const [open, setOpen] = useState(false);

  const addToCart = (p) => {
    setCart((prev) => {
      const found = prev.find((i) => i.id === p.id);
      return found
        ? prev.map((i) => (i.id === p.id ? { ...i, qty: i.qty + 1 } : i))
        : [...prev, { ...p, qty: 1 }];
    });
    setOpen(true);
  };

  const changeQty = (id, d) =>
    setCart((prev) => prev.map((i) => (i.id === id ? { ...i, qty: Math.max(1, i.qty + d) } : i)));

  const remove = (id) => setCart((prev) => prev.filter((i) => i.id !== id));

  return (
    <>
      <Announcement />
      <Navbar cartCount={cart.reduce((s, i) => s + i.qty, 0)} openCart={() => setOpen(true)} />

      <main className="frame">
        <Hero />
        <Marquee />
        <Categories />
        <ProductCarousel
          title="Featured Products"
          items={products}
          onAdd={addToCart}
          tabs={["All", "Dairy", "Powders", "Pickles", "Others"]}
        />
        <ProductCarousel title="Gift The Right One" items={combos} onAdd={addToCart} soft />
        <Collections />
        <Story />
        <Certifications />
        <Ingredients />
        <Testimonials />
      </main>

      <Footer />
      <FloatingButtons />
      <CartDrawer open={open} close={() => setOpen(false)} cart={cart} changeQty={changeQty} remove={remove} />
    </>
  );
}