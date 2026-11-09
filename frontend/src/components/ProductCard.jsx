import React from 'react';
import { Star, Heart, Clock, Plus, Minus } from 'lucide-react';

export default function ProductCard({ 
  product, 
  wishlist, 
  toggleWishlist, 
  cartItem, 
  addToCart, 
  updateQuantity, 
  setSelectedProduct 
}) {
  return (
    <div className="bg-white rounded-2xl border border-slate-200/80 overflow-hidden hover:shadow-xl transition-all duration-300 flex flex-col group">
      
      {/* Product Image & Badges */}
      <div className="relative aspect-square overflow-hidden bg-slate-50 cursor-pointer" onClick={() => setSelectedProduct(product)}>
        <img 
          src={product.image} 
          alt={product.name}
          className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
        />
        
        <div className={`absolute top-3 left-3 ${product.badgeColor} text-white text-[10px] font-bold px-2.5 py-1 rounded-full shadow-md uppercase tracking-wider`}>
          {product.badge}
        </div>

        <button 
          onClick={(e) => {
            e.stopPropagation();
            toggleWishlist(product.id);
          }}
          className="absolute top-3 right-3 p-2 rounded-full bg-white/80 backdrop-blur-md text-slate-400 hover:text-rose-500 hover:bg-white shadow-sm transition-colors"
        >
          <Heart className={`w-4 h-4 ${wishlist.includes(product.id) ? 'fill-rose-500 text-rose-500' : ''}`} />
        </button>

        <div className="absolute bottom-3 left-3 bg-white/90 backdrop-blur-md text-emerald-950 text-[11px] font-bold px-2 py-0.5 rounded-lg border border-slate-200/60 flex items-center gap-1 shadow-sm">
          <Clock className="w-3 h-3 text-emerald-600" />
          <span>{product.eta}</span>
        </div>
      </div>

      {/* Product Info */}
      <div className="p-4 flex-1 flex flex-col justify-between">
        <div>
          <div className="flex items-center gap-1 text-amber-500 mb-1">
            <Star className="w-3.5 h-3.5 fill-current" />
            <span className="text-xs font-bold">{product.rating}</span>
            <span className="text-slate-400 text-xs">({product.reviews})</span>
          </div>

          <h3 
            onClick={() => setSelectedProduct(product)}
            className="font-bold text-slate-900 text-sm leading-snug hover:text-emerald-600 transition-colors cursor-pointer line-clamp-2 mb-1"
          >
            {product.name}
          </h3>

          <p className="text-xs text-slate-400 mb-3">{product.unit}</p>
        </div>

        {/* Pricing & Add to Cart Controls */}
        <div className="flex items-center justify-between pt-2 border-t border-slate-100">
          <div>
            <div className="text-xs text-slate-400 line-through">₹{product.originalPrice.toFixed(2)}</div>
            <div className="text-base font-extrabold text-emerald-950">₹{product.price.toFixed(2)}</div>
          </div>

          {cartItem ? (
            <div className="flex items-center gap-2 bg-emerald-50 border border-emerald-200 rounded-xl p-1">
              <button 
                onClick={() => updateQuantity(product.id, -1)}
                className="w-7 h-7 rounded-lg bg-white text-emerald-700 flex items-center justify-center font-bold shadow-sm hover:bg-emerald-100"
              >
                <Minus className="w-3.5 h-3.5" />
              </button>
              <span className="font-extrabold text-sm text-emerald-950 px-1">{cartItem.quantity}</span>
              <button 
                onClick={() => updateQuantity(product.id, 1)}
                className="w-7 h-7 rounded-lg bg-emerald-600 text-white flex items-center justify-center font-bold shadow-sm hover:bg-emerald-700"
              >
                <Plus className="w-3.5 h-3.5" />
              </button>
            </div>
          ) : (
            <button 
              onClick={() => addToCart(product)}
              className="bg-emerald-50 hover:bg-emerald-600 text-emerald-700 hover:text-white border border-emerald-200 hover:border-emerald-600 px-3 py-2 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5 shadow-sm"
            >
              <Plus className="w-3.5 h-3.5" />
              <span>Add</span>
            </button>
          )}
        </div>
      </div>
    </div>
  );
}