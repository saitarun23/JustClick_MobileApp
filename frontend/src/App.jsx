import React, { useState } from 'react';
import Header from './components/Header';
import Footer from './components/Footer';
import LocationModal from './components/LocationModal';
import ProductModal from './components/ProductModal';
import CartDrawer from './components/CartDrawer';
import CheckoutModal from './components/CheckoutModal';

import HomePage from './pages/HomePage';
import ProductDetailPage from './pages/ProductDetailPage';
import CategoryPage from './pages/CategoryPage';
import OrdersTrackPage from './pages/OrdersTrackPage';
import WishlistPage from './pages/WishlistPage';

import { PRODUCTS, LOCATIONS } from './data/mockData';

export default function App() {
  const [activePage, setActivePage] = useState('home'); // 'home', 'product-detail', 'category', 'orders', 'wishlist'
  const [activeCategory, setActiveCategory] = useState('all');
  const [cart, setCart] = useState([]);
  const [cartOpen, setCartOpen] = useState(false);
  const [wishlist, setWishlist] = useState([]);
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [searchQuery, setSearchQuery] = useState('');
  const [heroSlide, setHeroSlide] = useState(0);
  const [currentLocation, setCurrentLocation] = useState(LOCATIONS[0]);
  const [showLocationModal, setShowLocationModal] = useState(false);
  const [checkoutStep, setCheckoutStep] = useState(0);

  // Cart Operations
  const addToCart = (product) => {
    setCart(prev => {
      const existing = prev.find(item => item.id === product.id);
      if (existing) {
        return prev.map(item => 
          item.id === product.id ? { ...item, quantity: item.quantity + 1 } : item
        );
      }
      return [...prev, { ...product, quantity: 1 }];
    });
  };

  const updateQuantity = (productId, delta) => {
    setCart(prev => {
      return prev.map(item => {
        if (item.id === productId) {
          const newQty = item.quantity + delta;
          return newQty > 0 ? { ...item, quantity: newQty } : null;
        }
        return item;
      }).filter(Boolean);
    });
  };

  const toggleWishlist = (productId) => {
    setWishlist(prev => 
      prev.includes(productId) ? prev.filter(id => id !== productId) : [...prev, productId]
    );
  };

  const filteredProducts = PRODUCTS.filter(p => {
    const matchesCategory = activeCategory === 'all' || p.category === activeCategory;
    const matchesSearch = p.name.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesCategory && matchesSearch;
  });

  const cartCount = cart.reduce((acc, item) => acc + item.quantity, 0);
  const subtotal = cart.reduce((acc, item) => acc + (item.price * item.quantity), 0);
  const freeShippingTarget = 25;

  return (
    <div className="min-h-screen bg-[#EEF7F2] font-sans text-slate-900 antialiased flex flex-col justify-between">
      <div>
        {/* Top Header */}
        <Header 
          currentLocation={currentLocation}
          setShowLocationModal={setShowLocationModal}
          searchQuery={searchQuery}
          setSearchQuery={setSearchQuery}
          wishlist={wishlist}
          cartCount={cartCount}
          setCartOpen={setCartOpen}
          activePage={activePage}
          onNavigate={(page) => setActivePage(page)}
        />

        {/* Dynamic Page Router */}
        <main className="max-w-7xl mx-auto px-4 lg:px-8 pt-6">
          {activePage === 'home' && (
            <HomePage 
              heroSlide={heroSlide}
              setHeroSlide={setHeroSlide}
              activeCategory={activeCategory}
              setActiveCategory={setActiveCategory}
              filteredProducts={filteredProducts}
              wishlist={wishlist}
              toggleWishlist={toggleWishlist}
              cart={cart}
              addToCart={addToCart}
              updateQuantity={updateQuantity}
              setSelectedProduct={setSelectedProduct}
              onNavigate={(page) => setActivePage(page)}
            />
          )}

          {activePage === 'product-detail' && (
            <ProductDetailPage 
              product={selectedProduct}
              onBack={() => setActivePage('home')}
              cartItem={cart.find(i => i.id === selectedProduct?.id)}
              addToCart={addToCart}
              updateQuantity={updateQuantity}
              wishlist={wishlist}
              toggleWishlist={toggleWishlist}
              allProducts={PRODUCTS}
              setSelectedProduct={setSelectedProduct}
            />
          )}

          {activePage === 'category' && (
            <CategoryPage 
              activeCategory={activeCategory}
              setActiveCategory={setActiveCategory}
              products={PRODUCTS}
              wishlist={wishlist}
              toggleWishlist={toggleWishlist}
              cart={cart}
              addToCart={addToCart}
              updateQuantity={updateQuantity}
              setSelectedProduct={setSelectedProduct}
              onNavigate={(page) => setActivePage(page)}
            />
          )}

          {activePage === 'orders' && (
            <OrdersTrackPage currentLocation={currentLocation} />
          )}

          {activePage === 'wishlist' && (
            <WishlistPage 
              wishlist={wishlist}
              allProducts={PRODUCTS}
              toggleWishlist={toggleWishlist}
              cart={cart}
              addToCart={addToCart}
              updateQuantity={updateQuantity}
              setSelectedProduct={setSelectedProduct}
              onNavigate={(page) => setActivePage(page)}
            />
          )}
        </main>
      </div>

      {/* Footer Section */}
      <Footer />

      {/* Global Modals & Overlay Drawers */}
      {showLocationModal && (
        <LocationModal 
          currentLocation={currentLocation}
          setCurrentLocation={setCurrentLocation}
          onClose={() => setShowLocationModal(false)}
        />
      )}

      {selectedProduct && activePage !== 'product-detail' && (
        <ProductModal 
          product={selectedProduct}
          onClose={() => setSelectedProduct(null)}
          cartItem={cart.find(i => i.id === selectedProduct.id)}
          addToCart={addToCart}
          updateQuantity={updateQuantity}
        />
      )}

      <CartDrawer 
        isOpen={cartOpen}
        onClose={() => setCartOpen(false)}
        cart={cart}
        updateQuantity={updateQuantity}
        subtotal={subtotal}
        freeShippingTarget={freeShippingTarget}
        onCheckout={() => {
          setCartOpen(false);
          setCheckoutStep(1);
        }}
      />

      {checkoutStep > 0 && (
        <CheckoutModal 
          checkoutStep={checkoutStep}
          setCheckoutStep={setCheckoutStep}
          onClose={() => setCheckoutStep(0)}
          subtotal={subtotal}
          freeShippingTarget={freeShippingTarget}
          onOrderSuccess={() => {
            setCart([]);
            setCheckoutStep(4);
            setActivePage('orders');
          }}
        />
      )}
    </div>
  );
}