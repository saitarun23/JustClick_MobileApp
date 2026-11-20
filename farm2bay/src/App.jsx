import React, { useMemo, useState } from 'react';
import { CATEGORIES, PRODUCTS } from './data/products';
import {
  ProductIllustration,
  WoodenCrateHeroIllustration,
} from './components/Illustrations';
import SplashScreen from './components/SplashScreen';
import HowItWorks from './components/HowItWorks';
import CartDrawer from './components/CartDrawer';

export default function App() {
  const [showSplash, setShowSplash] = useState(true);
  const [activeCategory, setActiveCategory] = useState('all');
  const [searchQuery, setSearchQuery] = useState('');
  const [cart, setCart] = useState({
    'dairy-1': 1,
    'veg-1': 1,
    'pickle-1': 1,
  });
  const [cartOpen, setCartOpen] = useState(false);

  const filteredProducts = useMemo(() => {
    return PRODUCTS.filter((product) => {
      const matchesCat = activeCategory === 'all' || product.category === activeCategory;
      const matchesQuery =
        product.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        product.origin.toLowerCase().includes(searchQuery.toLowerCase());
      return matchesCat && matchesQuery;
    });
  }, [activeCategory, searchQuery]);

  const cartItems = useMemo(() => {
    return Object.entries(cart)
      .filter(([, qty]) => qty > 0)
      .map(([id, qty]) => {
        const product = PRODUCTS.find((p) => p.id === id);
        return product ? { ...product, qty } : null;
      })
      .filter(Boolean);
  }, [cart]);

  const totalCount = cartItems.reduce((sum, item) => sum + item.qty, 0);

  const updateQty = (id, nextQty) => {
    setCart((prev) => {
      const updated = { ...prev };
      if (nextQty <= 0) {
        delete updated[id];
      } else {
        updated[id] = nextQty;
      }
      return updated;
    });
  };

  return (
    <div className="app-shell">
      {showSplash && <SplashScreen onFinish={() => setShowSplash(false)} />}

      {/* Sticky Header */}
      <header className="navbar">
        <div className="container nav-inner">
          <a href="#top" className="brand-logo">
            <span className="brand-badge">🌿</span>
            <span className="brand-text">
              Farm<strong>2</strong>Bay
            </span>
          </a>

          <nav className="nav-links">
            <a href="#market">Market</a>
            <a href="#how-it-works">How It Works</a>
            <button
              type="button"
              className="replay-btn"
              onClick={() => setShowSplash(true)}
              title="Replay Farm-to-City Truck Intro"
            >
              🚚 Replay Intro
            </button>
          </nav>

          <button
            type="button"
            className="cart-trigger-btn"
            onClick={() => setCartOpen(true)}
          >
            <span>🧺 Basket</span>
            <span className="cart-count-pill">{totalCount}</span>
          </button>
        </div>
      </header>

      {/* Main Hero Banner (City Skyline Line-Art + Hands Holding Crate) */}
      <main id="top">
        <section className="hero-section">
          <div className="city-backdrop-pattern" aria-hidden="true" />
          <div className="container hero-grid">
            <div className="hero-copy">
              <span className="eyebrow-tag">DIRECT FARMER&apos;S MARKET • CITY DELIVERY</span>
              <h1>
                Organic Harvest, <span>Fresh From Farm</span> to Your Bay.
              </h1>
              <p>
                Order pure A2 dairy products, morning-harvested vegetables, traditional sun-cured
                pickles, and stone-ground spice powders delivered straight from local farms.
              </p>

              <div className="hero-actions">
                <a href="#market" className="primary-btn">
                  Shop Farm Harvest
                </a>
                <a href="#how-it-works" className="secondary-btn">
                  See How It Works
                </a>
              </div>

              <div className="hero-trust-row">
                <div>
                  <strong>100%</strong>
                  <span>Farm Direct</span>
                </div>
                <div>
                  <strong>6 AM</strong>
                  <span>Daily Harvest</span>
                </div>
                <div>
                  <strong>Glass & Crate</strong>
                  <span>Eco Packaging</span>
                </div>
              </div>
            </div>

            <div className="hero-art-card">
              <WoodenCrateHeroIllustration />
            </div>
          </div>
        </section>

        {/* Product Marketplace Section */}
        <section id="market" className="market-section">
          <div className="container">
            <div className="market-header">
              <div>
                <span className="eyebrow-tag">TODAY&apos;S TRUCK ARRIVAL</span>
                <h2>Explore Farm2Bay Market</h2>
              </div>

              <div className="search-box">
                <input
                  type="search"
                  placeholder="Search milk, tomatoes, avakaya, turmeric..."
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                />
              </div>
            </div>

            {/* Category Filter Pills */}
            <div className="category-bar" role="tablist">
              {CATEGORIES.map((cat) => (
                <button
                  key={cat.id}
                  type="button"
                  className={`cat-pill ${activeCategory === cat.id ? 'active' : ''}`}
                  onClick={() => setActiveCategory(cat.id)}
                >
                  {cat.label}
                </button>
              ))}
            </div>

            {/* Product Grid */}
            <div className="product-grid">
              {filteredProducts.map((product) => {
                const qty = cart[product.id] || 0;
                return (
                  <article key={product.id} className="product-card">
                    <div className="card-top-meta">
                      <span className="card-badge">{product.badge}</span>
                      <span className="card-cat-tag">{product.categoryLabel}</span>
                    </div>

                    <div className="card-art-wrap">
                      <ProductIllustration
                        category={product.category}
                        accent={product.accent}
                      />
                    </div>

                    <div className="card-body">
                      <p className="card-origin">From {product.origin}</p>
                      <h3>{product.name}</h3>
                      <p className="card-unit">{product.unit}</p>

                      <div className="card-footer">
                        <span className="card-price">₹{product.price}</span>

                        {qty === 0 ? (
                          <button
                            type="button"
                            className="add-btn"
                            onClick={() => updateQty(product.id, 1)}
                          >
                            + Add
                          </button>
                        ) : (
                          <div className="qty-stepper">
                            <button
                              type="button"
                              onClick={() => updateQty(product.id, qty - 1)}
                            >
                              −
                            </button>
                            <span>{qty}</span>
                            <button
                              type="button"
                              onClick={() => updateQty(product.id, qty + 1)}
                            >
                              +
                            </button>
                          </div>
                        )}
                      </div>
                    </div>
                  </article>
                );
              })}
            </div>
          </div>
        </section>

        {/* How It Works Visual Story */}
        <HowItWorks />
      </main>

      {/* Footer */}
      <footer className="site-footer">
        <div className="container footer-inner">
          <div>
            <span className="brand-text footer-brand">
              Farm<strong>2</strong>Bay
            </span>
            <p>Connecting rural farmers directly with city kitchens every morning.</p>
          </div>
          <p className="footer-note">
            Dairy Products • Vegetables • Pickles • Powdered Products • Farm Essentials
          </p>
        </div>
      </footer>

      {/* Slide-Over Cart Drawer */}
      <CartDrawer
        isOpen={cartOpen}
        onClose={() => setCartOpen(false)}
        cartItems={cartItems}
        onUpdateQty={updateQty}
        onClearCart={() => setCart({})}
      />
    </div>
  );
}