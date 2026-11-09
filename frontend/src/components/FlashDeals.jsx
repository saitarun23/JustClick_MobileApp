import React from 'react';
import { Zap, Clock, ShieldCheck, Flame } from 'lucide-react';

export default function FlashDeals() {
  return (
    <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
      <div className="bg-gradient-to-r from-amber-500 to-amber-600 rounded-2xl p-4 text-white flex items-center justify-between shadow-md">
        <div>
          <div className="flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-amber-100 mb-1">
            <Zap className="w-4 h-4 fill-current" />
            <span>Flash Deal</span>
          </div>
          <h4 className="font-extrabold text-lg leading-tight">Bundle & Save 25%</h4>
          <p className="text-xs text-amber-100">Breakfast Kits starting at ₹9.99</p>
        </div>
        <Flame className="w-10 h-10 opacity-30" />
      </div>

      <div className="bg-gradient-to-r from-emerald-600 to-teal-600 rounded-2xl p-4 text-white flex items-center justify-between shadow-md">
        <div>
          <div className="flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-emerald-100 mb-1">
            <Clock className="w-4 h-4" />
            <span>Guaranteed Speed</span>
          </div>
          <h4 className="font-extrabold text-lg leading-tight">Artisan Dairy Duo</h4>
          <p className="text-xs text-emerald-100">Fresh morning delivery under 10m</p>
        </div>
        <ShieldCheck className="w-10 h-10 opacity-30" />
      </div>

      <div className="bg-gradient-to-r from-rose-500 to-pink-600 rounded-2xl p-4 text-white flex items-center justify-between shadow-md">
        <div>
          <div className="flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-rose-100 mb-1">
            <Flame className="w-4 h-4" />
            <span>Chef's Choice</span>
          </div>
          <h4 className="font-extrabold text-lg leading-tight">Chef Pantry Pack</h4>
          <p className="text-xs text-rose-100">Cold-pressed oils & fresh herbs</p>
        </div>
        <Zap className="w-10 h-10 opacity-30" />
      </div>
    </div>
  );
}