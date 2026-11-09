import React from 'react';
import { ShoppingBag, MapPin, Search, Heart, Clock, ChevronDown, PackageCheck, Grid } from 'lucide-react';

export default function Header({ 
  currentLocation, 
  setShowLocationModal, 
  searchQuery, 
  setSearchQuery, 
  wishlist, 
  cartCount, 
  setCartOpen,
  activePage,
  onNavigate 
}) {
  return (
    <header className="bg-white/95 backdrop-blur-md border-b border-emerald-100/60 sticky top-0 z-40 shadow-sm">
      <div className="max-w-7xl mx-auto px-4 lg:px-8 py-3.5 flex items-center justify-between gap-4">
        
        {/* Brand Logo & Location */}
        <div className="flex items-center gap-6">
          <div 
            onClick={() => onNavigate('home')}
            className="flex items-center gap-2.5 cursor-pointer group"
          >
            <div className="bg-emerald-600 text-white p-2.5 rounded-2xl shadow-md shadow-emerald-600/30 group-hover:scale-105 transition-transform">
              <ShoppingBag className="w-6 h-6" />
            </div>
            <div>
              <div className="flex items-center gap-1.5">
                <span className="font-extrabold text-2xl tracking-tight text-emerald-950">JustClick</span>
                {/* <span className="text-[10px] font-bold uppercase tracking-wider bg-emerald-100 text-emerald-800 px-2 py-0.5 rounded-full">Prime</span> */}
              </div>
            </div>
          </div>

          <button 
            onClick={() => setShowLocationModal(true)}
            className="hidden md:flex items-center gap-2.5 bg-emerald-50/80 hover:bg-emerald-100/80 px-3.5 py-2 rounded-xl text-left border border-emerald-200/60 transition-all group"
          >
            <MapPin className="w-4 h-4 text-emerald-600 group-hover:scale-110 transition-transform" />
            <div>
              <div className="text-[10px] text-emerald-700 font-semibold uppercase tracking-wider flex items-center gap-1">
                <span>Deliver to</span>
                <ChevronDown className="w-3 h-3 text-emerald-600" />
              </div>
              <div className="text-xs font-bold text-emerald-950 flex items-center gap-1.5">
                <span>{currentLocation.city}</span>
                {/* <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span> */}
                {/* <span className="text-[11px] font-medium text-emerald-700">12 Mins</span> */}
              </div>
            </div>
          </button>
        </div>

        {/* Global Search Bar */}
        <div className="flex-1 max-w-xl relative hidden sm:block">
          <Search className="w-4 h-4 absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400" />
          <input 
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search organic strawberries, sourdough, pasture eggs..."
            className="w-full bg-slate-50 border border-slate-200/80 pl-10 pr-4 py-2 rounded-xl text-xs font-medium focus:outline-none focus:ring-2 focus:ring-emerald-500/30 focus:border-emerald-500 text-slate-800 transition-all"
          />
        </div>

        {/* Page Navigation Links & Cart Dock */}
        <div className="flex items-center gap-2 sm:gap-3">
          <button 
            onClick={() => onNavigate('category')}
            className={`p-2.5 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5 ${
              activePage === 'category' ? 'bg-emerald-100 text-emerald-900' : 'text-slate-600 hover:bg-slate-100'
            }`}
          >
            <Grid className="w-4 h-4" />
            <span className="hidden md:inline">Products</span>
          </button>

          <button 
            onClick={() => onNavigate('orders')}
            className={`p-2.5 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5 ${
              activePage === 'orders' ? 'bg-emerald-100 text-emerald-900' : 'text-slate-600 hover:bg-slate-100'
            }`}
          >
            <PackageCheck className="w-4 h-4" />
            <span className="hidden md:inline">Orders</span>
          </button>

          <button 
            onClick={() => onNavigate('wishlist')}
            className={`relative p-2.5 rounded-xl transition-all ${
              activePage === 'wishlist' ? 'bg-rose-100 text-rose-900' : 'text-slate-600 hover:bg-slate-100'
            }`}
          >
            <Heart className="w-5 h-5" />
            {wishlist.length > 0 && (
              <span className="absolute top-1 right-1 w-4 h-4 bg-rose-500 text-white text-[10px] font-bold rounded-full flex items-center justify-center">
                {wishlist.length}
              </span>
            )}
          </button>

          <button 
            onClick={() => setCartOpen(true)}
            className="flex items-center gap-2 bg-emerald-600 hover:bg-emerald-700 text-white px-4 py-2 rounded-xl font-extrabold text-xs shadow-md shadow-emerald-600/20 transition-all hover:scale-105 active:scale-95"
          >
            <ShoppingBag className="w-4 h-4" />
            <span>Bag</span>
            <span className="bg-white/20 text-white text-[11px] px-2 py-0.5 rounded-full">
              {cartCount}
            </span>
          </button>
        </div>
      </div>
    </header>
  );
}