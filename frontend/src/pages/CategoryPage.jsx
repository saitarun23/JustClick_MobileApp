import React, { useState } from 'react';
import ProductCard from '../components/ProductCard';
import { CATEGORIES } from '../data/mockData';
import { SlidersHorizontal, ArrowUpDown } from 'lucide-react';

export default function CategoryPage({ 
  activeCategory, 
  setActiveCategory, 
  products, 
  wishlist, 
  toggleWishlist, 
  cart, 
  addToCart, 
  updateQuantity, 
  setSelectedProduct,
  onNavigate 
}) {
  const [sortBy, setSortBy] = useState('popular');

  const currentCategoryObj = CATEGORIES.find(c => c.id === activeCategory) || CATEGORIES[0];

  let filtered = products.filter(p => activeCategory === 'all' || p.category === activeCategory);

  if (sortBy === 'price-low') {
    filtered = [...filtered].sort((a, b) => a.price - b.price);
  } else if (sortBy === 'price-high') {
    filtered = [...filtered].sort((a, b) => b.price - a.price);
  } else if (sortBy === 'rating') {
    filtered = [...filtered].sort((a, b) => b.rating - a.rating);
  }

  return (
    <div className="space-y-6">
      {/* Category Banner */}
      <div className="bg-gradient-to-r from-emerald-900 to-emerald-950 rounded-3xl p-8 text-white flex items-center justify-between shadow-xl relative overflow-hidden">
        <div className="space-y-2 z-10 max-w-lg">
          <span className="text-xs font-extrabold uppercase tracking-widest text-emerald-300">Category Catalog</span>
          <h2 className="text-3xl font-black">{currentCategoryObj.name}</h2>
          <p className="text-xs text-emerald-100 leading-relaxed">
            All items are inspected daily by our darkstore specialists before packing. Guaranteed fresh.
          </p>
        </div>
        <img 
          src={currentCategoryObj.image} 
          alt={currentCategoryObj.name} 
          className="w-32 h-32 rounded-2xl object-cover shadow-2xl opacity-90 hidden sm:block border-2 border-white/20"
        />
      </div>

      {/* Category Filter Pills & Sort Bar */}
      <div className="bg-white p-4 rounded-2xl border border-slate-200/80 shadow-sm flex flex-col sm:flex-row items-center justify-between gap-4">
        {/* Category Pills */}
        <div className="flex items-center gap-2 overflow-x-auto w-full sm:w-auto pb-1 sm:pb-0 scrollbar-none">
          {CATEGORIES.map(cat => (
            <button
              key={cat.id}
              onClick={() => setActiveCategory(cat.id)}
              className={`px-4 py-2 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                activeCategory === cat.id
                  ? 'bg-emerald-600 text-white shadow-md shadow-emerald-600/20'
                  : 'bg-slate-100 text-slate-700 hover:bg-slate-200'
              }`}
            >
              {cat.name} ({cat.count})
            </button>
          ))}
        </div>

        {/* Sort Selector */}
        <div className="flex items-center gap-2 self-end sm:self-auto">
          <ArrowUpDown className="w-4 h-4 text-slate-400" />
          <select 
            value={sortBy}
            onChange={(e) => setSortBy(e.target.value)}
            className="bg-slate-50 border border-slate-200 rounded-xl px-3 py-2 text-xs font-bold text-slate-700 focus:outline-none focus:ring-2 focus:ring-emerald-500"
          >
            <option value="popular">Most Popular</option>
            <option value="price-low">Price: Low to High</option>
            <option value="price-high">Price: High to Low</option>
            <option value="rating">Highest Rated</option>
          </select>
        </div>
      </div>

      {/* Product Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
        {filtered.map(product => {
          const cartItem = cart.find(i => i.id === product.id);
          return (
            <ProductCard 
              key={product.id}
              product={product}
              wishlist={wishlist}
              toggleWishlist={toggleWishlist}
              cartItem={cartItem}
              addToCart={addToCart}
              updateQuantity={updateQuantity}
              setSelectedProduct={(prod) => {
                setSelectedProduct(prod);
                onNavigate('product-detail');
              }}
            />
          );
        })}
      </div>
    </div>
  );
}