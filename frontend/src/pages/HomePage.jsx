import React from 'react';
import HeroCarousel from '../components/HeroCarousel';
import CategoryRail from '../components/CategoryRail';
import FlashDeals from '../components/FlashDeals';
import ProductCard from '../components/ProductCard';

export default function HomePage({ 
  heroSlide, 
  setHeroSlide, 
  activeCategory, 
  setActiveCategory, 
  filteredProducts, 
  wishlist, 
  toggleWishlist, 
  cart, 
  addToCart, 
  updateQuantity, 
  setSelectedProduct,
  onNavigate
}) {
  return (
    <div className="space-y-8">
      {/* Hero Carousel */}
      <HeroCarousel heroSlide={heroSlide} setHeroSlide={setHeroSlide} />

      {/* Main Content Layout */}
      <div className="flex flex-col md:flex-row gap-8">
        {/* Category Sidebar */}
        <CategoryRail 
          activeCategory={activeCategory} 
          setActiveCategory={(catId) => {
            setActiveCategory(catId);
            if (catId !== 'all') onNavigate('category');
          }} 
        />

        {/* Products Grid Section */}
        <div className="flex-1 min-w-0 space-y-6">
          <FlashDeals />

          <div className="flex items-center justify-between">
            <div>
              <h3 className="text-xl font-black text-slate-900 tracking-tight">
                {activeCategory === 'all' ? 'Fresh Harvest Picks' : 'Filtered Selection'}
              </h3>
              <p className="text-xs text-slate-500">Handpicked organic essentials ready for instant dispatch</p>
            </div>
            <span className="text-xs font-bold text-emerald-800 bg-emerald-100/70 px-3 py-1 rounded-full">
              {filteredProducts.length} items available
            </span>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
            {filteredProducts.map((product) => {
              const cartItem = cart.find((i) => i.id === product.id);
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
      </div>
    </div>
  );
}